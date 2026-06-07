return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      -- Keep netrw functional
      disable_netrw = false,
      hijack_netrw = false,
      sync_root_with_cwd = true,

      -- 1. Automatically highlight the current file in the tree
      update_focused_file = {
        enable = true,
        update_root = true,
      },

      view = {
        width = 35,
        relativenumber = true,
        side = "left",
      },

      -- 2. Visual enhancements (Git icons and indent markers)
      renderer = {
        highlight_git = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },

      -- 3. Filter out clutter
      filters = {
        dotfiles = false,
        custom = { ".git", "node_modules", ".cache" },
      },

      -- 4. Behavior
      actions = {
        open_file = {
          quit_on_open = false, -- Keep tree open after opening a file
          window_picker = {
            enable = true,
          },
        },
      },
    })
  end,
}
