return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
  },
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
