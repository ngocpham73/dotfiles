call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
" Navigate and manipulate files in a tree view.
Plug 'preservim/nerdtree'
" Complete word
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --ts-completer' }
" surround 
Plug 'tpope/vim-surround'
" A git wrapper
Plug 'tpope/vim-fugitive'
" A bunch of useful language related snippets (ultisnips is the engine).
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Integrate fzf with Vim.
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
" Automatically set 'shiftwidth' + 'expandtab' (indention) based on file type.
Plug 'tpope/vim-sleuth'
" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'
" Tagbar
Plug 'majutsushi/tagbar'
"auto close bracket
Plug 'chun-yang/auto-pairs'

" Languages and file types.
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

" -----------------------------------------------------------------------------
" Color settings
" -----------------------------------------------------------------------------

" Enable syntax highlighting.
syntax on

" Set the color scheme.
colorscheme gruvbox
set background=dark

" Specific colorscheme settings (must come after setting your colorscheme).
if (g:colors_name == 'gruvbox')
  if (&background == 'dark')
    hi Visual cterm=NONE ctermfg=NONE ctermbg=238 guibg=#3a3a3a
  else
    hi Visual cterm=NONE ctermfg=NONE ctermbg=228 guibg=#f2e5bc
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=228 guibg=#f2e5bc
    hi ColorColumn cterm=NONE ctermfg=NONE ctermbg=228 guibg=#f2e5bc
  endif
endif

" -----------------------------------------------------------------------------
" Basic Settings
"   Research any of these by running :help <setting>
" -----------------------------------------------------------------------------
set autoindent
set backspace=indent,eol,start  "Allow backspace in insert mode
"set clipboard=unnamedplus
set completeopt-=preview
set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set expandtab smarttab
set formatoptions=tcqrn1
set hlsearch " Highlight search results
set ignorecase " Ignore case when searching
set incsearch "search while typing
set laststatus=2  " Always display the status line
set linebreak breakindent "breakline by word and auto indent
set mouse=a
set number relativenumber
set ruler "Always show current position
set shiftwidth=2 
set showcmd       " display incomplete commands
set smartcase " When searching try to be smart about cases
set smartindent 
set softtabstop=2
set tabstop=2
set textwidth=0
set wrap
set wrapmargin=0
filetype plugin indent on


let mapleader=" "
let maplocalleader=" "


"Map Esc to jj
imap jj <Esc>

"Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

" change J to H to join line
nnoremap <Leader>j  J

" leader t to open terminal 
nnoremap <Leader>t :botright vertical terminal<CR>

" Move 1 more lines up or down in normal and visual selection modes.
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

"%: jump to end tag
runtime macros/matchit.vim
filetype plugin on

" .............................................................................
" Nerdtree 
" .............................................................................
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
"auto start nerdtree when enter vim
"autocmd VimEnter * NERDTree

" .............................................................................
" SirVer/ultisnips
" .............................................................................

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" .............................................................................
" junegunn/fzf.vim
" .............................................................................

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Customize fzf colors to match your color scheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>
" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case " .
  \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)

" .............................................................................
" majutsushi/tagbar 
" .............................................................................
nnoremap <C-t> :TagbarToggle<CR>

" .............................................................................
"Plug 'chun-yang/auto-pairs'
" .............................................................................
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = "∫"

" .............................................................................
" Youcompleteme 
" .............................................................................

let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
