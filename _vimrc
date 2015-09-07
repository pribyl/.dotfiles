" local syntax file
" Maintainer:	Tomas Pribyl <tomas.pribek@seznam.cz>
" Last Change:	2007 Aug 26
" Revision #0: Take over from Jirka Sustek. Delete redundant commands.
" Revision #1: Set default font.
" Revision #2: Add folding support.
" Revision #3: Switch FoldColumn and Folded colors for easier contrast.
" Revision #4: Support for using taglist
" Revision #5: Support for NERDTree, map <F9> to split screen do my default
"              windows layout, disable mswin.vim
" Revision #6: Remap delete commands
"
" want vim, not vi; must be first, because it changes other options
set nocompatible 
set fileformats=unix
" TODO
" :args **/*.%:e

:set statusline=%-15([%{&ff}/%Y]%)\ %-16(ASCII=\%03b(0x%02B)%)\ %-22(ROW=%l/%L\ (\%p%%\)%)\ %-10(COL=%03v%)\ %F%m%r%h%w
set laststatus=2 

source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
"""behave mswin
set expandtab
set tabstop=2
set softtabstop=2
set sw=2
set ts=2

let g:is_split = 0
function! ToggleSplit()
    if g:is_split==0
        NERDTree
        wincmd p
        let filename = expand('%:p:h')."\\".expand('%<').".log"
        below 10 new
        if filereadable(filename)
          execute "open ".filename
          execute "normal! \G"
          setl ar
        end
        wincmd p
        "rightbelow vnew
        "wincmd p
        let g:is_split = 1
    else
        execute "normal \<c-w>o"
        lcd %:p:h
        let g:is_split = 0
    endif
endfunction

" keys maping 
" save
map   <F2>    :w<ENTER>
imap  <F2>    <ESC>:w<ENTER>li
vmap  <F2>    <ESC>:w<ENTER>lgv
" line wrapping
nmap <F7> :set wrap!<CR>
imap <F7> <ESC>:set wrap!<CR>i
" taglist
nnoremap <silent> <F8> :TlistToggle<CR>
" default windows layout
nmap <F9> :call ToggleSplit()<CR>
imap <F9> <ESC>:call ToggleSplit()<CR>i
" quit
map   <F10>   :mkview<ENTER>:q<ENTER>
imap  <F10>   <ESC>:mkview<ENTER>:q<ENTER> 
vmap  <F10>   <ESC>:mkview<ENTER>:q<ENTER> 
" quick hide result of search
map   <F11>   :nohlsearch<CR>
imap  <F11>   <ESC>:nohlsearch<CR>i
vmap  <F11>   <ESC>:nohlsearch<CR>gv
" permanently hide and show result of last search
"map   <F12>   :set hlsearch!<CR>
"imap  <F12>   <ESC>:set hls!<CR>i
"vmap  <F12>   <ESC>:set hls!<CR>gv
" VimCommander
noremap <silent> <F12> :cal VimCommanderToggle()<CR>

noremap ddd "_dd
vmap dd "_d

filetype on

" search and replace all occurences of word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
:inoremap <Leader>s <ESC>:%s/\<<C-r><C-w>\>/

" syntax highlighting
hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif

if &readonly 
  set nomodifiable 
  map <ESC> :q<ENTER>
endif


highlight Normal			                                          guifg=#ffffff guibg=#000000
"	*Comment	any comment
highlight Comment	    ctermfg=8			                            guifg=#b0b0b0
"	*Constant	any constant
highlight Constant	  ctermfg=14		              cterm=none    guifg=#00ffff				        gui=none
"	 String		a string constant: "this is a string"
"	 Character	a character constant: 'c', '\n'
"	 Number		a number constant: 234, 0xff
"	 Boolean	a boolean constant: TRUE, false
"	 Float		a floating point constant: 2.3e10
"	*Identifier	any variable name
highlight Identifier  ctermfg=6			                            guifg=#00c0c0
"	 Function	function name (also: methods for classes)
"	*Statement	any statement
highlight Statement   ctermfg=3			              cterm=bold    guifg=#c0c000				        gui=bold
"	 Conditional	if, then, else, endif, switch, etc.
"	 Repeat		for, do, while, etc.
"	 Label		case, default, etc.
"	 Operator	"sizeof", "+", "*", etc.
"	 Keyword	any other keyword
"	 Exception	try, catch, throw
"	*PreProc	generic Preprocessor
highlight PreProc	    ctermfg=10		                            guifg=#00ff00
"	 Include	preprocessor #include
"	 Define		preprocessor #define
"	 Macro		same as Define
"	 PreCondit	preprocessor #if, #else, #endif, etc.
"	*Type		int, long, char, etc.
highlight Type		    ctermfg=2			                            guifg=#00c000
"	 StorageClass	static, register, volatile, etc.
"	 Structure	struct, union, enum, etc.
"	 Typedef	A typedef
"	*Special	any special symbol <F11>, <ESC>, etc.
highlight Special	    ctermfg=12		                            guifg=#0000ff
"	 SpecialChar	special character in a constant
"	 Tag		you can use CTRL-] on this
"	 Delimiter	character that needs attention
"	 SpecialComment	special things inside a comment
"	 Debug		debugging statements
"	*Underlined	text that stands out, HTML links
"	*Ignore		left blank, hidden
"	*Error		any erroneous construct
highlight Error				              ctermbg=9			                            guibg=#ff0000
"	*Todo		anything that needs extra attention; mostly the keywords TODO FIXME and XXX
highlight Todo		    ctermfg=4	    ctermbg=3			              guifg=#000080 guibg=#c0c000

highlight Directory   ctermfg=2			                            guifg=#00c000
highlight StatusLine  ctermfg=11    ctermbg=12    cterm=none    guifg=#ffff00 guibg=#0000ff gui=none
highlight Search			              ctermbg=3			              guifg=red     guibg=NONE    gui=undercurl guisp=red
highlight FoldColumn	ctermfg=8     ctermbg=0     cterm=bold    guifg=#00ffff guibg=#000000
highlight Folded	    ctermfg=8     ctermbg=0     cterm=bold    guifg=#00ffff guibg=#202020

" set numbering of rows
set nu!

" select case-insenitive search (not default) - for case-sensitive type \C to pattern (/\Cfoo, /foo\C)
set ignorecase

" show cursor line and column in the status line
set ruler

" show matching brackets
set showmatch

" display mode INSERT/REPLACE/...
set showmode

" changes special characters in search patterns (default)
set magic

" Required to be able to use keypad keys and map missed escape sequences
set esckeys

" get easier to use and more user friendly vim defaults
" CAUTION: This option breaks some vi compatibility. 
"          Switch it off if you prefer real vi compatibility
set nocompatible

" nastavi funkcni backspace
set backspace=2

" nastavi poradne undo
set history=300

" zobrazi prikaz
set showcmd

set shiftwidth=2 

" folds
set foldcolumn=3
"set foldopen=all
"set foldclose=all
set foldmethod=manual

" Complete longest common string, then each full match
" enable this for bash compatible behaviour
" set wildmode=longest,full

" Only do this part when compiled with support for autocommands. 
if has("autocmd") 
  " When editing a file, always jump to the last known cursor position. 
  " Don't do it when the position is invalid or when inside an event handler 
  " (happens when dropping a file on gvim). 
  "autocmd BufEnter * lcd %:p:h
  "autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif 
  autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \   exe "normal g`\"" | 
    \ endif 

  autocmd BufReadPost,FileReadPost * :loadview

  au Filetype vhdl call FT_vhdl()

endif " has("autocmd")

" Changed default required by SuSE security team
set modelines=0

" window's size and position
winp 0 0
win 250 120

function FT_vhdl()
	let g:vhdl_indent_genportmap=0
	" for taglist
	let g:tlist_vhdl_settings   = 'vhdl;d:package declarations;b:package bodies;e:entities;a:architecture specifications;t:type declarations;p:processes;f:functions;r:procedures;s:signals;l:aliases;c:constants'
endfunction

let Tlist_Ctags_Cmd='C:\ctags58\ctags.exe'
