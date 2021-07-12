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
  
  call dein#add('nvim-lua/completion-nvim')
  call dein#add('aca/completion-tabnine')
  call dein#add('kristijanhusak/completion-tags')

  " LSP
  call dein#add('neovim/nvim-lspconfig')

  " (Optional) Multi-entry selection UI.
  call dein#add('junegunn/fzf')
  
  call dein#add('luochen1990/rainbow')
  
  call dein#add('skywind3000/vim-terminal-help')

  call dein#add('itchyny/lightline.vim')
  call dein#add('mengelbrecht/lightline-bufferline')

  call dein#add('tpope/vim-fugitive')

  call dein#add('Shougo/denite.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

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

  " call dein#add('itchyny/vim-cursorword')
  " call dein#add('RRethy/vim-illuminate')

  call dein#add('wakatime/vim-wakatime')

  call dein#add('Vimjas/vim-python-pep8-indent')

  " Required:
  call dein#end()
  call dein#save_state()
endif

let mapleader=" "

" completion
autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_enable_auto_popup = 1
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_signature = 1
let g:completion_chain_complete_list = {
      \ 'default': [
      \    {'complete_items': ['tabnine', 'lsp', 'tags']},
      \  ]}
let g:completion_confirm_key = ""
let g:completion_sorting = "none"
let g:completion_tabnine_tabnine_path = "/home/jeff/.cache/dein/repos/github.com/aca/3.5.15/binaries/TabNine"
let g:completion_tabnine_sort_by_details=1
let g:completion_tabnine_priority = 1000

" lsp
lua << EOF
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space><C-p>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<space><C-n>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<C-m>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyls", "clangd", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

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
set foldlevel=99 " Open all folds

" vista
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
  \ 'go': 'nvim_lsp',
  \ 'python': 'nvim_lsp',
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
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline = {
    \ 'colorscheme': 'PaperColor',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component': {
    \   'lineinfo': ' %3l:%-2v',
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'readonly': 'LightlineReadonly',
    \   'fugitive': 'LightlineFugitive'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
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
function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ''.branch : ''
	endif
	return ''
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
  nnoremap <silent><buffer><expr> gq denite#do_map('quit')
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
  nnoremap <silent><buffer><expr> gq defx#do_action('quit')
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
endfunction

set nu
set rnu
set hlsearch
set incsearch
" set nowrap

set backspace=indent,eol,start

" Required for operations modifying multiple buffers like rename.
set hidden
set encoding=utf-8

colorscheme PaperColor
set background=light
