" Welcome to my .vimrc
" I try and keep this as tidy as possible 
" and will remove stuff whenever.
" Hopefully you will find some cool stuff 

filetype off                            " required

call plug#begin()

Plug 'VundleVim/Vundle.vim'             " Plugin Manager
"
                                        " the best autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'puremourning/vimspector'          " VIMspector dbg
                                
Plug 'morhetz/gruvbox'                  " colorscheme
Plug 'OmniSharp/omnisharp-vim'          " Omnicompletion for C#
Plug 'vim-airline/vim-airline'          " airline taskbar

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'                 " awesome fuzzy finder

Plug 'tpope/vim-fugitive'               " great stuff for GIt

"Plug 'szw/vim-tags'                     " tag managerworks with :TagsGenerate

Plug 'mbbill/undotree'                  " Undotree is fantastic really

"Plug 'leafgarland/typescript-vim'      " typescript
Plug 'vim-utils/vim-man'                " vim-manual

Plug 'lervag/vimtex'                    " latex
Plug 'vim-latex/vim-latex'              " latex
Plug 'xuhdev/vim-latex-live-preview'    " latex live preview

Plug 'nathanaelkane/vim-indent-guides'
Plug 'Chiel92/vim-autoformat'
Plug 'ycm-core/YouCompleteMe'

Plug 'davidhalter/jedi-vim'             " Python Autocomplete
"Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'majutsushi/tagbar'                " Great tagbar - mapped to <F8>
Plug 'ncm2/ncm2'                        " Autocomplete
Plug 'tpope/vim-surround'               " Fantastic surround replacer that accessed by cs
Plug 'tpope/vim-unimpaired'             " shortcuts for q[ q] for quicklist
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-startify'            " Start screen

call plug#end()
        colorscheme blue        " weird bug with gbox [need to load this first]
        colorscheme gruvbox
        set foldcolumn=1        " fold column displays 
        set noerrorbells        " bell of death
        syntax on               " enable syntax processing
                                " make backspaces more powerfull
        set backspace=indent,eol,start 

        set tabstop=3           " number of visual spaces per TAB
        set softtabstop=4       " number of spaces in tab when editing
        set shiftwidth=2        "number of tabs when indenting
        set expandtab           " tabs are spaces
        set smarttab 
        filetype indent on      " load filetype-specific indent files

        let g:python3_host_prog="/usr/local/bin/python3"

        set number              " show line numbers
        set showcmd             " show command in bottom bar
        set cursorline          " highlight current line
        set smartindent         "smart indentaion
        set wildmenu            " visual autocomplete for command menu
        set lazyredraw          " redraw only when we need to.
        set showmatch           " highlight matching [{()}]
        set incsearch           " search as characters are entered
        set hlsearch            " highlight matches
        set nobackup
        set undofile
        set undodir=$HOME/.vim/undo "backs-up undos for each file in undodir this is not done automatically so you have to mkdir the directory 
        set undolevels=1000      " How many undos to save
        set undoreload=10000     " How many undos to reload 
        " turn off search highlight
        nnoremap <leader><space> :nohlsearch<CR>
        set foldenable           " enable folding
        set foldlevelstart=10    " open most folds by default
        set foldnestmax=10       " 10 nested fold max
        set conceallevel=0       " Do not coneal " in json
        set laststatus=2         " Enables taskbar to work on 1 window vims

        " map <leader> to spacebar
        let mapleader = "\<SPACE>"

        "Make Latex work dirrectly from vim
        let g:tex_flavor='latex'
        let g:vimtex_view_method='zathura'
        let g:vimtex_quickfix_mode=0
        set conceallevel=0
        let g:tex_conceal='abdmg'

        " For the TEX Files 
        let g:livepreview_previewer='open -a zathura'

let g:ycm_path_to_python_interpreter='/usr/local/bin/python3'
        
" remember folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" space open/closes folds
nnoremap <LEADER>z za

"undotree
nnoremap <LEADER>u :UndotreeShow <CR>

"quit window
nnoremap <LEADER>q :wincmd q <CR>

"NERDTree
nnoremap <LEADER>e :NERDTreeFind <CR>
nnoremap <LEADER>E :NERDTree <CR>

" Toggle Tabgbar On
nmap <F8> :TagbarToggle<CR>

" Coloured column 80
set colorcolumn=80

"autocmd vimenter * PluginUpdate 
let g:ycm_global_ycm_extra_conf="~/.vim/.ycm_extra_conf.py"

"autocmd vimenter * NERDTree

" jump to next indent with [l and ]l
nnoremap <M-,> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <M-.> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
"
" coc-plugin
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"""""""""""""""""""""""""""""""""""""""""
" FZF REMAPS
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
" make Ctrcl+C copy to clipboard
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
" searches in git files
nnoremap <leader>f :GFiles<CR>      
" searches in all files in current locaiton
nnoremap <leader><leader>f :Files<CR>      
" searches for text in files
nnoremap <leader>F :Locate /<CR>      
" search in all buffers name
nnoremap <leader>b :Bufers<CR>
" search in all files
nnoremap <leader>a :Ag<CR>
" search in all open buffers lines
nnoremap <leader>L :BLines<CR>
" search in all open buffers lines
nnoremap <leader>l :Lines<CR>
" search in tags
nnoremap <leader>l :Tags<CR>
"""""""""""""""""""""""""""""""""""""""""
" FUGITIVE GIT commans
" gets git status
" use S and U to stage unstage 
nnoremap <leader>gs :G<CR>
" to enter the diff mode press dv
nnoremap <leader>gd :diffget //3<CR>
" gets git diff from left 
nnoremap <leader>gj :diffget //2<CR>
" gets git diff from right 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Things I always forget:
"ctrl + window + o closes all the other tabs 


