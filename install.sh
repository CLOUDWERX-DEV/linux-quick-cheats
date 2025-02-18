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

# Create necessary directories
print_info "Creating directories..."
mkdir -p ~/bin ~/.cheatsheets

# Create the enhanced cheats script
print_info "Creating cheats script..."
cat > ~/bin/cheats << 'EOF'
#!/bin/bash

CHEATS_DEFAULT_FILE="$HOME/.cheatsheet.txt"
CHEATS_DIR="$HOME/.cheatsheets"
HIGHLIGHT_COLOR=${CHEATS_HIGHLIGHT_COLOR:-"1;33"}

# Debug mode
[[ -n "$CHEATS_DEBUG" ]] && set -x

help() {
    echo "Usage: cheats [OPTIONS] [SEARCH_TERM]"
    echo
    echo "Options:"
    echo "  -h, --help           Show this help message"
    echo "  -c, --categories     List all categories"
    echo "  -l, --list           List all available cheatsheets"
    echo "  -f FILE              Use specific cheatsheet file"
    echo "  -C NUM               Show NUM lines of context"
    echo "  --export             Export current cheatsheet"
    echo "  --import FILE        Import cheatsheet from FILE"
    echo "  -r, --regex PATTERN  Search using regex pattern"
    echo
    echo "Examples:"
    echo "  cheats docker        Search for docker commands"
    echo "  cheats -f git.txt    Show git-specific cheatsheet"
    echo "  cheats -C 2 nginx    Show nginx entries with 2 lines of context"
}

# Handle different commands
case "$1" in
    -h|--help)
        help
        exit 0
        ;;
    -c|--categories)
        grep "^# " "$CHEATS_DEFAULT_FILE"
        exit 0
        ;;
    -l|--list)
        ls -1 "$CHEATS_DIR"
        exit 0
        ;;
    -f)
        if [ -f "$CHEATS_DIR/$2" ]; then
            cat "$CHEATS_DIR/$2"
        else
            echo "Cheatsheet not found: $2"
            exit 1
        fi
        exit 0
        ;;
    --export)
        cp "$CHEATS_DEFAULT_FILE" "./cheatsheet_backup_$(date +%Y%m%d).txt"
        echo "Cheatsheet exported!"
        exit 0
        ;;
    --import)
        if [ -f "$2" ]; then
            cp "$2" "$CHEATS_DEFAULT_FILE"
            echo "Cheatsheet imported!"
        else
            echo "File not found: $2"
            exit 1
        fi
        exit 0
        ;;
    -r|--regex)
        if [ -n "$2" ]; then
            grep --color=always -E "$2" "$CHEATS_DEFAULT_FILE"
        else
            echo "Please provide a regex pattern"
            exit 1
        fi
        exit 0
        ;;
    -C)
        if [ -n "$3" ]; then
            grep --color=always -A "$2" -B "$2" "$3" "$CHEATS_DEFAULT_FILE"
        else
            echo "Please provide a search term"
            exit 1
        fi
        exit 0
        ;;
    "")
        cat "$CHEATS_DEFAULT_FILE"
        ;;
    *)
        grep -i --color=always "$1" "$CHEATS_DEFAULT_FILE"
        ;;
esac
EOF

# Make script executable
chmod +x ~/bin/cheats

# Create initial cheatsheet with some useful commands
print_info "Creating initial cheatsheet..."
cat > ~/.cheatsheet.txt << 'EOF'
# Git Commands
git add . && git commit -m "message"    # Stage and commit all changes
git push origin main                    # Push to main branch
git pull                               # Pull latest changes
git checkout -b branch-name            # Create and switch to new branch
git stash                             # Stash changes
git stash pop                         # Apply stashed changes

# Python/UV Commands
uv venv .venv                         # Create virtual environment
source .venv/bin/activate             # Activate virtual environment
pip install -r requirements.txt       # Install requirements
python -m pytest                      # Run tests
uvicorn main:app --reload            # Run FastAPI server

# Docker Commands
docker ps -a                          # List all containers
docker images                         # List all images
docker-compose up -d                  # Start services in background
docker system prune -af               # Clean all unused resources
docker logs container_name           # View container logs

# Linux Shell
ls -la                               # List all files with details
chmod +x filename                    # Make file executable
grep -r "text" .                    # Recursive search
find . -name "*.py"                 # Find Python files
tar -xvzf file.tar.gz              # Extract tar.gz file
df -h                              # Show disk usage
free -h                           # Show memory usage
EOF

# Create example category-specific cheatsheets
print_info "Creating category-specific cheatsheets..."
mkdir -p ~/.cheatsheets
cp ~/.cheatsheet.txt ~/.cheatsheets/default.txt

# Add to PATH if not already there
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    print_info "Adding ~/bin to PATH..."
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    
    # Add useful aliases
    echo 'alias cheat="cheats"' >> ~/.bashrc
    echo 'alias cht="cheats"' >> ~/.bashrc
    
    # Add color customization
    echo 'export CHEATS_HIGHLIGHT_COLOR="1;32"' >> ~/.bashrc
    
    source ~/.bashrc
fi

# Final success message
print_success "
Installation complete! 

Quick Start:
- Type 'cheats' to see your cheatsheet
- 'cheats search_term' to search
- 'cheats -h' for help

Your cheatsheet is located at: ~/.cheatsheet.txt
Edit this file to add your own commands!
"

# Check if installation was successful
if command -v cheats >/dev/null 2>&1; then
    print_success "✓ Installation successful!"
else
    print_error "× Something went wrong. Please check the error messages above."
    exit 1
fi
