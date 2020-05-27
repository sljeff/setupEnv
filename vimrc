if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/jeff/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/jeff/.cache/dein')
  call dein#begin('/home/jeff/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/jeff/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('flazz/vim-colorschemes')
  
  call dein#add('stephpy/vim-yaml')
  
  call dein#add('jiangmiao/auto-pairs')
  
  " call dein#add('zxqfl/tabnine-vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  if has('win32') || has('win64')
    call dein#add('tbodt/deoplete-tabnine', { 'build': 'powershell.exe .\install.ps1' })
  else
    call dein#add('tbodt/deoplete-tabnine', { 'build': './install.sh' })
  endif

  " LSP
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')
  
  " (Optional) Multi-entry selection UI.
  call dein#add('junegunn/fzf')
  
  call dein#add('luochen1990/rainbow')
  
  call dein#add('skywind3000/vim-terminal-help')

  call dein#add('itchyny/lightline.vim')
  call dein#add('mengelbrecht/lightline-bufferline')
  call dein#add('itchyny/vim-gitbranch')

  call dein#add('Shougo/denite.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('thaerkh/vim-indentguides')

  call dein#add('Shougo/defx.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('kristijanhusak/defx-git')

  call dein#add('kristijanhusak/defx-icons')

  call dein#add('mhinz/vim-startify')

  call dein#add('liuchengxu/vista.vim')

  call dein#add('pseewald/vim-anyfold')

  call dein#add('itchyny/vim-cursorword')

  " Required:
  call dein#end()
  call dein#save_state()
endif

let mapleader=" "

" deoplete
let g:deoplete#enable_at_startup = 1
set completeopt=menu,noselect
call deoplete#custom#option({
\ 'prev_completion_mode': "mirror",
\ })

" lsp
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gi :LspImplementation<CR>
nnoremap <silent> K :LspHover<CR>
nnoremap <silent> <F2> :LspRename<CR>
nnoremap <silent> df :LspDocumentFormat<CR>:w<CR>
nnoremap <Leader><C-n> :LspNextDiagnostic<CR>
nnoremap <C-m>d :LspDocumentDiagnostics<CR>

let g:rainbow_active = 0

let g:terminal_shell = "fish"
let g:terminal_kill = "term"
let g:terminal_list = 0
let g:terminal_cwd = 2
let g:terminal_edit = 'e'
let g:terminal_height = 30

let g:defx_git#indicators = {
  \ 'Modified'  : 'M',
  \ 'Staged'    : '+',
  \ 'Untracked' : '?',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '=',
  \ 'Ignored'   : '.',
  \ 'Deleted'   : 'X',
  \ 'Unknown'   : 'e'
  \ }
let g:defx_git#column_length = 0
let g:defx_icons_enable_syntax_highlight = 1

" Required:
filetype plugin indent on
syntax enable

" anyfold
autocmd Filetype * AnyFoldActivate               " activate for all filetypes
set foldlevel=1 " Open all folds

" vista
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
  \ 'go': 'vim_lsp',
  \ 'python': 'vim_lsp',
  \ }
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_position = "rightbelow"
nnoremap = :Vista finder<cr>
nnoremap <Leader>= :Vista!!<cr>

set noshowmode
set showtabline=2
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline = {
    \ 'colorscheme': 'PaperColor',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name',
    \   'filename': 'LightlineFilename'
    \ },
    \ }
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" buffer line
nnoremap <Leader>m :noh<CR>
nnoremap <Leader>n :bn<cr>
nnoremap <Leader>p :bp<cr>
nnoremap <Leader>d :bd<cr>
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" denite
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <Leader>, :Denite buffer<CR>
nnoremap <Leader><Space> :Denite `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action', 'switch')
  nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'splitswitch')
  nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplitswitch')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
endfunction

" defx
call defx#custom#option('_', {
	\ 'ignored_files': '__pycache__,*.pyc,*.swp,.*',
	\ 'split': 'vertical',
	\ 'winwidth': 25,
	\ 'toggle': 1,
	\ 'resume': 1,
	\ 'columns': 'git:indent:icons:filename:type',
	\ })
nnoremap <silent> - :Defx<CR>
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  setl nospell
  setl nonu nornu
  setl signcolumn=no
  nnoremap <silent><buffer><expr> <CR>
    \ defx#is_directory() ?
    \ defx#do_action('open_or_close_tree') :
    \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> M defx#do_action('rename')
  nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  nnoremap <silent><buffer><expr> D defx#do_action('remove')
  nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> <TAB> defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
endfunction

set nu
set rnu
set hlsearch
set incsearch

set backspace=indent,eol,start

" Required for operations modifying multiple buffers like rename.
set hidden
set encoding=utf-8

colorscheme PaperColor
set background=light

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
if executable('gopls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ })
endif
