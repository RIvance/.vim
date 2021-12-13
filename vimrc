set number
set showcmd
set wildmenu
set cursorline
set nu
set t_Co=256
set relativenumber
set ignorecase smartcase
set mouse=a
set encoding=utf-8
set shiftwidth=4
set tabstop=4
set softtabstop=4
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set expandtab
set autoindent
set cindent
set clipboard=unnamed
set backspace=indent,eol,start

let python_highlight_all=1
syntax on

let g:Powerline_symbols = 'fancy'

set autochdir
autocmd vimenter * NERDTree

let &t_SI = "\<Esc>]50;CursorShape1\x7"
let &t_SR = "\<Esc>]50;CursorShape2\x7"
let &t_EI = "\<Esc>]50;CursorShape0\x7"

let g:cpp_class_scope_highlight = 1

if (empty($TMUX))
  if (has("nvim"))
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"""""""""""""""""""""""
" key settings
"
"""""""""""""""""""""""
noremap j k
noremap k j

map Q :exit<CR>
map s <nop>
map . :
map , i
map <Tab> i

map sl :set splitright<CR>:vsplit<CR>
map <C-left> <C-w>h
map <C-right> <C-w>l
map <C-up> <C-w>k
map <C-down> <C-w>j
map <C-h> :vertical resize-3<CR>
map <C-l> :vertical resize+3<CR>

map <C-n> :tabe<CR>
map <C-j> :-tabnext<CR>
map <C-k> :+tabnext<CR>

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

inoremap <C-z> <Esc>ui
nnoremap <C-z> u
vnoremap <C-z> <Esc><Esc><Esc>u

nmap <C-s> :w!<CR>
vmap <C-s> <C-C>:w!<CR>
imap <C-s> <Esc>:w!<CR>i

inoremap <C-q> <Esc>:exit<CR>
nnoremap <C-q> :exit<CR>
vnoremap <C-q> <Esc><Esc><Esc>:exit<CR>

vnoremap <C-c> y
vnoremap <C-v> p
nnoremap <C-v> p
inoremap <C-e> <Esc>
nnoremap \ i
nnoremap <Enter> o
" inoremap <C-CR> <Esc>
nnoremap <BS> i<BS>
vnoremap <BS> d

vnoremap <C-c> "+y

"""""""""""""""""""""""

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>

inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
""inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

inoremap <Enter> <c-r>=BracketsEnter('}')<CR>
inoremap <S-CR> <c-r>=BracketsEnter('}')<CR>

function BracketsEnter(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Enter>\<Tab>\<Esc>mpa\<Enter>\<Esc>`pa" 
    else
        return "\<Enter>"
    endif
endf

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 return a:char
 elseif line[col - 1] == a:char
 return "\<Right>"
 else
 return a:char.a:char."\<Esc>i"
 endif
endf

""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""

"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

""""""""""""""""""""""""""""""""""""""
cabbrev main call InsertMain()
func! InsertMain()
    if &filetype == 'c'
        call append(line(".") - 1, 'int main(int argc, const char* argv[])')
        exec "normal! i{}\<left>\<Enter>\<Tab>\<Esc>mpa\<Enter>\<Esc>`pa "
        exec "startinsert"
    elseif &filetype == 'cpp'
        call append(line(".") - 1, 'int main(int argc, const char* argv[])') 
        exec "normal! i{}\<left>\<Enter>\<Tab>\<Esc>mpa\<Enter>\<Esc>`pa "
        exec "startinsert"
    elseif &filetype == 'java'
        exec "normal! opublic static void main(String[] args) {}\<left>\<Enter>\<Tab>\<Esc>mpa\<Enter>\<Esc>`pa "
        exec "startinsert"
    endif
endfunc


cabbrev sout call InsertPrintln()
func! InsertPrintln()
    if &filetype == 'cpp'
        exec "normal! i\<Tab>std::cout <<  << std::endl;"
        exec "normal! 13h"
        exec "startinsert"
    elseif &filetype == 'java'"
        exec "normal! i\<Tab>System.out.println();"
        exec "normal! 1h"
        exec "startinsert"
    endif
endfunc

""""""""""""""""""""""""""""""""""""""
map <C-b> :call CompileRunGcc()<CR>
map <^@> :call CompileRunGcc()<CR>
inoremap <C-b> <Esc>:call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
        exec "silent !clear"
        
        if &filetype == 'c'
            echo "silent !echo \'[build]\\n\'"
            exec "silent !gcc % -Wall -o %<"
            exec "silent !echo \'\\n\\n[runtime]\'"
            exec "!time ./%<"
        elseif &filetype == 'cpp'
            echo "silent !echo \'[build]\\n\'"
            exec "silent !g++ % -Wall -std=c++17 -o %<"
            exec "silent !echo \'\\n\\n[runtime]\'"
            exec "!time ./%<" 
        elseif &filetype == 'java'
            echo "silent !echo \'[build]\\n\'"
            exec "silent !javac %"
            exec "silent !echo \'\\n\\n[runtime]\'"
            exec "!time java %"
        elseif &filetype == 'sh'
            :!time bash %
        elseif &filetype == 'python'
            exec "!time python %"
        elseif &filetype == 'html'
            exec "!firefox % &"
        elseif &filetype == 'go'
            exec "!go build %<"
            exec "!time go run %"
        elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
        endif
    endfunc
""""""""""""""""""""""""""""""""""""


"""""""""""""""""""
" plugin
"
"""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/syntastic'
" Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
Plug 'Lokaltog/vim-powerline'
Plug 'puremourning/vimspector'
Plug 'skywind3000/asyncrun.vim'
" Plug 'dense-analysis/ale'
Plug 'tomasiser/vim-code-dark'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

colorscheme onehalfdark
let g:airline_theme='onehalfdark'

