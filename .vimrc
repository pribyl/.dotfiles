set nocompatible
set encoding=utf8

let mapleader="\\"
let maplocalleader="\\"
"let mapleader="\<space>"
"let mapleader="\\"

syntax enable
filetype plugin indent on

if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

"set clipboard=unnamedplus

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'taglist.vim'
NeoBundle 'lunaru/vim-twig'
NeoBundle 'tpope/vim-endwise'
" NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-surround'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'Rubytest.vim'
NeoBundle 'xoria256.vim'
NeoBundle 'bufexplorer.zip'
NeoBundle 'Mark'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'vimball'
NeoBundle 'bling/vim-airline'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tomasr/molokai'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'viewdoc'
NeoBundle 'rking/ag.vim'
NeoBundle 'a.vim'
NeoBundle 'compview'
NeoBundle 'pelodelfuego/vim-swoop'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'embear/vim-localvimrc'
NeoBundle 'LogViewer'
NeoBundle 'ciaranm/detectindent'
NeoBundle 'tmux-plugins/vim-tmux'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'reedes/vim-pencil'
" NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'fboender/bexec'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'tpope/vim-fugitive'

call neobundle#end()

NeoBundleCheck

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Local vim rc
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch

" EasyMotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-bd-w)

" airline
set laststatus=2

set nobackup
set noswapfile

"set t_Co=16
"set t_Sf=[3%dm
"set t_Sb=[4%dm

set mouse=a
set autoindent
set ignorecase
set smartcase
set hidden
set backspace=2
set incsearch

set tabstop=2
set shiftwidth=2
set expandtab

set nu
set timeoutlen=1000 ttimeoutlen=1000


" status line
set laststatus=2
set ruler

" set background=dark
" colorscheme moria
" Colo black
" colorscheme evening
" colorscheme molokai "xoria256
" let g:zenburn_high_Contrast=1
" colorscheme zenburn

set t_Co=256
if has("gui_running")
   " colorscheme molokai
   colorscheme jellybeans
"   set guifont=Envy\ Code\ R\ 10

   " set guifont=InputMonoNarrow:h10:cANSI
   " set rop=type:directx,level:0.5,contrast:0.5;taamode:1
   set guioptions-=T  "remove toolbar
   set guioptions-=m  "remove menu bar
   set guioptions-=r  "remove right-hand scroll bar
   set guioptions-=L  "remove left-hand scroll bar
   set guioptions-=e  "use terminal-like tab pages
else
   colorscheme molokai
endif

let c_space_errors=1

"
" Key bindings

" Set F10 keycode
"set t_k;=[10~

" Tag list browser
" let Tlist_Show_One_File = 1
" let tlist_esqlc_settings = 'c;d:macro;g:enum;s:struct;u:union;t:typedef;' .
                         \ 'v:variable;f:function'
" Next tag
map <C-]><C-]> :tnext<CR>
" Previous tag
map <C-[><C-[> :tprev<CR>

" Mark browser
:nnoremap <F12> :MarksBrowser<CR>

:nnoremap <F3> :CtrlPBuffer<CR>
:nnoremap <F2> :CtrlP getpwd()<CR>

filetype plugin indent on

" Highlighting of the showmarks plugin
highlight ShowMarksHLl ctermfg=black ctermbg=yellow
" Highlighting of the popup menu, used e.g. by Ctrl+N
highlight Pmenu ctermbg=lightgray ctermfg=black

" Configuration of the A plugin
let g:alternateExtensions_cc = "h,hh"
let g:alternateExtensions_hh = "cpp,cc"
let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:source,sfr:src,sfr:include,sfr:inc'

" set makeprg=gmake

" folding
set foldmethod=marker

" building ctags
map <F9> :!ctags -R --c++-kinds=+p --fields=+iaS --exclude=dep --extra=+q .<CR>
set tags=tags,../tags

" hilight current line in edit mode
" autocmd InsertLeave * se nocul
" autocmd InsertEnter * se cul
" setting for hilighting background of current line
"se cursorline
"hi CursorLine term=none cterm=none ctermbg=3
"autocmd InsertLeave * hi CursorLine term=none cterm=none ctermbg=3
"autocmd InsertEnter * hi CursorLine term=none cterm=none ctermbg=4 

" Turn off matching of brackets
" let loaded_matchparen = 1

" Select colormap: 'soft', 'softlight', 'standard' or 'allblue'
" let xterm16_colormap    = 'standard'
" Select brightness: 'low', 'med', 'high', 'default' or custom levels.
" let xterm16_brightness  = 'high'
" colorscheme xterm16

" compview plugin
" map <F4> :call CSearch()<cr>
map <F4> <Plug>CompView

" Line wrapping
set breakindent
set listchars+=extends:>,precedes:<
set showbreak=◘
set display+=lastline

" Tagbar settings
let g:tagbar_left=1
nnoremap <silent> <Leader><F9> :TagbarToggle<CR>

" Ruby test runner
let g:rubytest_in_quickfix = 1

" Ultisnips
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-ultisnips"]
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


let g:ag_qhandler = 'copen 30'

" Show extra whitespace
set list
set listchars=tab:>-

" tabular
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

noremap <silent> <Leader>1 :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

cnoreabbrev qw wq

:nmap <CR><CR> o<ESC>

nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv
