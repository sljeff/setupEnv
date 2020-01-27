let mapleader=" "

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
  
  call dein#add('zxqfl/tabnine-vim')
  
  " LSP
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')
  nnoremap <silent> gd :LspDefinition<CR>
  nnoremap <silent> gi :LspImplementation<CR>
  nnoremap <silent> K :LspHover<CR>
  nnoremap <silent> <F2> :LspRename<CR>
  nnoremap <silent> df :LspDocumentFormat<CR>:w<CR>
  nnoremap <Leader><C-n> :LspNextDiagnostic<CR>
  nnoremap <C-m>d :LspDocumentDiagnostics<CR>
  
  " (Optional) Multi-entry selection UI.
  call dein#add('junegunn/fzf')
  
  call dein#add('luochen1990/rainbow')
  let g:rainbow_active = 0
  
  call dein#add('skywind3000/vim-terminal-help')
  let g:terminal_shell = "fish"
  let g:terminal_kill = "term"
  let g:terminal_list = 0
  let g:terminal_cwd = 2
  " let g:terminal_edit = 'e'  " do not use drop

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

  call dein#add('kristijanhusak/defx-icons')
  let g:defx_icons_enable_syntax_highlight = 1

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

set noshowmode
set showtabline=2
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name'
    \ },
    \ }
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

nnoremap <Leader>m :noh<CR>
nnoremap <Leader>n :bn<cr>
nnoremap <Leader>p :bp<cr>
nnoremap <Leader>d :bd<cr>

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <Leader>, :Denite buffer<CR>
nnoremap <Leader><Space> :Denite -auto-action=preview `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action', 'switch')
  nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'splitswitch')
  nnoremap <silent><buffer><expr> v denite#do_map('do_action', 'vsplitswitch')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
endfunction

nnoremap <silent> - :Defx -split=vertical -winwidth=30 -toggle -resume -columns=git:icons:indent:filename:type<CR>
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

colorscheme seattle

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
