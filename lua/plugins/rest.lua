return {
  {
    "vhyrro/luarocks.nvim",
    enabled = true,
    lazy = true,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
    }
  },
  {
    "rest-nvim/rest.nvim",
    enabled = true,
    lazy = true,
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup({
        result = {
          split = {
            horizontal = true,
            in_place = false,
            stay_in_current_window_after_split = true,
          }
        }
      })

    end,
  }
}
