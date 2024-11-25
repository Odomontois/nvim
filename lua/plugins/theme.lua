return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()

      vim.cmd.colorscheme "tokyonight-storm"
    end,
    dependencies = {
      {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
          -- "SmiteshP/nvim-navic",
          "nvim-tree/nvim-web-devicons",
        },
        opts = {
          -- configurations go here
        }
      }
    }
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    enabled = false,
    config = function()
      -- Default options:
      require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave",  -- Load "wave" theme when 'background' option is not set
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      })

      -- setup must be called before loading
      -- vim.cmd("colorscheme kanagawa")
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    enabled = true,
    config = function()
      require("catppuccin").setup({
        flavour = "catppuccin-frappe",
        integrations = {
          cmp = true,
          flash = true,
          gitsigns = true,
          mason = true,
          lsp_trouble = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          mini = {
          enabled = true,
          indentscope_color = "lavender",
        },
          },
          indent_blankline = {
            enabled = true,
            scope_color = "lavender",      -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = false, -- requires extra steps to enable
          },
          neotree = true,
          nvimtree = true,
          noice = true,
          notify = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          ufo = true,
          fzf = true,
          which_key = true,
        },
        highlight_overrides = {
          all = function(colors)
            return {
              Search = { bg = colors.surface1 },
              LineNr = { fg = colors.overlay0 },
              CursorLine = { bg = colors.surface0 },
              CursorColumn = { bg = colors.surface0 },
              IndentBlanklineChar = { fg = colors.mantle },
              -- LspCodeLens = { fg = colors.flamingo },
              -- LspCodeLensSeparator = { fg = colors.pink },
              Comment = { fg = colors.overlay1 },
            }
          end,
        },
      })

      -- local palette = require("catppuccin.palettes").get_palette "frappe"

      -- vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#9DA9A0" })
      -- vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })
      vim.cmd.colorscheme "catppuccin-frappe"
    end
  },
}
