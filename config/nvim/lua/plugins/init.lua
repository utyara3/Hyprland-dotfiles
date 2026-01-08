return {
  -- Минимальная тема
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end
  },
  
  -- Файловый менеджер и поиск
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "plenary.nvim" },
    config = true
  },
  
  -- LSP для Python (без лишних настроек)
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = true },
  { 
    "williamboman/mason-lspconfig.nvim", 
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end
        }
      })
    end
  },
  
  -- Простое автодополнение
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  {
    "saadparwaiz1/cmp_luasnip",
    dependencies = { "LuaSnip" }
  },
  
  -- Статусная строка
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true
  },
  
  -- Дашборд с кастомным ASCII артом
  {
    "goolord/alpha-nvim",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      
      -- Ваш кастомный ASCII арт
      local ascii_art = {
        "                             ▄▄▄                ▄▄▄      ",
        "  █    ██ ▄▄▄█████▓▓██   ██▓▒████▄     ██▀███  ▒████▄    ",
        "  ██  ▓██▒▓  ██▒ ▓▒ ▒██  ██▒▒██  ▀█▄  ▓██ ▒ ██▒▒██  ▀█▄  ",
        " ▓██  ▒██░▒ ▓██░ ▒░  ▒██ ██░░██▄▄▄▄██ ▓██ ░▄█ ▒░██▄▄▄▄██ ",
        " ▓▓█  ░██░░ ▓██▓ ░   ░ ▐██▓░ ▓█   ▓██▒▒██▀▀█▄   ▓█   ▓██▒",
        " ▒▒█████▓   ▒██▒ ░   ░ ██▒▓░ ▒▒   ▓▒█░░██▓ ▒██▒ ▒▒   ▓▒█░",
        " ░▒▓▒ ▒ ▒   ▒ ░░      ██▒▒▒   ▒   ▒▒ ░░ ▒▓ ░▒▓░  ▒   ▒▒ ░",
        " ░░▒░ ░ ░     ░     ▓██ ░▒░   ░   ▒     ░▒ ░ ▒░  ░   ▒   ",
        "  ░░░ ░ ░   ░       ▒ ▒ ░░        ░  ░  ░░   ░       ░  ░",
        "    ░               ░ ░                  ░               ",
        "                                                         ",
        "           ES LEBE DER GROßE UNFEHLBARE \\O/             "
      }
      
      -- Функции для кнопок меню
      local button = dashboard.button
      dashboard.section.header.val = ascii_art
      dashboard.section.buttons.val = {
        button("f", "🔍 Find file", ":Telescope find_files <CR>"),
        button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        button("r", "  Recent files", ":Telescope oldfiles <CR>"),
        button("h", "  Find help", ":Telescope help_tags <CR>"),
        button("q", "🚪  Quit Neovim", ":qa<CR>"),
      }
      
      -- Настройка отступов
      dashboard.section.footer.val = ""
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"
      
      -- Автоматическое открытие дашборда при запуске без файлов
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if not vim.g.started_by_firenvim and vim.fn.argc() == 0 and vim.fn.line2byte(vim.fn.line("$")) <= 1 then
            alpha.start(true)
          end
        end,
        once = true
      })
      
      alpha.setup(dashboard.opts)
    end
  },
}
