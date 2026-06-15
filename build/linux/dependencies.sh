#! /bin/env bash

set -e # if there is an error, exits the building script (See specifics of set -e)


# ---------- utils SECTION ----------
C_RST='\033[0m' # Color ReSeT
C_R='\033[31m' # Color Red
C_G='\033[32m' # Color Green
C_Y='\033[33m' # Color Yellow
C_B='\033[34m' # Color Blue

EXIT_SUCCESS=0
EXIT_FAILURE=1


msgError() {
  local msg="$1"
  printf "${C_R}ERROR:${C_RST} %b.\n" "$msg"
}

msgInfo() {
  local msg="$1"
  printf "${C_B}INFO:${C_RST} %b.\n" "$msg"
}

msgOk() {
  local msg="$1"
  printf "${C_G}OK:${C_RST} %b.\n" "$msg"
}


# ---------- log ----------
logEntry() {
  local level="$1"  # ERROR | WARN | INFO
  local msg="$2"
  local logP="$3"
  printf "[%s] [%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$level" "$msg" >> "$logP"
}


# ---------- distro detection ----------
getDistro() {
  # /etc/os-release is the reliable source — uname -a reflects the HOST kernel
  # so it can say "Ubuntu" even inside an Alpine container
  if [ -f /etc/os-release ]; then
    local id
    id=$(grep -i '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"' | tr '[:upper:]' '[:lower:]')
    case "$id" in
      ubuntu)         echo 'ubuntu' ; return ;;
      arch|archlinux) echo 'arch'   ; return ;;
      fedora)         echo 'fedora' ; return ;;
      alpine)         echo 'alpine' ; return ;;
    esac
  fi
  echo 'unknown'
}

getPackageManager() {
  local distro="$1"
  case "$distro" in
    ubuntu) echo 'apt-get' ;;
    arch)   echo 'pacman'  ;;
    fedora) echo 'dnf'     ;;
    alpine) echo 'apk'     ;;
  esac
}

getInstallCmd() {
  local distro="$1"
  case "$distro" in
    ubuntu) echo 'apt-get install -y' ;;
    arch)   echo 'pacman -S --noconfirm' ;;
    fedora) echo 'dnf install -y' ;;
    alpine) echo 'apk add --no-cache' ;;
  esac
}


# ---------- dependencies INSTALL FUNCTION ----------
installDependencies() {
  local pRoot="$1"
  local csvP="$pRoot/build/programs.csv"        # path to the programs csv file
  local logP="$pRoot/dependencies_linux.log"    # path to the log file

  # initialize log file with header
  printf "# ============================================================\n"   > "$logP"
  printf "# dependencies_linux.log\n"                                         >> "$logP"
  printf "# started: %s\n" "$(date '+%Y-%m-%d %H:%M:%S')"                    >> "$logP"
  printf "# host:    %s\n" "$(uname -n)"                                      >> "$logP"
  printf "# kernel:  %s\n" "$(uname -r)"                                      >> "$logP"
  printf "# ============================================================\n"   >> "$logP"
  printf "\n"                                                                  >> "$logP"

  if [ ! -f "$csvP" ]; then
    msgError "Can't find ${C_B}programs.csv${C_RST} at $csvP"
    logEntry "ERROR" "programs.csv not found at $csvP" "$logP"
    exit $EXIT_FAILURE
  fi

  local distro
  distro=$(getDistro)

  if [ "$distro" = 'unknown' ]; then
    msgError "Unsupported distro, only ${C_Y}Ubuntu${C_RST}, ${C_Y}Arch${C_RST}, ${C_Y}Fedora${C_RST} and ${C_Y}Alpine${C_RST} are supported"
    logEntry "ERROR" "unsupported distro — could not detect from /etc/os-release" "$logP"
    exit $EXIT_FAILURE
  fi

  local installCmd
  installCmd=$(getInstallCmd "$distro")

  msgInfo "Detected distro: ${C_Y}${distro}${C_RST}"
  msgInfo "Using: ${C_B}$(getPackageManager "$distro")${C_RST}"
  logEntry "INFO" "detected distro: $distro" "$logP"
  logEntry "INFO" "package manager: $(getPackageManager "$distro")" "$logP"
  printf "\n" >> "$logP"

  # update package index
  case "$distro" in
    ubuntu) apt-get update -q ;;
    arch)   pacman -Sy ;;
    fedora) dnf check-update -q || true ;; # dnf returns 100 if updates available, not an error
    alpine) apk update -q ;;
  esac

  # read csv skipping header, install each package
  tail -n +2 "$csvP" | while IFS=',' read -r name ubuntu arch fedora alpine; do
    local pkgName
    case "$distro" in
      ubuntu) pkgName="$ubuntu" ;;
      arch)   pkgName="$arch"   ;;
      fedora) pkgName="$fedora" ;;
      alpine) pkgName="$alpine" ;;
    esac

    # strip any trailing whitespace/carriage returns
    pkgName="${pkgName%$'\r'}"
    pkgName="${pkgName%$' '}"

    if [ -z "$pkgName" ]; then
      msgError "No package defined for ${C_Y}${name}${C_RST} on ${distro}, skipping"
      logEntry "WARN" "no package defined for '$name' on $distro — skipped" "$logP"
      continue
    fi

    if command -v "$(echo "$name" | cut -d'/' -f1)" > /dev/null 2>&1; then
      msgOk "${name} is already installed, skipping"
      logEntry "INFO" "$name — already installed, skipped" "$logP"
      continue
    fi

    msgInfo "Installing ${C_B}${name}${C_RST} (${pkgName})..."
    if $installCmd "$pkgName" >> "$logP" 2>&1; then
      msgOk "${name} installed successfully"
      logEntry "INFO" "$name ($pkgName) — installed successfully" "$logP"
    else
      msgError "Failed to install ${name}, continuing with next package"
      logEntry "ERROR" "$name ($pkgName) — installation failed" "$logP"
    fi

    printf "\n" >> "$logP"

  done

  printf "\n"                                                                  >> "$logP"
  printf "# ============================================================\n"   >> "$logP"
  printf "# finished: %s\n" "$(date '+%Y-%m-%d %H:%M:%S')"                   >> "$logP"
  printf "# ============================================================\n"   >> "$logP"

  msgInfo "Log saved at: ${C_Y}${logP}${C_RST}"
}


main() {

# ---------- minimum information - early returns SECTION ----------
  [ -z "$HOME" ] && msgError "\$HOME variable is not set" && exit $EXIT_FAILURE

  if ! uname -a | grep -iq 'linux'; then
    msgError "This is not a ${C_Y}Linux${C_RST} system, can't install dependencies"
    exit $EXIT_FAILURE
  fi

  local pRoot
  pRoot="$(dirname "$(realpath "$0")")/../.." # path to the project's root

  installDependencies "$pRoot"

  exit $EXIT_SUCCESS
}

main "$@"
