return {
  "ibhagwan/fzf-lua",
  enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<C-CR>",      '<cmd>FzfLua lsp_code_actions<CR>',           mode = { "v", "n" } },

    -- { "<leader>gD",  "<cmd>FzfLua lsp_declarations<cr>",           desc = "lsp declarations" }, -- not supported by metals
    { "<leader>gf",  "<cmd>FzfLua files<cr>",                      desc = "find files" },
    { "<leader>gh",  "<cmd>FzfLua helptags<cr>",                   desc = "help tags" },
    { "<leader>gj",  "<cmd>FzfLua jumps<cr>",                      desc = "jumps" },
    { "<leader>gk",  "<cmd>FzfLua keymaps<cr>",                    desc = "keymaps" },
    { "<leader>gm",  "<cmd>FzfLua marks<cr>",                      desc = "marks" },

    -- lsp
    { "<leader>gd",  "<cmd>FzfLua lsp_definitions<cr>",            desc = "lsp definitions" },
    { "<leader>gi",  "<cmd>FzfLua lsp_implementations<cr>",        desc = "lsp implementations" },
    { "<leader>gr",  "<cmd>FzfLua lsp_references<cr>",             desc = "lsp references" },
    { "<leader>gsb", "<cmd>FzfLua lsp_document_symbols<cr>",       desc = "lsp symbols buffer" },
    { "<leader>gsl", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "lsp live workspace symbols" },
    { "<leader>gsw", "<cmd>FzfLua lsp_workspace_symbols<cr>",      desc = "lsp symbols workspace" },
    { "<leader>gt",  "<cmd>FzfLua lsp_typedefs<cr>",               desc = "lsp typedefs" },

    { "<leader>la",  "<cmd>FzfLua lsp_code_actions<cr>",           desc = "lsp code actions" },
    { "<leader>lci", "<cmd>FzfLua lsp_incoming_calls<cr>",         desc = "lsp calls incoming" },
    { "<leader>lco", "<cmd>FzfLua lsp_outgoing_calls<cr>",         desc = "lsp calls outgoing" },
    { "<leader>lf",  "<cmd>FzfLua lsp_finder<cr>",                 desc = "lsp finder" },

    -- git
    { "<leader>mB",  "<cmd>FzfLua git_branches<cr>",               desc = "git branches" },
    { "<leader>mc",  "<cmd>FzfLua git_commits<cr>",                desc = "git commits" },
    { "<leader>mbc", "<cmd>FzfLua git_bcommits<cr>",               desc = "git commits buffer" },
    { "<leader>mf",  "<cmd>FzfLua git_files<cr>",                  desc = "git files" },
    { "<leader>mm",  "<cmd>FzfLua git_status<cr>",                 desc = "git status" },
    { "<leader>ms",  "<cmd>FzfLua git_stash<cr>",                  desc = "git stash" },

    -- search
    { "<leader>sr",  "<cmd>FzfLua resume<cr>",                     desc = "resume" },
    { "<leader>ss",  "<cmd>FzfLua live_grep<cr>",                  desc = "search path" },
    { "<leader>sw",  "<cmd>FzfLua grep_cword<cr>",                 desc = "search cursor" },

    -- buffers
    { "<leader>to",  "<cmd>FzfLua oldfiles<cr>",                   desc = "old tabs" },
    { "<leader>tr",  "<cmd>FzfLua buffers<cr>",                    desc = "recent tabs" },

    -- diagnostics
    { "<leader>db",  "<cmd>FzfLua lsp_document_diagnostics<cr>",   desc = "lsp diagnostics buffer" },
    { "<leader>dw",  "<cmd>FzfLua lsp_workspace_diagnostics<cr>",  desc = "lsp diagnostics workspace" },

    -- dap
    { "<leader>lds", "<cmd>FzfLua dap_breakpoints<cr>",            desc = "debug breakpoints" },
    { "<leader>lds", "<cmd>FzfLua dap_variables<cr>",              desc = "debug variables" },
  },
  config = function()
    local actions = require "fzf-lua.actions"

    require 'fzf-lua'.setup {
      "telescope", -- :FzfLua profiles
      defaults    = {
        formatter  = "path.filename_first",
        cwd_only   = true,
        sync       = false, -- TODO find out what this do ???
        file_icons = true,
      },
      winopts     = {
        height     = 0.85,       -- window height
        width      = 0.80,       -- window width
        row        = 0.35,       -- window row position (0=top, 1=bottom)
        col        = 0.50,       -- window col position (0=left, 1=right)
        fullscreen = false,      -- start fullscreen?
        preview    = {
          hidden   = 'nohidden', -- hidden|nohidden
          vertical = 'up:60%',   -- up|down:size
          layout   = 'vertical', -- horizontal|vertical|flex
        },
      },
      fzf_opts    = {
        ["--ansi"]   = true,
        ["--info"]   = "inline-right",
        ["--height"] = "100%",
        ["--layout"] = "default",
        ["--border"] = "none",
      },
      files       = {
        prompt       = 'Files❯ ',
        multiprocess = true, -- run command in a separate process
        git_icons    = true, -- show git icons?
        color_icons  = true, -- colorize file|git icons
        actions      = {
          ["ctrl-g"] = { actions.toggle_ignore },
        }
      },
      grep        = {
        rg_glob = true, -- always parse globs in both 'grep' and 'live_grep'
      },
      lsp         = {
        prompt_postfix        = '❯ ', -- will be appended to the LSP label
        jump_to_single_result = true,
        ignore_current_line   = true, -- not sure if I want this behaviour
        includeDeclaration    = false, -- include current declaration in LSP context
        async_or_timeout      = 5000, -- timeout(ms) or 'true' for async calls
        git_icons             = false,
        finder                = {
          includeDeclaration = false, -- include current declaration in LSP context
        },
        symbols               = {
          symbol_style = 2 -- 1: icon+kind, 2: icon only, 3: kind only, false: disable
        }
      },
      git         = {
        status = {
          actions = {
            ["right"]  = false,
            ["left"]   = false,
            ["ctrl-x"] = { fn = actions.git_reset, reload = true },
            ["ctrl-s"] = { fn = actions.git_stage_unstage, reload = true },
          }
        }
      },
      diagnostics = {
        prompt       = 'Diagnostics❯ ',
        git_icons    = false,
        diag_icons   = true,
        diag_source  = false, -- display diag source (e.g. [pycodestyle])
        icon_padding = ' ',   -- add padding for wide diagnostics signs
        multiline    = true,  -- concatenate multi-line diags into a single line
        signs        = {
          ["Error"] = { text = '', texthl = "DiagnosticError" },
          ["Warn"]  = { text = '', texthl = "DiagnosticWarn" },
          ["Info"]  = { text = '', texthl = "DiagnosticInfo" },
          ["Hint"]  = { text = '', texthl = "DiagnosticHint" },
        },
      },
    }
  end
}
