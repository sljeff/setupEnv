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

Plug 'chaoren/vim-wordmotion'
Plug 'psliwka/vim-smoothie'
Plug 'romainl/vim-cool'

" Initialize plugin system
call plug#end()

lua << EOF
local lines = vim.opt.lines._value
local columns = vim.opt.columns._value
vim.g.is_horizontal = true
if (lines * 2 > columns) then
	vim.g.is_horizontal = false
end
vim.g.mapleader = " "
vim.opt.completeopt = "menu,menuone,noselect"

-- lsp and cmp and autopairs
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
  vim.call("vista#RunForNearestMethodOrFunction")
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

vim.g.rainbow_active = 0
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
if (vim.g.is_horizontal) then
	vim.g.floaterm_opener = 'vsplit'
	vim.api.nvim_set_keymap("n", "<C-A-n>", ":FloatermNew --opener=vsplit xplr<CR>", { silent = true, noremap = true, })
else
	vim.g.floaterm_opener = 'split'
	vim.api.nvim_set_keymap("n", "<C-A-n>", ":FloatermNew --opener=split xplr<CR>", { silent = true, noremap = true, })
end
vim.api.nvim_set_keymap("n", "<C-n>", ":FloatermNew --opener=edit xplr<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "ccc", ":FloatermNew<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("t", "ccc", "<C-\\><C-n>:FloatermNew<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("t", "ppp", "<C-\\><C-n>:FloatermPrev<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("t", "nnn", "<C-\\><C-n>:FloatermNext<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("i", "<m-=>", "<C-\\><C-n>:FloatermToggle<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<m-=>", ":FloatermToggle<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("t", "<m-=>", "<C-\\><C-n>:FloatermToggle<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("t", "<m-q>", "<C-\\><C-n>", { silent = true, noremap = true, })

vim.api.nvim_command([[
filetype plugin indent on
syntax enable
colorscheme PaperColor
autocmd Filetype go,python,yaml,javascript,cmake,make,ruby AnyFoldActivate]])
vim.opt.foldlevel = 99  -- Open all folds

-- vista
vim.g.vista_default_executive = "ctags"
vim.g.vista_executive_for = {
	go = 'nvim_lsp',
	python = 'nvim_lsp',
	}
vim.g['vista#renderer#enable_icon'] = 1
vim.g.vista_disable_statusline = true
if (vim.g.is_horizontal) then
	vim.g.vista_sidebar_open_cmd = tostring(math.ceil(columns*0.2)) .. 'vsplit'
else
	vim.g.vista_sidebar_open_cmd = tostring(math.ceil(lines*0.3)) .. 'split'
end
vim.api.nvim_set_keymap("n", "=", ":Vista finder<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>=", ":Vista!!<cr>", { noremap = true, })

-- lualine and bufferline
vim.opt.termguicolors = true
require'lualine'.setup{
	sections = {
		lualine_a = {'mode', 'b:vista_nearest_method_or_function'},
		lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp'}}},
		lualine_c = {{'filename', file_status = true, path = 1, shorting_target = 40}},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
		},
	}
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
vim.api.nvim_set_keymap("n", "<Leader>m", ":noh<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>n", ":bn<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>p", ":bp<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>d", ":bd<CR>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<A-c>", ":BufferLinePickClose<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { silent = true, noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { silent = true, noremap = true, })

-- telescope
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>ca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<C-m>d", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<C-m>a", "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>gs", "<cmd>lua require('telescope.builtin').git_status()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>gb", "<cmd>lua require('telescope.builtin').git_branches()<cr>", { noremap = true, })

require('telescope').setup{
  defaults = {
    layout_strategy = vim.g.is_horizontal and "horizontal" or "vertical",
    path_display = {"smart"}
  },
  pickers = {
    find_files = {
      path_display = {"absolute"}
    }
  }
}

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.backspace = 'indent,eol,start'
-- Required for operations modifying multiple buffers like rename.
vim.opt.hidden = true
vim.opt.encoding = 'utf-8'
vim.opt.background = 'light'
EOF
