" Pathogen to autoload plugins in /etc/vim/bundle and ~/.vim/bundle
"source /etc/vim/pathogen/autoload/pathogen.vim
"execute pathogen#infect('bundle/{}', '/etc/vim/bundle/{}')
execute pathogen#infect()
filetype on
filetype plugin on
filetype indent on
set autoindent smartindent smarttab cindent
set tabstop=4 shiftwidth=4 softtabstop=4 textwidth=119

set iskeyword-=_

set modeline

" CTRL-P Default
let g:ctrlp_custom_ignore = {
    \ 'file': '\v\.(pyc|swp|swo|png|gif|jpg|ico|bin)$',
    \ 'dir': '\v/src/static$',
    \ 'link': '',
    \ }

" Syntastic Defaults
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_puppet_checkers=['puppet', 'puppetlint']
let g:syntastic_puppet_puppetlint_args = '--no-autoloader_layout-check --no-documentation-check --no-80chars-check --no-class_inherits_from_params_class-check'
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers=['perlcritic']
let g:syntastic_perl_perlcritic_args = '-4'
let g:syntastic_python_flake8_post_args='--ignore=E501,E402,W292,E722'
let g:syntastic_python_checkers = ['flake8', 'pyflakes']

" NERDTree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Commands
command Q qa!
command W wa!
command -nargs=1 E tabedit <args>

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" Set <Tab> to navigate tabs
map <Tab> :tabn<cr>
let g:airline#extensions#tabline#enabled = 1

" Set <F2> for paste mode toggle
set pastetoggle=<F2>

" Set <F4> for Syntstic toggle
nnoremap <F4> :SyntasticToggleMode<CR>

" Set <F3> for line number toggle
nnoremap <F3> :set number!<CR>

" load filetype defaults and custom templates
if has("autocmd")
  autocmd!
  " remove auto comment on newline or enter command
  autocmd bufnewfile,bufreadpre,bufread,bufreadpost * exe "set formatoptions-=cro"
  " puppet
  autocmd bufread,bufnewfile *.pp set filetype=puppet
  autocmd bufnewfile *.pp 0r ~/.vim/templates/template.pp
  autocmd bufnewfile *.pp exe "g/filename/s//" .expand("%:t")
  autocmd bufnewfile *.pp exe "g/classname/s//" .expand("%:t:r")
  " perl
  autocmd bufnewfile *.pl 0r ~/.vim/templates/template.pl
  autocmd bufnewfile *.pl exe "g/filename/s//" .expand("%:t")
  " python
  autocmd bufnewfile *.py 0r ~/.vim/templates/template.py
  " Trim trailing lines from template
  autocmd bufnewfile *.py\|*.pp\|*.pl %s#\($\n\s*\)\+\%$## 
  autocmd FileType python\|htmldjango set tabstop=4 shiftwidth=4 softtabstop=4 textwidth=119
  autocmd FileType rst set tabstop=3 shiftwidth=3 softtabstop=3 textwidth=119
  autocmd FileType vim\|ruby\|puppet set tabstop=2 shiftwidth=2 softtabstop=2 textwidth=119
  autocmd FileType perl set tabstop=5 shiftwidth=5 softtabstop=5 textwidth=119
endif

" Set <F8> to run puppet-lint
function Formatting()
  " Turn on paste mode
  set nopaste
  normal! gg=G``
  if &ft =~ "puppet"
    "normal! gg=G
    g/=>/Tabularize/=>/
    "nohlsearch
    "/.*\".*"\.*\&\(.*\$\)\@!.*/s/\"/\'/g
    " Fix double quoted strings containing no variables
    g/.*\".*"\.*\&\(.*\$\)\@!.*/ s/\"/\'/g
    "nohlsearch
    " Fix double quoted strings containing only variable
    "g/.*=>.\"\$\:*\w*\".*/s/\"//g
    " Fix remaining double quoted strings where
    " variable not enclosed in {}
    "g/.*=>.\".*\".*/ s/\$\(\w*\)/\$\{\1\}/g
    "nohlsearch
    "write
  endif
  "nohlsearch
  " Fix the tabs
  retab
  SyntasticCheck
  write
endfunction
nnoremap <F8> :call Formatting()<CR>

" change title of terminal window to active filename
set title

" alwaays display lower status line
set laststatus=2
set statusline=%f[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%l\ %p

" always display the tabline
set showtabline=2

" replace tabs with spaces
set expandtab

" do not return cursor to start of line
set nostartofline

" colors
" colorscheme solarized
" colorscheme koehler
" colorscheme mustang
colorscheme gruvbox
let g:airline_powerline_fonts = 1

" line wrap
set wrap

" syntax checking on
syntax on

" use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" display white space with a char
set list

" set listchars=trail:.
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" always display rule
set ruler

" always display line numbers
set number
set numberwidth=4

" change background color for column 121+
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn=join(range(121,999),",")

" change fg color for visul highlight
highlight Visual ctermfg=16

" highlight search
set hlsearch

" Do not create a swap file
set noswapfile

" Enable the mouse
"set mouse=a

" make backspace work like most other apps
set backspace=2
