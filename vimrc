" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

Plug 'flazz/vim-colorschemes'

Plug 'stephpy/vim-yaml'

Plug 'junegunn/fzf'

Plug 'windwp/nvim-autopairs'

Plug 'neovim/nvim-lspconfig'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

Plug 'luochen1990/rainbow'

Plug 'voldikss/vim-floaterm'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

Plug 'tpope/vim-fugitive'

Plug 'nvim-lua/plenary.nvim' | Plug 'nvim-telescope/telescope.nvim'

Plug 'mhinz/vim-startify'

Plug 'liuchengxu/vista.vim'

Plug 'pseewald/vim-anyfold'

Plug 'wakatime/vim-wakatime'

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'itchyny/vim-cursorword'

" Initialize plugin system
call plug#end()

let mapleader=" "

" lsp and coq
let g:coq_settings = {
 \"clients.tabnine.enabled": v:true,
 \'auto_start': 'shut-up',
 \'limits.completion_auto_timeout': 2,
 \'clients.lsp.resolve_timeout': 2
 \}
lua << EOF
local nvim_lsp = require('lspconfig')
local coq = require "coq"
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
  nvim_lsp[lsp].setup(
    coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
    })
  )
end
EOF

" autopairs
lua << EOF
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
EOF

let g:rainbow_active = 0

let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_opener = 'split'
nnoremap   <silent>   <C-n>   :FloatermNew --opener=edit xplr<CR>
nnoremap   <silent>   ccc     :FloatermNew<CR>
tnoremap   <silent>   ccc     <C-\><C-n>:FloatermNew<CR>
tnoremap   <silent>   ppp     <C-\><C-n>:FloatermPrev<CR>
tnoremap   <silent>   nnn     <C-\><C-n>:FloatermNext<CR>
inoremap   <silent>   <m-=>   <C-\><C-n>:FloatermToggle<CR>
nnoremap   <silent>   <m-=>   :FloatermToggle<CR>
tnoremap   <silent>   <m-=>   <C-\><C-n>:FloatermToggle<CR>
tnoremap   <silent>   <m-q>   <C-\><C-n>

" Required:
filetype plugin indent on
syntax enable

" anyfold
autocmd Filetype go,python,yaml,javascript,cmake,make,ruby AnyFoldActivate
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

" lualine and bufferline
set termguicolors
lua << END
require'lualine'.setup()
require("bufferline").setup{
  highlights = {
    fill = { guibg = '#005f87' },
    buffer_selected = { gui = 'bold' },
    diagnostic_selected = { gui = 'bold' },
    info_selected = { gui = 'bold' },
    info_diagnostic_selected = { gui = 'bold' },
    warning_selected = { gui = 'bold' },
    warning_diagnostic_selected = { gui = 'bold' },
    error_selected = { gui = 'bold' },
    error_diagnostic_selected = { gui = 'bold' },
  },
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    groups = {}, -- see :h bufferline-groups for details
    show_tab_indicators = true,
    show_close_icon = false,
    separator_style = 'thin',
    enforce_regular_tabs = false,
  }
}
END
nnoremap <Leader>m :noh<CR>
nnoremap <silent><A-n> :BufferLineCycleNext<CR>
nnoremap <silent><A-p> :BufferLineCyclePrev<CR>
nnoremap <silent><A-N> :BufferLineMoveNext<CR>
nnoremap <silent><A-P> :BufferLineMovePrev<CR>
nnoremap <silent><A-c> :BufferLinePickClose<CR>
nnoremap <silent><C-s> :BufferLinePick<CR>
nnoremap <silent><Leader>bd :BufferLineSortByDirectory<CR>
nnoremap <silent><Leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><Leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><Leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><Leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><Leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><Leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><Leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><Leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><Leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

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
