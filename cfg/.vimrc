set mmp=5000                    " max memory for pattern matching, default is 1000

set background=dark
set backspace=2
set hlsearch
set ignorecase
set matchtime=2                 " how many tenths of a second to blink when matching brackets
set mouse=a                     " uses vim visual mode for select. Use `"*y` to copy to system clipboard, or mouse=v for native select
set ttymouse=xterm2             " mainly for vim in tmux I think.
set noshowmode                  " disable the -- INSERT -- message, since we use Airline
set number                      " set relativenumber is <leader>N
set ruler                       " always show current position
set showmatch                   " show matching brackets when text indicator is over them
set smartcase
set title                       " set terminal title
set complete+=i,kspell          " added kspell, to add from dict when spell is set.

"set diffopt+=algorithm:patience " nicer diff 

" =============
" FILE HANDLING
" =============

set encoding=utf8               " set utf8 as standard encoding and en_US as the standard language
set fileformats=unix,dos        " use Unix as the standard file type
set foldmethod=marker           " folding {{{ }}}
set linebreak                   " line break
set textwidth=500               " text width

set autoindent                  " indent per filetype
filetype plugin indent on       " https://www.reddit.com/r/vim/wiki/vimrctips#wiki_do_not_use_smartindent

set tabstop=4                   " the width of a hard tab, measured in spaces
set shiftwidth=2                " set shiftwidth, e.g. tab inserts two spaces
set expandtab                   " spaces instead of hard tabs

" Enable copying from vim to the system-clipboard. Useful to yank/past between tmux panes?
" set clipboard=unnamedplus  

" Syntax highlighting for fenced languages
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html', 'python', 'bash=sh']

" Jenkinsfile == groovy
augroup set_filetypes
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile setf groovy
augroup END

" Spell check filetype or buffer
augroup spellcheck_documentation
  autocmd!
  autocmd BufNewFile,BufRead *.md setlocal spell
  autocmd BufNewFile,BufRead *.rdoc setlocal spell
  autocmd BufNewFile,BufRead *.txt setlocal spell
  autocmd FileType gitcommit setlocal spell
augroup END


" ========
" MAPPINGS
" ========

" Just don't forget sudo
nnoremap W :w !sudo tee %<CR><CR>
nnoremap Q :w !sudo tee %<CR><CR>:q!<CR>

" Toggle set list with \+l
nnoremap <leader>l :set list!<CR>

" Toggle number with \+n
nnoremap <leader>n :set number!<CR>

" Toggle relativenumber with \+N
nnoremap <leader>N :set relativenumber!<CR>

" Toggle indentation chars
nnoremap <leader>m :IndentLinesToggle<CR>

" Toggle set paste with \+p
nnoremap <leader>p :setlocal paste!<CR>

" Toggle RainbowLevels with \+r
map <leader>r :RainbowLevelsToggle<cr>

" Toggle Syntastic
nnoremap <leader>t :SyntasticToggleMode<CR>

" Strip whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Select pasted text
noremap <leader>v V`]

" Copy on mouse-select - disabled in favour of pastebot
"noremap <LeftRelease> "+y<LeftRelease>

nmap <F3> i<C-R>=strftime("%Y-%m-%d %H:%M")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>

