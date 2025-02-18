#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print with color
print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_info() {
    echo -e "${BLUE}$1${NC}"
}

print_error() {
    echo -e "${RED}$1${NC}"
}

# Confirm uninstallation
read -p "Are you sure you want to uninstall Quick-Cheats? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    print_info "Uninstallation cancelled."
    exit 1
fi

print_info "Starting uninstallation..."

# Remove executable
if [ -f ~/bin/cheats ]; then
    rm ~/bin/cheats
    print_success "✓ Removed cheats executable"
else
    print_info "× cheats executable not found"
fi

# Remove cheatsheet files
if [ -f ~/.cheatsheet.txt ]; then
    rm ~/.cheatsheet.txt
    print_success "✓ Removed main cheatsheet"
else
    print_info "× Main cheatsheet not found"
fi

if [ -d ~/.cheatsheets ]; then
    rm -rf ~/.cheatsheets
    print_success "✓ Removed cheatsheets directory"
else
    print_info "× Cheatsheets directory not found"
fi

# Backup .bashrc before modification
cp ~/.bashrc ~/.bashrc.bak
print_success "✓ Created backup of .bashrc at ~/.bashrc.bak"

# Remove PATH and aliases from .bashrc
sed -i '/export PATH="$HOME\/bin:$PATH"/d' ~/.bashrc
sed -i '/alias cheat="cheats"/d' ~/.bashrc
sed -i '/alias cht="cheats"/d' ~/.bashrc
sed -i '/export CHEATS_HIGHLIGHT_COLOR/d' ~/.bashrc
print_success "✓ Removed Quick-Cheats configurations from .bashrc"

# Try to remove bin directory if empty
rmdir ~/bin 2>/dev/null
if [ $? -eq 0 ]; then
    print_success "✓ Removed empty bin directory"
fi

print_success "
Uninstallation complete!

The following actions were performed:
- Removed cheats executable
- Removed cheatsheet files
- Removed Quick-Cheats configurations from .bashrc
- Created backup of original .bashrc at ~/.bashrc.bak

To complete the uninstallation, please:
1. Start a new terminal session, or
2. Run: source ~/.bashrc

Note: Your original cheatsheet content can be found in ~/.bashrc.bak
"

# Offer to reload shell configuration
read -p "Would you like to reload shell configuration now? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    source ~/.bashrc
    print_success "Shell configuration reloaded."
fi
