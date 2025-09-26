
"  _    ________  _______  ______   __________  _   __________________
" | |  / /  _/  |/  / __ \/ ____/  / ____/ __ \/ | / / ____/  _/ ____/
" | | / // // /|_/ / /_/ / /      / /   / / / /  |/ / /_   / // / __  
" | |/ // // /  / / _, _/ /___   / /___/ /_/ / /|  / __/ _/ // /_/ /  
" |___/___/_/  /_/_/ |_|\____/   \____/\____/_/ |_/_/   /___/\____/   



set number " show line numbers
set relativenumber " show relative numbers


set expandtab " uses spaces instead of tabs
set tabstop=2 " set tabs to 2 a.k.a indentation
set shiftwidth=2

set autoindent " make autoindentation relative to scope of the brackets

syntax on " activate sintax highligthing


set wildmenu " activate basic autocomplition


set mouse= " deactivate mouse


colorscheme sorbet " alternative colorschemes are (sorbet,slate,wildcharm,zaibatsu)


" remap keys in normal mode
nnoremap <S-s> :wa<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" removes the highlighthing when pressing <Esc>
nnoremap <Esc> :nohlsearch<CR><Esc>
