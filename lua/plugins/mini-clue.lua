return {
  'echasnovski/mini.clue',
  event = 'VeryLazy',
  opts = function()
    local miniclue = require 'mini.clue'

    -- Some builtin keymaps that I don't use and that I don't want mini.clue to show.
    for _, lhs in ipairs { '[%', ']%', 'g%' } do
      vim.keymap.del('n', lhs)
    end

    -- Clues for recorded macros.
    local function macro_clues()
      local res = {}
      for _, register in ipairs(vim.split('abcdefghijklmnopqrstuvwxyz', '')) do
        local keys = string.format('"%s', register)
        local ok, desc = pcall(vim.fn.getreg, register, 1)
        if ok and desc ~= '' then
          table.insert(res, { mode = 'n', keys = keys, desc = desc })
          table.insert(res, { mode = 'v', keys = keys, desc = desc })
        end
      end

      return res
    end

    return {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },

        -- Moving between stuff.
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },
      },
      clues = {
        -- Leader/movement groups.
        { mode = 'n', keys = '<leader>c',  desc = '+copilot' },
        { mode = 'v', keys = '<leader>c',  desc = '+copilot' },
        { mode = 'n', keys = '<leader>d',  desc = '+diagnostics' },
        { mode = 'n', keys = '<leader>g',  desc = '+goto' },
        -- LSP
        { mode = 'n', keys = '<leader>l',  desc = '+lsp' },
        { mode = 'v', keys = '<leader>l',  desc = '+lsp' },
        { mode = 'n', keys = '<leader>ld', desc = '+debug' },
        { mode = 'n', keys = '<leader>lm', desc = '+metals' },
        { mode = 'n', keys = '<leader>lo', desc = '+other' },
        { mode = 'n', keys = '<leader>lv', desc = '+view' },
        -- GIT
        { mode = 'n', keys = '<leader>m',  desc = '+git' },
        { mode = 'v', keys = '<leader>m',  desc = '+git' },
        { mode = 'n', keys = '<leader>mh', desc = '+hunk' },
        { mode = 'v', keys = '<leader>mh', desc = '+hunk' },
        { mode = 'n', keys = '<leader>mb', desc = '+buffer' },
        { mode = 'v', keys = '<leader>mb', desc = '+buffer' },

        { mode = 'n', keys = '<leader>n',  desc = '+noice' },
        { mode = 'n', keys = '<leader>s',  desc = '+search' },
        { mode = 'n', keys = '<leader>ss', desc = '+symbol' },
        { mode = 'n', keys = '<leader>t',  desc = '+tabs' },
        { mode = 'n', keys = '<leader>v',  desc = '+view' },
        -- Builtins.
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        -- Custom extras.
        -- mark_clues,
        macro_clues,
      },
      window = {
        delay = 500,
        -- todo unify all scrolls
        scroll_down = '<C-d>',
        scroll_up = '<C-u>',
        config = function(bufnr)
          local max_width = 0
          for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
            max_width = math.max(max_width, vim.fn.strchars(line))
          end

          -- Keep some right padding.
          max_width = max_width + 2

          return {
            border = 'rounded',
            -- Dynamic width capped at 45.
            width = math.min(45, max_width),
          }
        end,
      },
    }
  end,
}
