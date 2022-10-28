vim.cmd [[packadd packer.nvim]]
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'flazz/vim-colorschemes'

  use 'stephpy/vim-yaml'

  use 'junegunn/fzf'

  use 'windwp/nvim-autopairs'

  use 'neovim/nvim-lspconfig'
  use 'ray-x/lsp_signature.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind-nvim'

  use 'luochen1990/rainbow'

  use 'voldikss/vim-floaterm'

  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'noib3/nvim-cokeline'

  use 'tpope/vim-fugitive'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use 'goolord/alpha-nvim'

  use 'nvim-treesitter/nvim-treesitter'
  use 'SmiteshP/nvim-gps'

  use 'pseewald/vim-anyfold'

  use 'wakatime/vim-wakatime'

  use 'Vimjas/vim-python-pep8-indent'

  use 'itchyny/vim-cursorword'

  use 'psliwka/vim-smoothie'

  use 'lukas-reineke/indent-blankline.nvim'

  use 'dstein64/vim-startuptime'

  use 'khaveesh/vim-fish-syntax'

  use 'puremourning/vimspector'

  use 'isobit/vim-caddyfile'

  use 'github/copilot.vim'

end)

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
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<space><C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<space><C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<C-m>d', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)
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
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'vsnip' },
  }),
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  }
})
-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { "pylsp", "clangd", "gopls", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  })
end
require "lsp_signature".setup({})

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "go", "javascript", "python" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

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

-- gps
local gps = require("nvim-gps")
gps.setup()

-- lualine and cokeline
vim.opt.termguicolors = true
require'lualine'.setup{
  sections = {
    lualine_a = {'mode', { gps.get_location, cond = gps.is_available }},
    lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_diagnostic'}}},
    lualine_c = {{'filename', file_status = true, path = 1, shorting_target = 40}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
require('cokeline').setup({
  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and "#800080" or "#3B78FF"
    end,
    bg = function(buffer)
      return buffer.is_focused and "#ffffff" or "#D3D3D3"
    end,
  },
  components = {
    {text = '| '},
    {
      text = function(buffer)
        return buffer.index .. " "
      end,
      style = function(buffer)
        return buffer.is_focused and "bold" or nil
      end,
    },
    {
      text = function(buffer) return buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = function(buffer) return buffer.unique_prefix end,
      fg = '#000000',
      style = 'italic',
    },
    {
      text = function(buffer) return buffer.filename end,
    },
    {
      text = function(buffer)
        local errors = buffer.diagnostics.errors
        local warnings = buffer.diagnostics.warnings
        local hints = buffer.diagnostics.hints
        local infos = buffer.diagnostics.infos
        if errors ~= 0 then
          return "  " .. errors
        elseif warnings ~= 0 then
          return "  " .. warnings
        elseif hints ~= 0 then
          return "  " .. hints
        elseif infos ~= 0 then
          return "  " .. infos
        end
	return ""
      end,
      hl = {
        fg = function(buffer)
          local errors = buffer.diagnostics.errors
          local warnings = buffer.diagnostics.warnings
          local hints = buffer.diagnostics.hints
          local infos = buffer.diagnostics.infos
          if errors ~= 0 then
            return "#EC5241"
          elseif warnings ~= 0 then
            return "#EFB839"
          elseif hints ~= 0 then
            return "#A3BA5E"
          elseif infos ~= 0 then
            return "#7EA9A7"
          end
        end
      }
    },
    {
      text = function(buffer)
        return buffer.is_modified and " ●" or ""
      end,
      hl = {
        fg = function(buffer)
          return buffer.is_focused and '#ff0000'
        end,
      },
    },
    {
      text = ' ',
    }
  },
})
vim.api.nvim_set_keymap("n", "<Leader>m", ":noh<CR>", { noremap = true, })
-- vim.api.nvim_set_keymap('n', '<S-Tab>',   '<Plug>(cokeline-focus-prev)',  { silent = true })
-- vim.api.nvim_set_keymap('n', '<Tab>',     '<Plug>(cokeline-focus-next)',  { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '<Plug>(cokeline-focus-prev)', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>n', '<Plug>(cokeline-focus-next)', { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>d", ":bd<CR>", { noremap = true, })

for i = 1,9 do
  vim.api.nvim_set_keymap('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), { silent = true })
end

-- telescope
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<Leader>ca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<C-m>d", "<cmd>Telescope diagnostics bufnr=0<cr>", { noremap = true, })
vim.api.nvim_set_keymap("n", "<C-m>a", "<cmd>Telescope diagnostics<cr>", { noremap = true, })
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

vim.g.vimspector_enable_mappings = 'HUMAN'
require('alpha').setup(require'alpha.themes.dashboard'.opts)

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.backspace = 'indent,eol,start'
-- Required for operations modifying multiple buffers like rename.
vim.opt.hidden = true
vim.opt.encoding = 'utf-8'
vim.opt.background = 'light'
vim.opt.showmode = false
vim.opt.mouse=""
vim.cmd([[
filetype plugin indent on
syntax enable
colorscheme PaperColor
hi Normal guibg=NONE ctermbg=NONE
autocmd Filetype go,python,yaml,javascript,cmake,make,ruby AnyFoldActivate]])

vim.opt.foldlevel = 99  -- Open all folds

require("notify").setup({
  background_colour = "#000000",
})
