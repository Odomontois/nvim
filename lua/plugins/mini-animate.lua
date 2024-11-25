return {
  -- Only for cursor animation
  'echasnovski/mini.animate',
  event = "VeryLazy",
  config = function ()
    require('mini.animate').setup(
      {
        scroll = {
          enable = false,
        },
        resize = {
          enable = false,
        },
        open = {
          enable = false,
        },
        close = {
          enable = false,
        },
      }
    )
  end
}
