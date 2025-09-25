# Configuration Guide

## Directory Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin version lock file
├── lua/
│   ├── vim-options.lua     # Core Vim options
│   ├── keymaps.lua         # Keymap definitions
│   ├── theme-utils.lua     # Theme utilities
│   ├── diagnostic-dedupe.lua # Diagnostic deduplication
│   ├── lsp-dedupe.lua      # LSP definition deduplication
│   └── plugins/
│       ├── core/           # Core functionality plugins
│       ├── navigation/     # File navigation & search
│       ├── editor/         # Text editing enhancements
│       ├── lsp/            # Language server configs
│       ├── git/            # Git integration
│       ├── testing/        # Test runners
│       ├── productivity/   # Workflow improvements
│       └── extras/         # Additional features
├── after/
│   └── plugin/
│       └── keymaps.lua     # Keymaps loaded after plugins
└── docs/                   # Documentation
```

## Key Features

### TypeScript Development
- Full TypeScript/JavaScript LSP support with `ts_ls`
- Auto-import on completion
- Organize imports on save
- Path alias resolution for monorepos
- ESLint integration with auto-fix on save
- Prettier formatting

### Multi-Pane Dashboard
- System information display
- Recent files and projects
- Git status overview
- TODO/FIXME comment scanner
- Quick action shortcuts

### Smart Navigation
- Telescope fuzzy finder for files, text, and symbols
- Harpoon for quick file switching
- Multiple file explorer options (Oil, Neo-tree, Yazi)
- Flash for quick cursor movement

### Git Integration
- Inline git blame
- Hunk preview and staging
- Git history browsing
- Conflict resolution helpers

### Testing Support
- Neotest framework integration
- Run tests from editor
- Debug test execution
- Test output viewing

## Customization

### Adding Plugins
Create a new file in `lua/plugins/[category]/[plugin-name].lua`:

```lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
}
```

### Modifying Keymaps
Edit `lua/keymaps.lua` for basic mappings or `after/plugin/keymaps.lua` for plugin-specific mappings.

### Changing Theme
Modify `lua/plugins/core/nord.lua` or replace with your preferred colorscheme.

### LSP Configuration
Add or modify language servers in `lua/plugins/lsp/lsp-config.lua`.

## Performance Optimizations

- Lazy loading for most plugins
- Deferred loading for UI elements
- Diagnostic and LSP deduplication
- Optimized Treesitter queries
- Fast startup with lazy.nvim

## Troubleshooting

### Check Plugin Status
```vim
:Lazy
```

### View LSP Information
```vim
:LspInfo
```

### Check Health
```vim
:checkhealth
```

### View Keymaps
```vim
:Telescope keymaps
" or
<leader>?
```

### Clear Notifications
```vim
<leader>nc
```

## Requirements

- Neovim >= 0.9.0
- Git
- Node.js (for many LSP servers)
- Ripgrep (`rg`) for searching
- FZF for fuzzy finding
- A Nerd Font for icons

## Optional Dependencies

- Glow (markdown preview)
- Yazi (file manager)
- Python3 (for some plugins)
- Make/GCC (for native extensions)