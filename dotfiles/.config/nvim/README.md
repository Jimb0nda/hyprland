# Neovim Configuration

A modern, feature-rich Neovim setup with lazy.nvim, LSP support, Copilot integration, and comprehensive keybindings.

## Quick Start

### Initial Setup
1. Clone/sync this config to `~/.config/nvim/`
2. Open nvim: `nvim`
3. lazy.nvim will auto-install on first run
4. Set up Copilot (optional):
   ```
   :Copilot setup
   ```
   Follow prompts to authenticate with GitHub

### Requirements
- Neovim >= 0.9
- Git (for plugin management)
- For Copilot: GitHub account
- For LSP: Language servers (managed by Mason)

## Plugins

| Plugin | Purpose |
|--------|---------|
| **lazy.nvim** | Plugin manager |
| **nvim-treesitter** | Syntax highlighting & code structure |
| **nvim-lspconfig** | LSP client configuration |
| **mason.nvim** | Language server package manager |
| **nvim-cmp** | Completion engine |
| **LuaSnip** | Snippet engine |
| **fzf-lua** | Fuzzy finder |
| **neo-tree.nvim** | File tree explorer |
| **none-ls.nvim** | Code formatting & linting |
| **copilot.vim** | GitHub Copilot autocomplete |
| **CopilotChat.nvim** | Copilot chat interface |
| **nvim-dap** | Debug adapter protocol |
| **snacks.nvim** | Dashboard, git, scratch buffers |
| **catppuccin** | Catppuccin Macchiato theme |

## Complete Keybind Reference

### Navigation & Panes
| Keybind | Mode | Action |
|---------|------|--------|
| `Alt + Left` | Normal | Move to left window pane |
| `Alt + Right` | Normal | Move to right window pane |
| `Alt + Up` | Normal | Move to upper window pane |
| `Alt + Down` | Normal | Move to down window pane |

### File Explorer
| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl + n` | Normal | Toggle Neo-tree file explorer (left sidebar) |

### Search & Find
| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl + f` | Normal | Find files in project (fzf) |
| `Ctrl + ,` | Normal | Live grep / search text in project |

### Clipboard
| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl + c` | Normal/Visual | Copy to system clipboard |
| `Ctrl + x` | Normal/Visual | Cut to system clipboard |

### LSP (Language Server Protocol)
| Keybind | Mode | Action |
|---------|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Find references |
| `K` | Normal | Hover documentation |
| `<leader> + rn` | Normal | Rename symbol |
| `<leader> + ca` | Normal | Code actions |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |

### Completion Menu
*(Appears while typing in insert mode)*

| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl + Space` | Insert | Trigger completion menu |
| `Ctrl + b` | Insert | Scroll documentation up |
| `Ctrl + f` | Insert | Scroll documentation down |
| `Ctrl + e` | Insert | Abort/close completion |
| `Enter` | Insert | Confirm selection |

### Code Formatting
| Keybind | Mode | Action |
|---------|------|--------|
| `<leader> + f` | Normal | Format entire buffer |

### Debugging (DAP)
| Keybind | Mode | Action |
|---------|------|--------|
| `F5` | Normal | Continue execution |
| `F10` | Normal | Step over |
| `F11` | Normal | Step into |
| `F12` | Normal | Step out |
| `<leader> + b` | Normal | Toggle breakpoint |

### Snacks (Utilities)
| Keybind | Mode | Action |
|---------|------|--------|
| `<leader> + sf` | Normal | Toggle scratch buffer |
| `<leader> + S` | Normal | Select scratch buffer |
| `<leader> + gl` | Normal | Lazygit log |
| `<leader> + lg` | Normal | Open Lazygit |
| `<leader> + <leader>` | Normal | Recent files picker |
| `<leader> + fb` | Normal | Buffers picker |

### Copilot Chat ✨
| Keybind | Mode | Action |
|---------|------|--------|
| `<leader> + cpt` | Normal | Toggle Copilot Chat window |
| `<leader> + cpe` | Normal/Visual | Explain code |
| `<leader> + cpf` | Normal/Visual | Fix code |
| `<leader> + cpd` | Normal/Visual | Add documentation |
| `<leader> + cpr` | Normal/Visual | Code review |
| `<leader> + cpo` | Normal/Visual | Optimize code |
| `<leader> + cpx` | Normal/Visual | Generate tests |
| `<leader> + cph` | Normal/Visual | Refactor code |

**Note:** `<leader>` = Spacebar

## Copilot Usage

### Autocomplete (Inline Suggestions)
Copilot suggests code completions as you type:
- Type code → suggestions appear automatically
- Press `Tab` to accept suggestion
- Press `Esc` to dismiss

### Chat Commands

**Explain code:**
1. Select code (highlight in visual mode)
2. Press `<leader>cpe`
3. Chat window opens with explanation

**Fix code:**
1. Select problematic code
2. Press `<leader>cpf`
3. Copilot suggests fixes in chat window

**Add documentation:**
1. Select function or code block
2. Press `<leader>cpd`
3. Copilot generates docs/comments

