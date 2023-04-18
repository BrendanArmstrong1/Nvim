return {
  -- Fugitive
  {
    "tpope/vim-fugitive",
    cmd = "G",
    init = function()
      vim.api.nvim_set_keymap("n", "<leader>gp", "<CMD>Git push<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>gd", "<CMD>Gdiffsplit<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>gD", "<CMD>Gdiffsplit!<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>ga", "<CMD>diffget //2<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>gi", "<CMD>diffget //3<CR>", {})
    end,
    keys = {
      { "<leader>gg", "<CMD>Git<CR>" },
      { "<leader>gc", "<CMD>Git commit<CR>" },
      { "<leader>gl", "<CMD>Git log<CR>" },
      { "<leader>gb", "<CMD>Git blame<CR>" },
    },
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              return "]h"
            end
            vim.schedule(function()
              gs.next_hunk()
              vim.cmd("norm! zz")
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[h", function()
            if vim.wo.diff then
              return "[h"
            end
            vim.schedule(function()
              gs.prev_hunk()
              vim.cmd("norm! zz")
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          -- stylua: ignore start
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
          map("n", "<leader>HS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>HR", gs.reset_buffer)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end)
          map("n", "<leader>hl", gs.toggle_current_line_blame)
          map("n", "<leader>hd", gs.diffthis)
          map("n", "<leader>HD", function() gs.diffthis("~") end)
          map("n", "<leader>ht", gs.toggle_deleted)
          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
          -- stylua: ignore end
        end,
      })
    end,
  },
}