# Plugins Overview

## Core Plugins

### Plugin Manager
- **lazy.nvim** - Modern plugin manager with lazy loading

### Theme & UI
- **nord.nvim** - Nord color scheme
- **lualine.nvim** - Fast and customizable statusline
- **nvim-notify** - Beautiful notification system
- **which-key.nvim** - Displays available keybindings

## Navigation & File Management

### File Explorers
- **oil.nvim** - Edit filesystem like a buffer
- **neo-tree.nvim** - Modern file explorer sidebar
- **yazi.nvim** - Integration with Yazi file manager

### Fuzzy Finding
- **telescope.nvim** - Highly extendable fuzzy finder
- **telescope-fzf-native.nvim** - FZF sorter for telescope
- **telescope-ui-select.nvim** - UI select with telescope

### Quick Navigation
- **harpoon** - Quick file navigation
- **flash.nvim** - Navigate with search labels
- **neoscroll.nvim** - Smooth scrolling

### Dashboard & Sessions
- **snacks.nvim** - Collection of small QoL plugins (dashboard, terminal, etc.)
- **persistence.nvim** - Session management

## Editor Enhancement

### Text Editing
- **nvim-surround** - Add/change/delete surrounding pairs
- **Comment.nvim** - Smart commenting
- **nvim-autopairs** - Auto close pairs
- **mini.nvim** - Collection of minimal plugins
  - mini.ai - Better text objects
  - mini.surround - Surround operations
  - mini.pairs - Auto pairs
  - mini.move - Move lines/selections

### Visual Enhancements
- **indent-blankline.nvim** - Show indent guides
- **nvim-colorizer.lua** - Color highlighter
- **todo-comments.nvim** - Highlight and search TODO comments
- **render-markdown.nvim** - Enhanced markdown rendering
- **image.nvim** - Image preview support

## Language Support

### LSP & Completion
- **nvim-lspconfig** - QuickStart configs for LSP
- **mason.nvim** - Portable package manager for LSP servers
- **mason-lspconfig.nvim** - Bridge between mason and lspconfig
- **nvim-cmp** - Completion engine
- **cmp-nvim-lsp** - LSP source for nvim-cmp
- **cmp-buffer** - Buffer source for nvim-cmp
- **cmp-path** - Path source for nvim-cmp
- **cmp-cmdline** - Command line source for nvim-cmp
- **LuaSnip** - Snippet engine
- **cmp_luasnip** - Snippet source for nvim-cmp
- **friendly-snippets** - Preconfigured snippets

### Syntax & Treesitter
- **nvim-treesitter** - Treesitter configurations
- **nvim-treesitter-textobjects** - Syntax aware text objects
- **nvim-treesitter-context** - Show code context
- **nvim-ts-context-commentstring** - Context aware commenting

### Formatting & Linting
- **none-ls.nvim** - Use external tools for formatting/linting
- **SchemaStore.nvim** - JSON/YAML schemas

## Git Integration
- **gitsigns.nvim** - Git decorations and utilities
- **vim-fugitive** - Git commands
- **vim-rhubarb** - GitHub integration
- **diffview.nvim** - Single tabpage for git diffs

## Testing & Debugging
- **neotest** - Testing framework
- **nvim-dap** - Debug Adapter Protocol client
- **nvim-dap-ui** - UI for nvim-dap
- **nvim-dap-virtual-text** - Virtual text for debugging
- **mason-nvim-dap.nvim** - DAP integration with mason

## Productivity
- **trouble.nvim** - Pretty diagnostics list
- **vim-tmux-navigator** - Seamless tmux/vim navigation
- **zen-mode.nvim** - Distraction-free coding
- **twilight.nvim** - Dim inactive code

## Performance
- **vim-startuptime** - Measure startup time
- **profile.nvim** - Profiling tools

## Languages Configured

### Web Development
- TypeScript/JavaScript (ts_ls)
- HTML (html)
- CSS (cssls)
- Tailwind CSS (tailwindcss)
- ESLint (eslint)
- Emmet (emmet_ls)

### Data & Config
- JSON (jsonls)
- YAML (yamlls)
- GraphQL (graphql)
- Prisma (prismals)

### DevOps
- Docker (dockerls)
- Docker Compose (docker_compose_language_service)

### Other
- Lua (lua_ls)
- SQL (sqls)
- Markdown (marksman - via Mason)