**Other operations:**
- `<leader>cpr` — Code review
- `<leader>cpo` — Optimize code
- `<leader>cpx` — Generate tests
- `<leader>cph` — Refactor code

### Chat Window Examples

**Example 1: Explain a function**
```
1. Place cursor in function
2. Select it (Shift+V + arrow keys)
3. Press <leader>cpe
4. Chat opens with explanation
```

**Example 2: Fix a bug**
```
1. Select the buggy code
2. Press <leader>cpf
3. Copilot suggests fixes
4. Review in chat window
5. Press Ctrl+y to apply
```

**Example 3: Generate tests**
```
1. Select function to test
2. Press <leader>cpx
3. Copilot generates test code
4. Copy/apply as needed
```

**Example 4: Ask a question**
```
1. Press <leader>cpt (open chat)
2. Type: "How do I use async/await in Lua?"
3. Press Enter
4. Read response
5. Ask follow-up questions
```

### Chat Window Controls
| Keybind | Action |
|---------|--------|
| `Tab` | Accept suggestion |
| `Enter` | Submit question/response |
| `q` | Close chat window |
| `gd` | Show diff of changes |
| `Ctrl+y` | Apply diff |
| `gy` | Yank/copy diff |

### Chat Window Examples

**Example 1: Explain a function**
```
1. Place cursor in function
2. Select it (Shift+V + arrow keys)
3. Press <leader>cce
4. Chat opens with explanation
```

**Example 2: Fix a bug**
```
1. Select the buggy code
2. Press <leader>ccf
3. Copilot suggests fixes
4. Review in chat window
5. Press Ctrl+y to apply
```

**Example 3: Generate tests**
```
1. Select function to test
2. Press <leader>cct
3. Copilot generates test code
4. Copy/apply as needed
```

**Example 4: Ask a question**
```
1. Press <leader>ccc (open chat)
2. Type: "How do I use async/await in Lua?"
3. Press Enter
4. Read response
5. Ask follow-up questions
```

## Language Servers

Configured LSP servers (managed by Mason):
- `lua_ls` — Lua
- `clangd` — C/C++
- `pylsp` — Python
- `csharp_ls` — C#

Servers are auto-installed on first run.

## Code Formatters

Configured formatters (managed by Mason via none-ls):
- `stylua` — Lua
- `clang_format` — C/C++
- `biome` — JavaScript/TypeScript
- `black` — Python
- `isort` — Python imports

Format with: `<leader>f`

## Configuration Files

```
~/.config/nvim/
├── init.lua                 # Entry point, lazy.nvim setup
├── lua/
│   ├── vim-options.lua      # Editor options, navigation keybinds
│   └── plugins/
│       ├── catppuccin.lua   # Color scheme
│       ├── completions.lua  # Completion + Copilot
│       ├── copilotchat.lua  # Copilot Chat config
│       ├── debugging.lua    # DAP debugger
│       ├── lsp-config.lua   # Language servers
│       ├── neo-tree.lua     # File explorer
│       ├── none-ls.lua      # Formatters
│       ├── search.lua       # fzf-lua
│       ├── snacks.lua       # Utilities
│       └── treesitter.lua   # Syntax highlighting
└── lazy-lock.json           # Plugin versions
```

## Tmux Integration

If using tmux, ensure your tmux config has:
```tmux
set -g xterm-keys on
set -g extended-keys on
set -g allow-passthrough on
```

This ensures keybinds work correctly between nvim and tmux.

## Tips & Tricks

### Split Windows
- `:split` or `:vsplit` — Split horizontally/vertically
- `Alt+arrows` — Navigate between splits
- `:close` — Close current split

### Buffers
- `:e filename` — Open file in new buffer
- `:bn` — Next buffer
- `:bp` — Previous buffer
- `:bd` — Delete buffer
- `<leader>fb` — Buffer picker (Snacks)

### Search
- `<leader><leader>` — Recent files picker
- `<C-f>` — Find files
- `<C-,>` — Live grep (search project)

### Lazygit Integration
- `<leader>lg` — Open Lazygit
- `<leader>gl` — Lazygit log

### Scratch Buffer
- `<leader>sf` — Toggle scratch buffer
- `<leader>S` — Select scratch buffer

## Troubleshooting

### Plugins not loading
1. Close nvim
2. Delete `~/.local/share/nvim/lazy/` directory
3. Reopen nvim (plugins will reinstall)

### LSP not working
1. Verify language server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Restart LSP: `:LspRestart`

### Formatting not working
1. Check formatters are installed: `:Mason`
2. Verify none-ls is configured for your language
3. Check buffer has an attached formatter: `:NullLsInfo`

### Copilot not working
1. Authenticate: `:Copilot setup`
2. Check status: `:Copilot status`
3. Verify copilot.vim is installed and loaded: `:PlugStatus`

## Performance

Typical startup time: < 500ms

Check startup time:
```bash
nvim --startuptime /tmp/startup.log
# Then review: less /tmp/startup.log
```

## Additional Resources

- [Neovim Docs](https://neovim.io/doc/user/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Copilot for Neovim](https://github.com/github/copilot.vim)
- [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)
