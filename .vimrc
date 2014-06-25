if has('vim_starting')
  set nocompatible

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
      \    'build' : {
      \      'mac' : 'make -f make_mac.mak',
      \      'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'

NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tomtom/tcomment_vim'

NeoBundle 'thinca/vim-ref'
NeoBundle 'taka84u9/vim-ref-ri'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tomasr/molokai'

NeoBundle 'mattn/emmet-vim'
NeoBundle 'othree/html5.vim'

NeoBundle 'todesking/ruby_hl_lvar.vim'
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'tpope/vim-endwise'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck



"""General:
colorscheme molokai

set fileformat=unix
set fileencoding=utf-8

" Tmux color
set t_ut=
set t_Co=256

" No beep
set visualbell t_vb=
set noerrorbells

set number
set showtabline=2
set showmatch
set cursorline
set laststatus=2

set autoindent
set backspace=2
set mouse=a
set clipboard+=unnamed

" Deny create file
set noswapfile
set nobackup
set viminfo=

" For search
set infercase
set ignorecase
set smartcase
set incsearch

" Command completion
set wildmenu

" Tab to 2space
set expandtab
set tabstop=2
set softtabstop=0
set shiftwidth=2

" Remove space in end of line
autocmd BufWritePre * :%s/\s\+$//ge

" Markdown extension
autocmd BufRead,BufNewFile *.md set filetype=markdown



"""Neocomplete:
" Use neocomplete
let g:neocomplete#enable_at_startup = 1
" Use smartcase
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword lengt
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary
let g:neocomplete#sources#dictionary#dictionaries = {
      \    'default' : '',
      \    'vimshell' : $HOME.'/.vimshell_hist',
      \    'scheme' : $HOME.'/.gosh_completions',
      \ }

" Define keyword
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Define function
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" Enable omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Enable other heavy omni completion
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby =
			\ '[^. *\t]\.\w*\|\h\w*::'



"""Syntastic:
" Enable showing error signs
let g:syntastic_enable_signs = 1
" Enable ruby syntax check
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']



"""Quickrun:
" Desynchronize execute
" Show run time at ruby
let g:quickrun_config = {
      \    "_" : {
      \       "outputter/buffer/split" : ":botright 6sp",
      \       "runner" : "vimproc",
      \       "runner/vimproc/updatetime" : 60,
      \    },
      \    "ruby" : {
      \       "hook/time/enable" : 1,
      \    },
      \ }



"""Lightline:
let g:lightline = {
      \    'colorscheme': 'wombat'
      \ }



"""Emmet:
" Define keymap
let g:user_emmet_expandabbr_key = '<C-e>'
" Set lang=ja
let g:user_emmet_settings = {
      \    'lang' : 'ja'
      \ }



"""General:
nnoremap & <NOP>
" w!         - Save as super user
cnoremap w! :w !sudo tee >/dev/null %<CR>
" <ESC><ESC> - Disable highlight
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

"""NeoComplete:
" <TAB> - Completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-g> - Undo completion
inoremap <expr><C-g> neocomplete#undo_completion()
" <C-y> - Close popup
inoremap <expr><C-y>  neocomplete#close_popup()
" <CR>  - Close popup and save indent
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" <BS>  - Close popup and delete backword char
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

"""Unite:
" uf - Open Unite filer
nnoremap <silent> uf :<C-u>UniteWithBufferDir -buffer-name=files -winheight=10 file<CR>
" ub - Open most recently used file
nnoremap <silent> ub :<C-u>Unite -winheight=10 file_mru buffer<CR>

"""UniteOutline:
" uo - Open Unite outline
nnoremap <silent> uo :<C-u>:Unite -vertical -winwidth=30 outline<CR>

"""Quickrun:
" rr - Run quickly
nnoremap <silent> rr :QuickRun ruby <CR>
" Enable <C-c> for Quickrun
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

"""Surround:
" ds'  - Delete surround '
" cs'" - Change surround ' to "

"""TComment:
" <C-_><C-_> - Comment out

"""Ref:
" re - Search ref word on cursor
nmap <silent> re <Plug>(ref-keyword)

"""Emmet:
" <C-e> - Unfolding emmet

"""TabPage:
" tc - Create new tab page
nnoremap tc :tablast <bar> tabnew<CR>
" tx - Close current tab page
nnoremap tx :tabclose<CR>
" tn - Next tab
nnoremap tn :tabnext<CR>
" tp - Prev tab
nnoremap tp :tabprevious<CR>

"""TextObject:
" di' - Delete inner '
" ci' - Change inner '
" dib - Delete inner bracket
" dw  - Delete word
" cw  - Change word

"""Window:
" <C-w>v - Vertical split
" <C-w>s - Horizontal split
" <C-w>c - Close one
" <C-w>w - Move next window

"""Vim:
" hjkl  - Move up, down, left and right
" w     - Next word
" e     - Next end of word
" b     - Prev word
" 0     - Begining of line
" ^     - Begining of line (Ignore indent)
" $     - End of line
" %     - Jump pair word
" gg    - Begining of file
" G     - End of file

" <C-f> - Next scroll
" <C-b> - Prev scroll
" <C-d> - Next half scroll
" <C-u> - Prev half scroll

" x     - Delete char
" dd    - Delete line
" yy    - Yank
" p     - Paste
" V     - Line visual mode
" <C-v> - Rectangle visual mode

" /     - Search
" n     - Next result
" N     - Prev result
" *     - Search word on cursor

" u     - Undo
" <C-r> - Redo
" =     - Indent
" >>    - Increase indent
" <<    - Decrease indent
" ~     - Upcase and Downcase

" <C-o> - Jump old mark
" <C-i> - Jump new mark
