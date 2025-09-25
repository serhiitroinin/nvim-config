# Neovim Configuration

A modern, feature-rich Neovim configuration focused on productivity and developer experience.

![Neovim](https://img.shields.io/badge/Neovim-0.9.0+-green.svg)
![Lua](https://img.shields.io/badge/Lua-5.1-blue.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## Features

✨ **Modern Plugin Management** - Fast startup with lazy.nvim
🎨 **Beautiful UI** - Nord theme with custom dashboard
🔍 **Powerful Search** - Telescope fuzzy finder with live grep
📝 **Smart Editing** - LSP, auto-completion, and snippets
🚀 **TypeScript Ready** - Full TS/JS support with path aliases
📁 **Multiple File Explorers** - Oil, Neo-tree, and Yazi integration
🔧 **Git Integration** - Fugitive, Gitsigns, and inline blame
🧪 **Testing Support** - Run and debug tests from the editor
⚡ **Performance Optimized** - Lazy loading and smart caching

## Screenshot

<details>
<summary>Dashboard</summary>

The dashboard features a two-pane layout with system info, recent files, projects, and git status.

</details>

## Quick Start

### Prerequisites

- Neovim >= 0.9.0
- Git
- Node.js >= 18
- [Ripgrep](https://github.com/BurntSushi/ripgrep)
- A [Nerd Font](https://www.nerdfonts.com/)

### Installation

1. **Backup existing configuration** (if any):
```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. **Clone this repository**:
```bash
git clone https://github.com/serhiitroinin/nvim-config.git ~/.config/nvim
```

3. **Launch Neovim**:
```bash
nvim
```

The configuration will automatically install all plugins on first launch.

## Key Mappings

The leader key is `<Space>`.

### Most Used

| Key | Description |
|-----|------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | Find buffers |
| `<leader>fe` | File explorer |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>gg` | Git status |
| `<leader>;` | Dashboard |

See [full keymaps documentation](docs/keymaps.md) for complete list.

## Plugins

### Core Categories

- **Plugin Manager**: lazy.nvim
- **Fuzzy Finder**: Telescope + FZF
- **File Explorer**: Oil, Neo-tree, Yazi
- **LSP**: Native LSP with Mason
- **Completion**: nvim-cmp with multiple sources
- **Git**: Fugitive, Gitsigns, Diffview
- **UI**: Lualine, Which-key, nvim-notify
- **Theme**: Nord

See [full plugins list](docs/plugins.md) for details.

## Language Support

### Pre-configured LSPs

- **Web**: TypeScript, JavaScript, HTML, CSS, Tailwind
- **Config**: JSON, YAML, TOML
- **Backend**: GraphQL, Prisma
- **DevOps**: Docker, Docker Compose
- **Scripting**: Lua, Bash
- **Database**: SQL

Additional language servers can be installed via `:Mason`.

## Customization

### Adding Plugins

Create a new file in `lua/plugins/[category]/` with:

```lua
return {
  "plugin-author/plugin-name",
  config = function()
    require("plugin-name").setup({
      -- your config
    })
  end,
}
```

### Modifying Settings

- **Vim options**: Edit `lua/vim-options.lua`
- **Keymaps**: Edit `lua/keymaps.lua`
- **LSP servers**: Edit `lua/plugins/lsp/lsp-config.lua`

## Project Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── vim-options.lua     # Core settings
│   ├── keymaps.lua         # Key mappings
│   └── plugins/            # Plugin configurations
│       ├── core/           # Essential plugins
│       ├── lsp/            # Language servers
│       ├── navigation/     # File/project navigation
│       └── ...
├── after/plugin/           # Post-plugin configs
└── docs/                   # Documentation
```

## Documentation

- [Keymaps Reference](docs/keymaps.md) - Complete keyboard shortcuts
- [Plugins Overview](docs/plugins.md) - All installed plugins
- [Configuration Guide](docs/configuration.md) - Setup and customization

## Troubleshooting

### Health Check
```vim
:checkhealth
```

### Update Plugins
```vim
:Lazy update
```

### View Plugin Status
```vim
:Lazy
```

### LSP Information
```vim
:LspInfo
:Mason
```

## Performance

- Startup time: ~100-150ms
- Lazy-loaded plugins for optimal performance
- Smart caching and deduplication
- Minimal blocking operations

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT License - feel free to use this configuration as a starting point for your own.

## Acknowledgments

This configuration is built upon the excellent work of the Neovim community and plugin authors.