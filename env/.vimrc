let mapleader = " "

let g:pdfReader = "zathura"
let g:webBrowser = "firefox"

set background=dark
colorscheme lunaperche

" set background=light
" colorscheme peachpuff

" set background=light
" colorscheme quiet

" set background=back
" colorscheme quiet

set clipboard=unnamedplus
set termguicolors
set mouse=a

let g:netrw_browse_split = 0
let g:netrw_banner = 1
let g:netrw_winsize = 25

set cmdheight=1
set guicursor=a:block-Cursor,i:ver30-iCursor,r-cr:hor20-Cursor
set wildignorecase
set encoding=utf-8
set fileencoding=utf-8
set switchbuf=usetab
set number

set tabstop=8
set shiftwidth=8
set smartindent
set noexpandtab

set nowrap
let &showbreak = '\-'

set noswapfile
set nobackup

set hlsearch
set incsearch

set scrolloff=30
set isfname+=@-@
set signcolumn=no
set foldmethod=marker
set foldmarker={,}
set foldlevelstart=99
set cursorline
set colorcolumn=72,80,120,180
set textwidth=72

set nolist
let &listchars = 'tab:> ,trail:*,space:·,nbsp:⍽'

highlight default Nbsp guibg=#666666 guifg=#ffffff

set ignorecase
set smartcase
" set spell
" set spelllang=en,fr,cjk

nnoremap <Enter> <Nop>
nnoremap <ESC> <Cmd>noh<CR>
nnoremap <C-k><C-n> :enew<CR>
tnoremap <C-q> <C-\><C-n>
tnoremap <C-w> <C-\><C-n>:call TermCw()<CR>:call feedkeys('i', 'n')<CR>
function! TermCw() abort
  let l:buf = bufnr('')
  if getbufvar(l:buf, '&buftype') !=# 'terminal' || !exists('*term_sendkeys')
    return
  endif
  call term_sendkeys(l:buf, "\<C-w>")
endfunction
nnoremap <leader>sk :split \| term make<CR>
nnoremap <C-k><C-v> :split \| terminal ++curwin<CR>
nnoremap <C-k><C-t> :term ++curwin<CR>
nnoremap <leader>sa ggVG
nnoremap <leader>gf <C-w>gF
nnoremap <A-s> :m +1<CR>
nnoremap <A-r> :m -2<CR>
vnoremap <A-s> :m '>+1<CR>gv
vnoremap <A-r> :m '<-2<CR>gv
nnoremap ! :!
vnoremap ! :!
nnoremap <leader>w <Cmd>write<CR>
vnoremap <leader>w <Cmd>write<CR>
nnoremap - 0
vnoremap - 0
xnoremap - 0
nnoremap ; :
vnoremap ; :
xnoremap ; :
nnoremap : ;
vnoremap : ;
xnoremap : ;
nnoremap j gj
vnoremap j gj
xnoremap j gj
nnoremap k gk
vnoremap k gk
xnoremap k gk
nnoremap R gR
vnoremap R gR
xnoremap R gR
nnoremap <leader>cz :center<CR>
vnoremap <leader>cz :center<CR>
xnoremap <leader>cz :center<CR>
nnoremap <leader>y :call s:open_pdf()<CR>

function! s:open_pdf() abort
  call job_start([g:pdfReader, expand('%:p:r') . '.pdf'], #{detach: 1})
endfunction

augroup CitronYank
  autocmd!
  autocmd TextYankPost * call s:highlight_yank()
augroup END

let s:yank_match = -1
let s:yank_timer = -1

function! s:clear_yank(...) abort
  if s:yank_match != -1
    call matchdelete(s:yank_match)
    let s:yank_match = -1
  endif
  let s:yank_timer = -1
endfunction

function! s:highlight_yank() abort
  if v:event.operator !~# '[dy]' || empty(v:event.regcontents)
    return
  endif
  if s:yank_timer != -1
    call timer_stop(s:yank_timer)
  endif
  call s:clear_yank()
  let l:pat = '\V' . join(map(copy(v:event.regcontents), 'escape(v:val, ''\\'')'), '\n')
  let s:yank_match = matchadd('IncSearch', l:pat, 90)
  let s:yank_timer = timer_start(120, function('s:clear_yank'))
endfunction

let s:fcitx_available = 0
let s:last_ime = ''

if executable('fcitx5-remote')
  call system('fcitx5-remote')
  let s:fcitx_available = (v:shell_error != 255)
endif

if s:fcitx_available
  augroup CitronFcitx
    autocmd!
    autocmd InsertLeave * call s:fcitx_leave()
    autocmd InsertEnter * call s:fcitx_enter()
  augroup END
endif

function! s:fcitx_leave() abort
  let l:im = system('fcitx5-remote -n')
  if v:shell_error == 0
    let s:last_ime = trim(l:im)
  endif
  call system('fcitx5-remote -c')
endfunction

function! s:fcitx_enter() abort
  if s:last_ime !=# ''
    call system('fcitx5-remote -s ' . shellescape(s:last_ime))
  endif
endfunction

augroup CitronMode
  autocmd!
  autocmd ModeChanged * call s:mode_changed()
augroup END

function! s:mode_changed() abort
  if mode() =~# '[vV\x16]'
    set list
  else
    set nolist
  endif
endfunction
