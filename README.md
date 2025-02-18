<img src="logo.svg" alt="Linux Quick Cheats" width="400" height="400" title="Linux Quick Cheats">


# Quick-Cheats: Fast Terminal Command Reference

A lightning-fast terminal cheatsheet tool that provides instant access to your commands and snippets. Built with pure bash - no dependencies, no GUI, just speed.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Quick Start
```
# Show all commands
cheats

# Search for specific commands
cheats docker
cheats git

# Show categories
cheats -c

# Get help
cheats -h
```

## Features

- 🚀 Instant access - type `cheats` and go
- 🎨 Color-coded output for better readability
- 🔍 Powerful search with context support
- 📂 Multiple cheatsheet support
- 💾 Import/Export functionality
- ⚡ Zero dependencies - pure bash
- 🛠 Pre-loaded with useful commands

## Installation

### Option 1: Automatic Installation
```
git clone https://github.com/CLOUDWERX-DEV/linux-quick-cheats.git
cd linux-quick-cheats
chmod +x install.sh
./install.sh
```

### Option 2: Manual Installation
```
# Create directories
mkdir -p ~/bin ~/.cheatsheets

# Download the script
curl -o ~/bin/cheats https://raw.githubusercontent.com/CLOUDWERX-DEV/linux-quick-cheats/main/cheats
chmod +x ~/bin/cheats

# Add to PATH
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Uninstallation

Quick-Cheats can be uninstalled either automatically using the provided script or manually.

### Automatic Uninstall
```
./uninstall.sh
```

### Manual Uninstall
```
# Remove the executable
rm ~/bin/cheats

# Remove cheatsheet files
rm ~/.cheatsheet.txt
rm -rf ~/.cheatsheets

# Remove from .bashrc (edit file and remove these lines):
# export PATH="$HOME/bin:$PATH"
# alias cheat="cheats"
# alias cht="cheats"
# export CHEATS_HIGHLIGHT_COLOR="1;32"

# Optional: Remove bin directory if empty
rmdir ~/bin 2>/dev/null

# Reload shell configuration
source ~/.bashrc
```

To verify uninstallation:
```
which cheats              # Should return nothing
ls ~/.cheatsheet.txt     # Should show "No such file"
echo $CHEATS_HIGHLIGHT_COLOR  # Should return nothing
```


## Command Reference

### Basic Commands
```
cheats                  # Show all commands
cheats docker          # Search for docker commands
cheats -h              # Show help
```

### Advanced Features
```
cheats -c              # List categories
cheats -l              # List available cheatsheets
cheats -f docker.txt   # Show specific cheatsheet
cheats -C 2 nginx      # Show matches with 2 lines of context
cheats -r "^git.*"     # Search using regex
cheats --export        # Export cheatsheet
cheats --import file   # Import cheatsheet
```

### Built-in Aliases
The installer automatically adds these aliases:
```
cheat    # Same as cheats
cht      # Short form
```

## Directory Structure
```
$HOME/
├── bin/
│   └── cheats             # Main executable
├── .cheatsheets/         # Category-specific sheets
│   ├── default.txt
│   └── docker.txt
└── .cheatsheet.txt      # Main cheatsheet
```

## Default Content
The installer includes these categories:
- Git Commands
- Python/UV Commands
- Docker Commands
- Linux Shell Commands

Example from default cheatsheet:
```
# Git Commands
git add . && git commit -m "message"    # Stage and commit all changes
git push origin main                    # Push to main branch

# Docker Commands
docker ps -a                          # List all containers
docker images                         # List all images
```

## Customization

### Adding Your Own Commands
Edit ~/.cheatsheet.txt:
```
# My Custom Commands
myalias="custom command"    # Description here
```

### Color Configuration
Already configured in ~/.bashrc:
```
export CHEATS_HIGHLIGHT_COLOR="1;32"  # Green highlights
```

## Troubleshooting

### Common Issues

1. Command not found
```
# Add to PATH manually
export PATH="$HOME/bin:$PATH"
```

2. No color output
```
# Check color setting
echo $CHEATS_HIGHLIGHT_COLOR
```

3. Permission denied
```
chmod +x ~/bin/cheats
```

### Debug Mode
```
CHEATS_DEBUG=1 cheats search_term
```

## Examples

### Basic Search
```
$ cheats git
git add . && commit -m "message"    # Stage and commit all changes
git push origin main               # Push to main branch
```

### Category View
```
$ cheats -c
# Git Commands
# Docker Commands
# Python Commands
# Linux Shell
```

### Context Search
```
$ cheats -C 1 docker
# Docker Section
docker ps -a                      # List all containers
docker images                     # List all images
# Next Section
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Test your changes
4. Submit a pull request

## Security Notes

- Don't store sensitive data in cheatsheets
- Review imported cheatsheets before using
- Keep backups of your custom content

## Performance

The tool is designed to be fast and lightweight:
- Pure bash implementation
- No external dependencies
- Instant response time
- Minimal resource usage

## Support

- GitHub Issues: [Report Bug](https://github.com/CLOUDWERX-DEV/linux-quick-cheats/issues)
- Author: [CLOUDWERX LAB](https://github.com/CLOUDWERX-DEV)
- Website: [http://cloudwerx.dev](http://cloudwerx.dev)

## License

MIT License - see LICENSE file for details.

---

Created with ❤️ by [CLOUDWERX LAB](http://cloudwerx.dev)
