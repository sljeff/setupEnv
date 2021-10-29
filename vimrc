" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

Plug 'flazz/vim-colorschemes'

Plug 'stephpy/vim-yaml'

Plug 'junegunn/fzf'

Plug 'windwp/nvim-autopairs'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'onsails/lspkind-nvim'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

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

" lsp and cmp and autopairs
set completeopt=menu,menuone,noselect
lua << EOF
local nvim_lsp = require('lspconfig')
local lspkind = require('lspkind')
local cmp = require'cmp'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
require('nvim-autopairs').setup{}
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
        max_lines = 1000;
        max_num_results = 20;
        sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
})
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
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine' },
    { name = 'buffer' },
    { name = 'vsnip' },
  }),
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  }
})
-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "pylsp", "clangd", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  })
end
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
require'lualine'.setup{}
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
    show_buffer_close_icons = false,
    separator_style = 'thin',
    enforce_regular_tabs = false,
    sort_by = 'id',
  }
}
END
nnoremap <Leader>m :noh<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <silent><A-c> :BufferLinePickClose<CR>
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
