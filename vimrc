" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

Plug 'flazz/vim-colorschemes'

Plug 'stephpy/vim-yaml'

Plug 'junegunn/fzf'

Plug 'jiangmiao/auto-pairs'

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/completion-nvim'
Plug 'aca/completion-tabnine', { 'do': 'version=3.1.9 ./install.sh' }
Plug 'kristijanhusak/completion-tags'

Plug 'luochen1990/rainbow'

Plug 'voldikss/vim-floaterm'

Plug 'itchyny/lightline.vim' | Plug 'mengelbrecht/lightline-bufferline'

Plug 'tpope/vim-fugitive'

Plug 'nvim-lua/plenary.nvim' | Plug 'nvim-telescope/telescope.nvim'

Plug 'kyazdani42/nvim-web-devicons' | Plug 'kyazdani42/nvim-tree.lua'

Plug 'mhinz/vim-startify'

Plug 'liuchengxu/vista.vim'

Plug 'pseewald/vim-anyfold'

Plug 'wakatime/vim-wakatime'

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'itchyny/vim-cursorword'

" Initialize plugin system
call plug#end()

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
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space><C-p>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<space><C-n>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<C-m>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pylsp", "clangd", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end
EOF

let g:rainbow_active = 0

let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
nnoremap   <silent>   ccc     :FloatermNew<CR>
tnoremap   <silent>   ccc     <C-\><C-n>:FloatermNew<CR>
tnoremap   <silent>   ppp     <C-\><C-n>:FloatermPrev<CR>
tnoremap   <silent>   nnn     <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <m-=>   :FloatermToggle<CR>
tnoremap   <silent>   <m-=>   <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <m-q>   <C-\><C-n>

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

" telescope
nnoremap <Leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <Leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <Leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <Leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <Leader>ca <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <C-m>d     <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
nnoremap <C-m>a     <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>
nnoremap gr         <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap gd         <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap gi         <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <Leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <Leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
lua << EOF
require('telescope').setup{
  defaults = {
    layout_strategy = "vertical",
    path_display = {"absolute", "shorten"}
  },
  pickers = {
    find_files = {
      path_display = {"absolute"}
    }
  }
}
EOF

" tree
nnoremap <C-n> :NvimTreeToggle<CR>
set termguicolors
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_hide_dotfiles = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_lsp_diagnostics = 1

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
