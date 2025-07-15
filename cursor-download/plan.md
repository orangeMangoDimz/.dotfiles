# Cursor Automation Download Script Plan

## Overview
Create a bash script that automates downloading, installing, and configuring Cursor IDE with proper desktop integration.

## Script Requirements

### Input Parameters
- **Arg 1**: Download URL for the Cursor AppImage
- **Arg 2**: Desired filename for the Cursor executable (without .AppImage extension)

### Script Flow

#### 1. Pre-execution Checks
- **Check if Cursor is running**: Use `pgrep` or `pidof` to detect running Cursor processes
- **Terminate Cursor if running**: Kill all Cursor processes gracefully
- **Validate arguments**: Ensure both URL and filename are provided
- **Check sudo permissions**: Verify user can execute sudo commands

#### 2. Download Phase
- **Download the AppImage**: Use `wget` or `curl` with the provided URL
- **Verify download**: Check if file was downloaded successfully
- **Validate file type**: Ensure it's actually an AppImage file

#### 3. Installation Phase
- **Make executable**: `chmod +x` on the downloaded AppImage
- **Move to system path**: `sudo mv` to `/usr/local/bin/{cursor_name}`
- **Verify installation**: Check if file exists in target location

#### 4. Desktop Integration
- **Navigate to applications directory**: `cd /usr/share/applications/`
- **Create/update desktop file**: Create or overwrite `cursor.desktop`
- **Desktop file content**:
  ```
  [Desktop Entry]
  Name=Cursor
  Exec=/usr/local/bin/{cursor_name} --no-sandbox
  Icon=/usr/local/bin/cursor.png
  Type=Application
  Categories=Development;
  ```
- **Set proper permissions**: Ensure desktop file has correct permissions

#### 5. Shell Integration
- **Update .zshrc file**: Update the cursor function to use the new executable path
- **Function content**:
  ```bash
  function cursor {
          /usr/local/bin/{cursor_name} --no-sandbox $@
  }
  ```
- **Backup existing .zshrc**: Create backup before modifying

#### 6. Post-installation
- **Update desktop database**: Run `update-desktop-database` if available
- **Launch Cursor**: Start the newly installed Cursor application

## Technical Implementation Details

### Error Handling
- Check return codes for all critical operations
- Provide meaningful error messages
- Clean up partial installations on failure
- Exit with appropriate error codes

### Safety Measures
- Backup existing Cursor installation if found
- Verify URLs before downloading
- Check available disk space
- Validate sudo access before making system changes

### File Operations
- Use temporary directory for downloads
- Clean up temporary files after installation
- Handle file permissions properly
- Verify file integrity where possible

## Script Structure

```bash
#!/bin/bash

# Script: cursor_install.sh
# Purpose: Automate Cursor IDE download and installation
# Usage: ./cursor_install.sh <download_url> <cursor_name>

# Functions:
# - check_dependencies()
# - check_cursor_running()
# - stop_cursor()
# - validate_arguments()
# - download_cursor()
# - install_cursor()
# - create_desktop_file()
# - update_zshrc()
# - launch_cursor()
# - cleanup()
# - main()
```

## Dependencies
- `wget` or `curl` for downloading
- `sudo` access for system file modifications
- `pgrep`/`pidof` for process detection
- Standard Unix utilities (`mv`, `chmod`, `cd`)

## Potential Issues & Solutions

### Permission Issues
- **Problem**: No sudo access
- **Solution**: Check sudo access early and exit gracefully

### Network Issues
- **Problem**: Download failure
- **Solution**: Retry mechanism with timeout

### File Conflicts
- **Problem**: Existing Cursor installation
- **Solution**: Backup and replace or prompt user

### Icon Missing
- **Problem**: cursor.png might not exist
- **Solution**: Download default icon or handle gracefully

## Testing Checklist
- [ ] Test with valid URL and filename
- [ ] Test with invalid arguments
- [ ] Test when Cursor is running
- [ ] Test when Cursor is not running
- [ ] Test with insufficient permissions
- [ ] Test with network issues
- [ ] Verify desktop integration works
- [ ] Verify application launches correctly

## Success Criteria
- Script completes without errors
- Cursor AppImage is properly installed in `/usr/local/bin/`
- Desktop file is created with correct content
- Cursor launches successfully from system menu
- No running processes interfere with installation
