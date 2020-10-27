" Welcome to my .vimrc
" I try and keep this as tidy as possible 
" and will remove stuff whenever.
"
" Hopefully you will find some cool stuff 
"
"
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'       "Plugin Manager
Plugin 'ycm-core/YouCompleteMe'     "Autocomplete
Plugin 'romainl/Apprentice'         "Theme
Plugin 'OmniSharp/omnisharp-vim'    "Omnicompletion for C#
Plugin 'itchyny/lightline.vim'      "Lightline taskbar
Plugin 'ianding1/leetcode.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } } "awesome fuzzy finder
Plugin 'junegunn/fzf.vim'
Plugin 'lervag/vimtex'
Plugin 'vim-latex/vim-latex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'junegunn/goyo.vim'          "Minimal mode for the text editor
Plugin 'davidhalter/jedi-vim'       "Python Autocomplete
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'majutsushi/tagbar'          "Great tagbar - mapped to <F8>
Plugin 'ncm2/ncm2'
Plugin 'preservim/nerdtree'

call vundle#end()
        colorscheme apprentice
    "    colorscheme gruvbox
        set foldcolumn=1        "fold column displays 
        set noerrorbells
        syntax enable                   " enable syntax processing
        set smartindent         "smart indentaion
        set tabstop=3           " number of visual spaces per TAB
        set softtabstop=3       " number of spaces in tab when editing
        set shiftwidth=2        "number of tabs when indenting
        set expandtab           " tabs are spaces
        set number              " show line numbers
        set showcmd             " show command in bottom bar
        set cursorline          " highlight current line
        filetype indent on      " load filetype-specific indent files
        set wildmenu            " visual autocomplete for command menu
        set lazyredraw          " redraw only when we need to.
        set showmatch           " highlight matching [{()}]
        set incsearch           " search as characters are entered
        set hlsearch            " highlight matches
        set nobackup
        set undodir=~/.vim/undodir "backs-up undos for each file in undodir
        set undofile
        " turn off search highlight
        nnoremap <leader><space> :nohlsearch<CR>
        set foldenable          " enable folding
        set foldlevelstart=10   " open most folds by default
        set foldnestmax=10      " 10 nested fold max
        " space open/closes folds
        nnoremap <space> za



        let g:tex_flavor='latex'
        let g:vimtex_view_method='zathura'
        let g:vimtex_quickfix_mode=0
        set conceallevel=1
        let g:tex_conceal='abdmg'

        " For the TEX Files 
        let g:livepreview_previewer = 'open -a zathura'

        set laststatus=2        " Enables lightline taskbar to work on 1 window vims
        "
""""""""""""""""""""
""""""""""""""""""""
" remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END
""""""""""""""""""""
""""""""""""""""""""

"
""""""""""""""""""""
" Toggle Tabgbar On
nmap <F8> :TagbarToggle<CR>
""""""""""""""""""""
""""""""""""""""""""
" Coloured column 80
set colorcolumn=80

" Do not coneal " in json
set conceallevel=0

"autocmd vimenter * PluginUpdate 
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

"autocmd vimenter * NERDTree
autocmd vimenter * NERDTree

" jump to next indent with [l and ]l
nnoremap <M-,> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <M-.> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
"
"""""""""""""""""""""""""""""""""""""""""
" FZF SETTINGS
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
" make Ctrcl+C copy to clipboard
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

" searches in git files
nnoremap <leader>f :GFiles<CR>      

" searches in all files in current locaiton
" similar to FZF
nnoremap <leader><leader>f :Files<CR>      

" searches for text in files
nnoremap <leader>F :Locate /<CR>      

" search in all buffers
nnoremap <leader>b :Bufers<CR>

" search in all files
nnoremap <leader>a :Ag<CR>
"""""""""""""""""""""""""""""""""""""""""
" FZF SETTINGS
