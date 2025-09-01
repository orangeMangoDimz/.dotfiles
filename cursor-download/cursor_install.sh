#!/bin/bash

# Script: cursor_install.sh
# Purpose: Automate Cursor IDE download and installation
# Usage: ./cursor_install.sh <download_url> <cursor_name>
# Author: Generated from plan.md

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables
DOWNLOAD_URL=""
CURSOR_NAME=""
TEMP_DIR=""
DOWNLOADED_FILE=""

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check dependencies
check_dependencies() {
    print_info "Checking dependencies..."
    
    local missing_deps=()
    
    # Check for required commands
    for cmd in wget curl pgrep sudo; do
        if ! command -v "$cmd" &> /dev/null; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        print_info "Please install missing dependencies and try again"
        exit 1
    fi
    
    print_success "All dependencies found"
}

# Function to validate arguments
validate_arguments() {
    print_info "Validating arguments..."
    
    if [ $# -ne 2 ]; then
        print_error "Invalid number of arguments"
        echo "Usage: $0 <download_url> <cursor_name>"
        echo "Example: $0 https://example.com/cursor.AppImage cursor-latest"
        exit 1
    fi
    
    DOWNLOAD_URL="$1"
    CURSOR_NAME="$2"
    
    # Validate URL format
    if [[ ! "$DOWNLOAD_URL" =~ ^https?:// ]]; then
        print_error "Invalid URL format. URL must start with http:// or https://"
        exit 1
    fi
    
    # Validate filename (no spaces, special chars)
    if [[ ! "$CURSOR_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        print_error "Invalid cursor name. Use only letters, numbers, hyphens, and underscores"
        exit 1
    fi
    
    print_success "Arguments validated successfully"
    print_info "Download URL: $DOWNLOAD_URL"
    print_info "Cursor name: $CURSOR_NAME"
}

# Function to check if Cursor is running
check_cursor_running() {
    print_info "Checking if Cursor is running..."
    
    # Look for Cursor AppImage processes specifically, excluding this script
    local cursor_pids=$(pgrep -f "\.AppImage" | xargs -I {} ps -p {} -o pid,cmd --no-headers 2>/dev/null | grep -i cursor | grep -v cursor_install.sh | awk '{print $1}' || true)
    
    # Also check for common Cursor process names
    local cursor_pids2=$(pgrep -x "cursor" 2>/dev/null || true)
    local cursor_pids3=$(pgrep -f "/usr/local/bin/cursor" 2>/dev/null || true)
    
    # Combine all found PIDs
    local all_pids="$cursor_pids $cursor_pids2 $cursor_pids3"
    all_pids=$(echo "$all_pids" | tr ' ' '\n' | sort -u | tr '\n' ' ' | sed 's/[[:space:]]*$//')
    
    if [ -n "$all_pids" ] && [ "$all_pids" != " " ]; then
        print_warning "Found running Cursor processes (PIDs: $all_pids)"
        return 0
    else
        print_info "No running Cursor processes found"
        return 1
    fi
}

# Function to stop Cursor
stop_cursor() {
    print_info "Stopping Cursor processes..."
    
    # Get specific Cursor PIDs
    local cursor_pids=$(pgrep -f "\.AppImage" | xargs -I {} ps -p {} -o pid,cmd --no-headers 2>/dev/null | grep -i cursor | grep -v cursor_install.sh | awk '{print $1}' || true)
    local cursor_pids2=$(pgrep -x "cursor" 2>/dev/null || true)
    local cursor_pids3=$(pgrep -f "/usr/local/bin/cursor" 2>/dev/null || true)
    
    # Combine all found PIDs
    local all_pids="$cursor_pids $cursor_pids2 $cursor_pids3"
    all_pids=$(echo "$all_pids" | tr ' ' '\n' | sort -u | grep -v '^$' | tr '\n' ' ' | sed 's/[[:space:]]*$//')
    
    if [ -n "$all_pids" ] && [ "$all_pids" != " " ]; then
        # Try graceful shutdown first
        print_info "Sending TERM signal to PIDs: $all_pids"
        for pid in $all_pids; do
            kill -TERM "$pid" 2>/dev/null || true
        done
        sleep 2
        
        # Force kill if still running
        if check_cursor_running; then
            print_warning "Forcing Cursor shutdown..."
            for pid in $all_pids; do
                kill -KILL "$pid" 2>/dev/null || true
            done
            sleep 1
        fi
    fi
    
    if check_cursor_running; then
        print_error "Failed to stop Cursor processes"
        exit 1
    fi
    
    print_success "Cursor processes stopped"
}

# Function to check sudo permissions
check_sudo_permissions() {
    print_info "Checking sudo permissions..."
    
    if ! sudo -n true 2>/dev/null; then
        print_info "Requesting sudo permissions..."
        if ! sudo -v; then
            print_error "Sudo access required for installation"
            exit 1
        fi
    fi
    
    print_success "Sudo permissions verified"
}

# Function to create temporary directory
create_temp_dir() {
    TEMP_DIR=$(mktemp -d)
    print_info "Creating temporary directory for download..."
    print_info "Temporary directory created at: $TEMP_DIR"
}

# Function to download Cursor
download_cursor() {
    print_info "Starting Cursor download process..."
    print_info "Download URL: $DOWNLOAD_URL"
    print_info "Changing to temporary directory: $TEMP_DIR"
    
    cd "$TEMP_DIR"
    DOWNLOADED_FILE="$TEMP_DIR/cursor.AppImage"
    print_info "Target download file: $DOWNLOADED_FILE"
    
    # Try wget first, fallback to curl
    if command -v wget &> /dev/null; then
        print_info "Using wget for download..."
        if ! wget -O "$DOWNLOADED_FILE" "$DOWNLOAD_URL"; then
            print_error "Download failed with wget"
            exit 1
        fi
    elif command -v curl &> /dev/null; then
        print_info "Using curl for download..."
        if ! curl -L -o "$DOWNLOADED_FILE" "$DOWNLOAD_URL"; then
            print_error "Download failed with curl"
            exit 1
        fi
    else
        print_error "Neither wget nor curl available"
        exit 1
    fi
    
    # Verify download
    if [ ! -f "$DOWNLOADED_FILE" ] || [ ! -s "$DOWNLOADED_FILE" ]; then
        print_error "Download verification failed"
        exit 1
    fi
    
    print_success "Download completed successfully"
    print_info "Downloaded file size: $(du -h "$DOWNLOADED_FILE" | cut -f1)"
}

# Function to install Cursor
install_cursor() {
    print_info "Starting Cursor installation process..."
    print_info "Setting executable permissions on: $DOWNLOADED_FILE"
    
    # Make executable
    chmod +x "$DOWNLOADED_FILE"
    print_success "Made AppImage executable"
    
    # Create target path
    local target_path="/usr/local/bin/$CURSOR_NAME"
    print_info "Target installation path: $target_path"
    
    # Backup existing installation if it exists
    if [ -f "$target_path" ]; then
        local backup_path="${target_path}.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Existing installation found at: $target_path"
        print_info "Creating backup at: $backup_path"
        sudo mv "$target_path" "$backup_path"
        print_success "Backup created at: $backup_path"
    fi
    
    # Move to system path
    print_info "Moving AppImage from $DOWNLOADED_FILE to $target_path"
    if ! sudo mv "$DOWNLOADED_FILE" "$target_path"; then
        print_error "Failed to move file to $target_path"
        exit 1
    fi
    print_success "AppImage moved to system path: $target_path"
    
    # Verify installation
    if [ ! -f "$target_path" ]; then
        print_error "Installation verification failed"
        exit 1
    fi
    
    print_success "Cursor installed to $target_path"
}

# Function to create desktop file
create_desktop_file() {
    print_info "Starting desktop integration setup..."
    
    local desktop_file="/usr/share/applications/cursor.desktop"
    print_info "Desktop file path: $desktop_file"
    
    # Create desktop file content
    local desktop_content="[Desktop Entry]
Name=Cursor
Exec=/usr/local/bin/$CURSOR_NAME --no-sandbox
Icon=/usr/local/bin/cursor.png
Type=Application
Categories=Development;"
    print_info "Desktop file will execute: /usr/local/bin/$CURSOR_NAME --no-sandbox"
    print_info "Application category: Development"
    
    # Backup existing desktop file if it exists
    if [ -f "$desktop_file" ]; then
        local desktop_backup="${desktop_file}.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Existing desktop file found at: $desktop_file"
        print_info "Creating desktop file backup at: $desktop_backup"
        sudo cp "$desktop_file" "$desktop_backup"
        print_success "Desktop file backup created at: $desktop_backup"
    fi
    
    # Write desktop file
    print_info "Writing desktop file content to: $desktop_file"
    if ! echo "$desktop_content" | sudo tee "$desktop_file" > /dev/null; then
        print_error "Failed to create desktop file"
        exit 1
    fi
    
    # Set proper permissions
    print_info "Setting permissions (644) on desktop file"
    sudo chmod 644 "$desktop_file"
    
    print_success "Desktop file created at $desktop_file"
    
    # Update desktop database if available
    if command -v update-desktop-database &> /dev/null; then
        print_info "Updating desktop database..."
        sudo update-desktop-database /usr/share/applications/ 2>/dev/null || true
        print_success "Desktop database updated"
    fi
}

# Function to update .zshrc file
update_zshrc() {
    print_info "Starting .zshrc file update process..."
    
    local zshrc_file="$HOME/.zshrc"
    print_info "Target .zshrc file: $zshrc_file"
    
    # Check if .zshrc exists
    if [ ! -f "$zshrc_file" ]; then
        print_warning ".zshrc file not found at $zshrc_file"
        print_info "Skipping .zshrc update"
        return 0
    fi
    
    # Create backup
    local backup_file="${zshrc_file}.backup.$(date +%Y%m%d_%H%M%S)"
    print_info "Creating .zshrc backup at: $backup_file"
    cp "$zshrc_file" "$backup_file"
    print_success "Created .zshrc backup at: $backup_file"
    
    # New function content
    local new_function="function cursor {
        /usr/local/bin/$CURSOR_NAME --no-sandbox \$@
}"
    print_info "New cursor function will execute: /usr/local/bin/$CURSOR_NAME --no-sandbox"
    
    # Check if cursor function already exists
    if grep -q "^function cursor" "$zshrc_file" || grep -q "^cursor()" "$zshrc_file"; then
        print_info "Found existing cursor function, updating..."
        
        # Remove existing function (handle both function styles)
        # Create temporary file without the cursor function
        awk '
        /^function cursor/ {
            in_function = 1
            next
        }
        /^cursor\(\)/ {
            in_function = 1
            next
        }
        /^}/ && in_function {
            in_function = 0
            next
        }
        !in_function { print }
        ' "$zshrc_file" > "${zshrc_file}.tmp"
        
        # Add new function
        print_info "Adding updated cursor function to temporary file"
        echo "" >> "${zshrc_file}.tmp"
        echo "$new_function" >> "${zshrc_file}.tmp"
        
        # Replace original file
        print_info "Replacing original .zshrc with updated version"
        mv "${zshrc_file}.tmp" "$zshrc_file"
        print_success "Updated existing cursor function in .zshrc"
    else
        print_info "No existing cursor function found, adding new one..."
        
        # Add new function to end of file
        print_info "Appending new cursor function to end of .zshrc file"
        echo "" >> "$zshrc_file"
        echo "# Cursor function added by cursor_install.sh" >> "$zshrc_file"
        echo "$new_function" >> "$zshrc_file"
        print_success "Added new cursor function to .zshrc"
    fi
    
    print_info "You may need to restart your terminal or run 'source ~/.zshrc' to use the updated function"
}

# Function to launch Cursor
launch_cursor() {
    print_info "Starting Cursor application..."
    print_info "Executing: /usr/local/bin/$CURSOR_NAME --no-sandbox"
    print_info "Launching in background mode (detached from terminal)"
    
    # Launch in background and detach from terminal
    nohup "/usr/local/bin/$CURSOR_NAME" --no-sandbox > /dev/null 2>&1 &
    
    # Give it a moment to start
    sleep 3
    
    # Check if the specific cursor process is running
    if pgrep -f "/usr/local/bin/$CURSOR_NAME" > /dev/null; then
        print_success "Cursor launched successfully"
    else
        print_warning "Cursor may not have started properly"
        print_info "You can manually launch it from the applications menu or run: /usr/local/bin/$CURSOR_NAME"
    fi
}

# Function to cleanup temporary files
cleanup() {
    if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
        print_info "Cleaning up temporary files and directories..."
        print_info "Removing temporary directory: $TEMP_DIR"
        rm -rf "$TEMP_DIR"
        print_success "Temporary files cleanup completed"
    fi
}

# Trap to ensure cleanup on exit
trap cleanup EXIT

# Main function
main() {
    print_info "Starting Cursor installation script..."
    echo "=================================="
    
    # Validate input
    validate_arguments "$@"
    
    # Check dependencies
    check_dependencies
    
    # Check and stop Cursor if running
    if check_cursor_running; then
        stop_cursor
    fi
    
    # Check sudo permissions
    check_sudo_permissions
    
    # Create temporary directory
    create_temp_dir
    
    # Download Cursor
    download_cursor
    
    # Install Cursor
    install_cursor
    
    # Create desktop integration
    create_desktop_file
    
    # Update .zshrc file
    update_zshrc
    
    # Launch Cursor
    launch_cursor
    
    echo "=================================="
    print_success "Cursor installation completed successfully!"
    print_info "You can now find Cursor in your applications menu or run: /usr/local/bin/$CURSOR_NAME"
}

# Run main function with all arguments
main "$@" 