# Keymaps Reference

## Leader Key
The leader key is set to `<Space>`.

## Navigation

### Window Navigation
- `<C-h>` - Navigate to left window
- `<C-j>` - Navigate to down window
- `<C-k>` - Navigate to up window
- `<C-l>` - Navigate to right window

### Jump Navigation
- `<C-o>` - Jump back in history
- `<C-i>` - Jump forward in history
- `gb` - Go back (alternative)
- `gf` - Go forward (alternative)

### Scroll Navigation
- `<C-d>` - Scroll down (centered)
- `<C-u>` - Scroll up (centered)
- `n` - Next search result (centered)
- `N` - Previous search result (centered)

## File Operations

### Find & Search (`<leader>f`)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search text)
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fs` - Search current word
- `<leader>fc` - Commands palette
- `<leader>fo` - Recent files
- `<leader>fz` - Fuzzy find in current buffer
- `<leader>fd` - Find diagnostics
- `<leader>fr` - Resume last search
- `<leader>fk` - Find keymaps
- `<leader>fm` - Find marks
- `<leader>fR` - Find registers
- `<leader>fp` - Find in project root
- `<leader>fP` - Grep in project root
- `<leader>f/` - Grep with input
- `<leader>fe` - File explorer (Snacks)
- `<leader>fE` - File explorer (project root)
- `<leader>fy` - Yazi file manager
- `<leader>fY` - Yazi (project root)

### File Explorer
- `<leader>e` - Open Oil file explorer
- `<leader>E` - Open Neo-tree
- `-` - Open parent directory (Oil)

## Code Actions & LSP

### Code Actions (`<leader>c`)
- `<leader>ca` - Code action
- `<leader>cf` - Quick fix
- `<leader>cr` - Rename symbol
- `<leader>ci` - Organize imports
- `<leader>cm` - Add missing imports
- `<leader>cu` - Remove unused imports
- `<leader>cs` - Symbols outline

### LSP Operations (`<leader>l`)
- `<leader>li` - LSP info
- `<leader>lr` - LSP restart / references
- `<leader>ll` - LSP log
- `<leader>ls` - Document symbols
- `<leader>lw` - Workspace symbols
- `<leader>ld` - LSP definitions

### Go To Navigation
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gt` - Go to type definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>K` - Hover (persistent)

## Git Operations (`<leader>g`)

### Git Commands
- `<leader>gst` - Git status (fugitive)
- `<leader>gh` - Git commit history
- `<leader>gH` - Buffer git history
- `<leader>gb` - Git branches
- `<leader>gs` - Git status / Stage hunk
- `<leader>gS` - Stage buffer
- `<leader>gu` - Undo stage hunk
- `<leader>gp` - Preview hunk
- `<leader>gr` - Reset hunk
- `<leader>gR` - Reset buffer
- `<leader>gd` - Diff this
- `<leader>gD` - Diff this ~
- `<leader>gtb` - Toggle line blame
- `<leader>gtd` - Toggle deleted

### Git Navigation
- `]h` - Next hunk
- `[h` - Previous hunk

## Diagnostics (`<leader>d`)
- `<leader>dd` - Document diagnostics
- `<leader>dw` - Workspace diagnostics
- `<leader>df` - Diagnostic float
- `<leader>dn` - Next diagnostic
- `<leader>dp` - Previous diagnostic
- `<leader>de` - Next error
- `<leader>dE` - Previous error
- `]d` - Next diagnostic
- `[d` - Previous diagnostic

## Testing (`<leader>t`)
- `<leader>tn` - Test nearest
- `<leader>tf` - Test file
- `<leader>ts` - Stop test
- `<leader>ta` - Attach to test
- `<leader>to` - Test output
- `<leader>tO` - Test output panel
- `<leader>tw` - Watch test file
- `<leader>tW` - Watch nearest test

## Harpoon (`<leader>h`)
- `<leader>ha` - Add to Harpoon
- `<leader>hm` - Harpoon menu
- `<leader>h1-4` - Jump to Harpoon file 1-4
- `<leader>hn` - Next Harpoon file
- `<leader>hp` - Previous Harpoon file
- `<leader>hk` - Show keymaps help

## Search & Replace
- `<leader>Rr` - Open replace panel (Spectre)
- `<leader>Rw` - Replace current word
- `<leader>Rf` - Replace in file
- `<leader>S` - Simple replace word under cursor

## Sessions & Projects (`<leader>p`)
- `<leader>ps` - Save session
- `<leader>pr` - Restore session
- `<leader>pl` - Restore last session
- `<leader>px` - Stop tracking session

## UI & Utilities

### Notifications (`<leader>n`)
- `<leader>nh` - Notification history
- `<leader>nc` - Clear notifications

### Terminal (`<leader>T`)
- `<leader>Tf` - Terminal (float)
- `<leader>Th` - Terminal (horizontal)
- `<leader>Tv` - Terminal (vertical)
- `<leader>Tn` - Node REPL
- `<leader>Tp` - Python REPL

### Trouble/Diagnostics (`<leader>x`)
- `<leader>xx` - Diagnostics (workspace)
- `<leader>xX` - Diagnostics (buffer)

## General Operations
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>Q` - Quit all
- `<leader>x` - Save and quit
- `<leader><space>` - Clear search highlight
- `<leader>;` - Open dashboard
- `<leader>?` - Show keymaps reference

## Visual Mode

### Text Manipulation
- `J` - Move lines down
- `K` - Move lines up
- `<leader>p` - Paste without yanking replaced text
- `<leader>y` - Copy to system clipboard
- `<leader>d` - Delete without yank

### Text Movement (with Alt)
- `<M-j>` - Move selection down
- `<M-k>` - Move selection up
- `<M-h>` - Move selection left
- `<M-l>` - Move selection right

## Comments
- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gcO` - Comment above
- `gco` - Comment below
- `gcA` - Comment at end of line
- `<leader>cc` - Toggle line comment
- `<leader>cb` - Toggle block comment

## Debug (DAP)
- `<F5>` - Start/Continue debugging
- `<F7>` - Debug UI toggle
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<leader>bb` - Toggle breakpoint
- `<leader>bc` - Conditional breakpoint
- `<leader>bl` - Log point
- `<leader>br` - Open REPL
- `<leader>bd` - Clear breakpoints

## Flash Navigation
- `s` - Flash jump (normal/visual)
- `S` - Flash treesitter

## Markdown
- `<leader>mp` - Preview markdown (glow)
- `<leader>mP` - Preview in terminal

## Special Keys
- `Q` - Disabled (no ex mode)
- `-` - Open parent directory in Oil