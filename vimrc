execute pathogen#infect()
syntax on
filetype plugin indent on

"own mappings
map <C-o> :tabp<CR>
map <C-p> :tabn<CR>
map <C-\> \ci
map <C-k> :tabclose<CR>
map <space> za
map <FO> zR
map <FC> zM
map <]p> p
set mouse=a

" NOPs
"noremap h <NOP>
"noremap l <NOP>
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

" not sure
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("^V<cWORD>"),0)^V^M
let &cpo=s:cpo_save
unlet s:cpo_save

set backspace=2
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set modelines=0
set window=0
set laststatus=4
set background=dark

set ts=4
set sw=4
set et
set ai
set nowrap

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set ruler
set number
set cursorline
set incsearch
set relativenumber

" persistent undo
set undofile
set undodir=~/.vim/undodir

autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

if v:version >= 700
    autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en, colorcolumn=80
endif

"java folding
function! JavaFold()
let line = getline(v:lnum)
if match(line, '^(private|public)\sclass') > -1
    return ">1"
if match(line, '^\s*(private|public)\sclass') > -1
    return ">2"
else
    return "="
endif
endfunction

autocmd Filetype java setlocal foldmethod=expr foldexpr=JavaFold()

autocmd FileType python setlocal foldmethod=indent
"autocmd FileType python setlocal colorcolumn=80

"markdown folding
function! MdFold()
let line = getline(v:lnum)
if match(line, '^#\s') > -1
    return ">1"
elseif match(line, '^##\s') > -1
    return ">2"
else 
    return "="
endif
endfunction

autocmd Bufenter *.md setlocal syntax=off foldmethod=expr foldexpr=MdFold()

" autocomplete with tab
function! Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
    endif
endfunction

inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

autocmd Bufenter *.cpp setlocal foldmethod=syntax 
autocmd Bufenter *.h setlocal foldmethod=syntax 

set tags=./tags;/,tags;/
"hi Folded term=standout ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
"hi Folded ctermbg=7


"grep word under cursor
nnoremap <leader>g : silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd Bufenter * match ExtraWhitespace /\s\+$/

" terraform
let g:terraform_align=1
let g:terraform_fold_sections=1

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>C :SyntasticCheck<CR> :SyntasticToggleMode<CR>
