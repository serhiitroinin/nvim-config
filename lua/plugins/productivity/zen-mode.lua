-- Writing mode setup inspired by https://trebaud.github.io/posts/neovim-for-writers/
-- Using goyo.vim + vim-pencil for distraction-free writing
--
-- Font size support:
-- - GUI (Neovide): Automatically increases guifont by 4pts
-- - Terminal: Use :GoyoFontSize <size> or terminal's zoom (Cmd/Ctrl +/-)
-- - WezTerm: Font size change via terminal zoom recommended

return {
  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
    config = function()
      -- Goyo dimensions
      vim.g.goyo_width = 100
      vim.g.goyo_height = "85%"

      -- Track lualine state and font size
      local lualine_active = false
      local original_guifont = vim.o.guifont

      -- Goyo Enter: Setup writing environment
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoEnter",
        callback = function()
          -- Increase font size for writing mode
          if vim.g.neovide or vim.fn.has("gui_running") == 1 then
            -- For GUI Neovim (Neovide, etc.)
            local current_font = vim.o.guifont
            if current_font and current_font ~= "" then
              original_guifont = current_font
              -- Try to parse font size and increase it
              local font_name, size = current_font:match("(.+):h(%d+)")
              if font_name and size then
                -- Use custom size if set, otherwise increase by 4
                local size_increase = vim.g.goyo_writing_font_size or (tonumber(size) + 4)
                vim.o.guifont = font_name .. ":h" .. size_increase
              end
            else
              -- Set default larger font if none is set
              local default_size = vim.g.goyo_writing_font_size or 18
              vim.o.guifont = "monospace:h" .. default_size
            end
          end
          -- Close all file explorers
          local ok, snacks = pcall(require, "snacks")
          if ok and snacks.explorer and snacks.explorer.close_all then
            snacks.explorer.close_all()
          end

          -- Hide lualine by setting laststatus to 0
          vim.opt.laststatus = 0

          -- Check if lualine was active
          local lualine_ok, lualine = pcall(require, "lualine")
          if lualine_ok then
            lualine_active = true
            -- Force lualine to refresh with new laststatus
            pcall(function() lualine.hide() end)
          end

          -- Hide all UI chrome
          vim.opt.showcmd = false
          vim.opt.showmode = false
          vim.opt.ruler = false
          vim.opt.number = false
          vim.opt.relativenumber = false
          vim.opt.signcolumn = "no"
          vim.opt.foldcolumn = "0"
          vim.opt.foldenable = false

          -- Enable soft wrapping for prose
          vim.opt.wrap = true
          vim.opt.linebreak = true
          vim.opt.breakindent = true

          -- For markdown files: enable spell check and pencil
          if vim.bo.filetype == "markdown" or vim.bo.filetype == "text" then
            vim.opt_local.spell = true
            vim.opt_local.spelllang = "en_us"
            vim.cmd("silent! SoftPencil")
          end
        end,
      })

      -- Goyo Leave: Restore normal environment
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoLeave",
        callback = function()
          -- Restore font size
          if vim.g.neovide or vim.fn.has("gui_running") == 1 then
            vim.o.guifont = original_guifont
          end

          -- Restore lualine
          vim.opt.laststatus = 3 -- Global statusline

          if lualine_active then
            local lualine_ok, lualine = pcall(require, "lualine")
            if lualine_ok then
              pcall(function() lualine.hide({ unhide = true }) end)
            end
          end

          -- Restore UI chrome
          vim.opt.showcmd = true
          vim.opt.showmode = true
          vim.opt.ruler = true
          vim.opt.number = true
          vim.opt.relativenumber = true
          vim.opt.signcolumn = "yes"
          vim.opt.foldenable = true

          -- Disable wrapping
          vim.opt.wrap = false
          vim.opt.linebreak = false

          -- Disable spell check
          vim.opt_local.spell = false

          -- Exit pencil mode
          vim.cmd("silent! NoPencil")

          -- Force a full redraw to fix any UI glitches
          vim.schedule(function()
            vim.cmd("mode")
          end)
        end,
      })

      -- User command to set writing mode font size
      vim.api.nvim_create_user_command("GoyoFontSize", function(opts)
        local size = tonumber(opts.args)
        if size then
          vim.g.goyo_writing_font_size = size
          vim.notify("Writing mode font size set to " .. size, vim.log.levels.INFO)
        else
          vim.notify("Please provide a valid font size", vim.log.levels.ERROR)
        end
      end, {
        nargs = 1,
        desc = "Set font size for writing mode",
      })
    end,
  },
  {
    "preservim/vim-pencil",
    lazy = true,
    config = function()
      -- Pencil configuration
      vim.g["pencil#wrapModeDefault"] = "soft" -- Use soft line wrapping
      vim.g["pencil#textwidth"] = 100
      vim.g["pencil#autoformat"] = 0 -- Don't auto-format
      vim.g["pencil#cursorwrap"] = 1 -- Allow cursor to wrap

      -- Auto-enable soft pencil for markdown/text files (when not in Goyo)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "text" },
        callback = function()
          -- Only auto-enable if not already in Goyo mode
          if vim.fn.exists("#goyo") == 0 then
            vim.cmd("SoftPencil")
          end
        end,
      })
    end,
  },
}
