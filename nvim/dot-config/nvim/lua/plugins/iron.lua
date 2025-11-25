return {
  "hkupty/iron.nvim",
  ft = "scheme",
  config = function()
    -- Configure iron.nvim with a simple Chez Scheme REPL definition.
    -- Assumptions:
    -- 1) The Chez Scheme executable is available as `scheme` on your PATH. If yours
    --    is named differently (for example `chez`), change the `command` below.
    -- 2) iron.nvim provides the `:IronRepl` command and `require("iron.core").send` API
    --    (this is how iron.nvim is commonly used).
    local ok, iron = pcall(require, "iron.core")
    if not ok then
      return
    end

    iron.setup {
      config = {
        scratch_repl = true,
        repl_definition = {
          scheme = {
            command = { "scheme" },
          },
        },
        -- open the REPL in a bottom split
        repl_open_cmd = "botright split",
      },
      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file   = "<leader>sf",
        send_line   = "<leader>sl",
        send_mark   = "<leader>sm",
        mark_motion = "<leader>mc",
        mark_visual = "<leader>mc",
        remove_mark = "<leader>md",
        cr          = "<leader>s<CR>",
        interrupt   = "<leader>s<space>",
        exit        = "<leader>sq",
        clear       = "<leader>cl",
      },
    }

    -- When a Scheme file is saved, reload it in the REPL with (load "<path>")
    -- This opens the REPL (if needed) and then sends the load command.
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.ss",
      callback = function(event)
        local path = vim.fn.expand("<afile>")

        -- Send the load command to the REPL. Use schedule to ensure the
        -- REPL buffer/connection has time to initialize.
        vim.schedule(function()
          -- Surround the path in double quotes as expected by Scheme's load
          -- and send the exact form to the REPL.
          local cmd = '(load "' .. path .. '")'
          pcall(function()
            iron.send(nil, cmd)
          end)
        end)
      end,
      desc = "Reload Scheme file in iron.nvim REPL on save",
    })

    -- Ensure pressing <Esc> in the terminal REPL returns to Normal mode in Neovim
    -- instead of sending the Escape to the Chez Scheme process. This maps <Esc>
    -- in terminal-mode for any terminal buffer opened by iron.nvim (or other
    -- terminals) to enter Terminal-Normal mode.
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*",
      callback = function()
        -- Use a buffer-local mapping in terminal mode: <Esc> -> <C-\\><C-n>
        -- which is the canonical way to leave terminal-insert mode.
        vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
      end,
      desc = "Map <Esc> in terminal buffers to go to Normal mode",
    })
  end,
}
