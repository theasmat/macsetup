#!/bin/bash

# ╔══════════════════════════════════════════════════════════════╗
# ║                                                              ║
# ║        🚀 MAC DEVELOPER SETUP - V5.0 (Refined)               ║
# ║                                                              ║
# ║    A Professional, Interactive, and Comprehensive Setup      ║
# ║                                                              ║
# ║              Credit: Asmat (https://asmat.dev)               ║
# ╚══════════════════════════════════════════════════════════════╝

# --- CONFIGURATION & STYLING ---

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Emojis
CHECK="✅"
SKIP="⏭️"
INFO="ℹ️"
WARNING="⚠️"
ROCKET="🚀"
GEAR="⚙️"
COMPUTER="💻"
PEN="✍️"
FOLDER="📁"
ART="🎨"
KEY="🔑"
CODE="👨‍💻"
TOOLS="🔧"
ENV="🌳"

# --- HELPER FUNCTIONS ---

ask_yes_no() {
    while true; do
        printf "${YELLOW}$1${NC} ${CYAN}(y/n)${NC}: "
        read -r yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo -e "${RED}Please answer yes (y) or no (n).${NC}";;
        esac
    done
}

# Helper for printing centered lines in the main header
print_header_line() {
    local text="$1"
    local color="${2:-$WHITE}"
    local stripped_text=$(echo "$text" | sed 's/\x1B\[[0-9;]*[a-zA-Z]//g')
    local text_len=${#stripped_text}
    local width=62 # Inner width of the box
    local padding_total=$((width - text_len))
    local padding_left=$((padding_total / 2))
    local padding_right=$((padding_total - padding_left))
    printf "${CYAN}║%*s${color}%s${NC}%*s${CYAN}║${NC}\n" "$padding_left" "" "$text" "$padding_right" ""
}

# Prints the main, persistent header
print_main_header() {
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    print_header_line ""
    print_header_line "🚀 MAC DEVELOPER SETUP - V5.0 (Refined)"
    print_header_line ""
    print_header_line "A Professional, Interactive, and Comprehensive Setup" "${BLUE}"
    print_header_line ""
    print_header_line "Credit: Gemini & https://asmat.dev"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
}

# Prints the header for each new section, under the main header
print_section() {
    clear
    print_main_header
    local title="$1"
    local stripped_title=$(echo "$title" | sed 's/\x1B\[[0-9;]*[a-zA-Z]//g')
    local title_len=${#stripped_title}
    local width=62
    local padding_total=$((width - title_len))
    local padding_left=$((padding_total / 2))
    local padding_right=$((padding_total - padding_left))
    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
    printf "${CYAN}║%*s${WHITE}%s${NC}%*s${CYAN}║${NC}\n" "$padding_left" "" "$title" "$padding_right" ""
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_info() { echo -e "${YELLOW}${INFO} $1${NC}"; }
print_success() { echo -e "${GREEN}${CHECK} $1${NC}"; }
print_skip() { echo -e "${YELLOW}${SKIP} $1${NC}"; }
print_warning() { echo -e "${RED}${WARNING} $1${NC}"; }

show_progress() {
    local pid=$1
    local message=$2
    local spin='⠧⠏⠹⠼⠧⠏⠹⠼'
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) % 8 ))
        printf "\r${CYAN}${spin:$i:1}${NC} ${WHITE}%s${NC}" "$message"
        sleep .1
    done
    printf "\r"
}

execute() {
    local cmd=$1
    local message=$2
    local max_retries=${3:-1}
    local retry_count=0

    while [ $retry_count -lt $max_retries ]; do
        $cmd &> /dev/null &
        local pid=$!
        show_progress "$pid" "$message"
        wait "$pid"
        local exit_code=$?

        if [ $exit_code -eq 0 ]; then
            return 0
        else
            retry_count=$((retry_count + 1))
            if [ $retry_count -lt $max_retries ]; then
                print_warning "Command failed (attempt $retry_count/$max_retries). Retrying..."
                sleep 2
            fi
        fi
    done

    return $exit_code
}

# Enhanced error checking for downloads
download_with_retry() {
    local url=$1
    local output_path=$2
    local max_retries=${3:-3}
    local retry_count=0

    while [ $retry_count -lt $max_retries ]; do
        if curl -L --fail --connect-timeout 30 --max-time 300 -o "$output_path" "$url"; then
            if [ -f "$output_path" ] && [ -s "$output_path" ]; then
                return 0
            else
                print_warning "Downloaded file is empty or corrupted."
            fi
        fi

        retry_count=$((retry_count + 1))
        if [ $retry_count -lt $max_retries ]; then
            print_warning "Download failed (attempt $retry_count/$max_retries). Retrying in 3 seconds..."
            sleep 3
        else
            print_warning "Download failed after $max_retries attempts."
        fi
    done

    return 1
}

# Check if a command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Verify installation
verify_installation() {
    local app_name=$1
    local command_to_check=$2

    if command_exists "$command_to_check"; then
        local version=$($command_to_check --version 2>/dev/null | head -1)
        print_success "$app_name verified: $version"
        return 0
    else
        print_warning "$app_name installation could not be verified."
        return 1
    fi
}

# --- SCRIPT SECTIONS ---

check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_warning "This script is designed for macOS only."
        exit 1
    fi
}

show_welcome() {
    clear
    print_main_header
    echo ""
    print_info "A fully interactive and customizable setup script."
    print_info "You can skip entire sections or individual items."
    echo ""
    printf "${WHITE}Press ${GREEN}ENTER${NC} to begin..."
    read -r
}

system_prep() {
    print_section "🚀 STEP 1: SYSTEM PREPARATION"
    print_info "Requesting administrator privileges for setup..."
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    print_success "System prepared and privileges acquired."
}

configure_system_prefs() {
    print_section "${ART} STEP 2: MACOS SYSTEM PREFERENCES"
    if ! ask_yes_no "Configure macOS System Preferences?"; then
        print_skip "Skipping all macOS preference changes."
        return
    fi

    if ask_yes_no "Take screenshots as JPG instead of PNG?"; then
        defaults write com.apple.screencapture type jpg && print_success "Screenshots set to JPG."
    else print_skip "Skipping screenshot format change."; fi

    if ask_yes_no "Don't open previous files in Preview?"; then
        defaults write com.apple.Preview ApplePersistenceIgnoreState YES && print_success "Preview will not open old files."
    else print_skip "Skipping Preview setting."; fi

    if ask_yes_no "Show hidden ~/Library folder?"; then
        chflags nohidden ~/Library && print_success "Library folder is now visible."
    else print_skip "Skipping Library folder setting."; fi

    if ask_yes_no "Show all hidden files in Finder?"; then
        defaults write com.apple.finder AppleShowAllFiles YES && print_success "Finder will show hidden files."
    else print_skip "Skipping hidden files setting."; fi

    if ask_yes_no "Show Path Bar in Finder?"; then
        defaults write com.apple.finder ShowPathbar -bool true && print_success "Finder Path Bar enabled."
    else print_skip "Skipping Finder Path Bar setting."; fi

    if ask_yes_no "Show Status Bar in Finder?"; then
        defaults write com.apple.finder ShowStatusBar -bool true && print_success "Finder Status Bar enabled."
    else print_skip "Skipping Finder Status Bar setting."; fi

    killall Finder
    print_info "Finder restarted to apply changes."
}
install_core_tools() {
    print_section "🛠️ STEP 3: CORE SYSTEM TOOLS"
    if ! ask_yes_no "Install core tools (Xcode Command Line Tools & Homebrew)?"; then
        print_skip "Skipping entire core tools installation."
        return
    fi

    if ask_yes_no "Install Xcode Command Line Tools?"; then
        if xcode-select -p &>/dev/null; then
            print_success "Xcode Command Line Tools are already installed."
        else
            xcode-select --install
            print_info "A system dialog will appear. Please complete the installation."
            until xcode-select -p &>/dev/null; do sleep 5; done
            print_success "Xcode Command Line Tools installed."
        fi
    else print_skip "Skipping Xcode Command Line Tools."; fi

    if ask_yes_no "Install Homebrew package manager?"; then
        if command -v brew &>/dev/null; then
            print_success "Homebrew is already installed."
        else
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            if [[ $(uname -m) == "arm64" ]]; then
                (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
            print_success "Homebrew installed."
        fi
    else print_skip "Skipping Homebrew installation."; fi
}



install_browsers() {
    print_section "🌐 STEP 4A: WEB BROWSERS"
    if ! command -v brew &>/dev/null; then print_warning "Homebrew not found, skipping."; return; fi
    if ! ask_yes_no "Install web browsers?"; then
        print_skip "Skipping all browser installations."
        return
    fi

    local browsers=( "google-chrome" "firefox" "brave-browser" "tor-browser" )
    for browser in "${browsers[@]}"; do
        if ask_yes_no "Install Browser: ${browser}?"; then
            execute "brew install --cask $browser" "Installing ${browser}..." && print_success "Installed ${browser}." || print_warning "Failed to install ${browser}."
        else print_skip "Skipped ${browser}."; fi
    done
}

install_ides() {
    print_section "💻 STEP 4B: IDEs & CODE EDITORS"
    if ! command -v brew &>/dev/null; then print_warning "Homebrew not found, skipping."; return; fi
    if ! ask_yes_no "Install IDEs and code editors?"; then
        print_skip "Skipping all IDE installations."
        return
    fi

    local ides=( "visual-studio-code" "iterm2" "warp" )
    for ide in "${ides[@]}"; do
        if ask_yes_no "Install IDE: ${ide}?"; then
            execute "brew install --cask $ide" "Installing ${ide}..." && print_success "Installed ${ide}." || print_warning "Failed to install ${ide}."
        else print_skip "Skipped ${ide}."; fi
    done
}

install_utility_apps() {
    print_section "🔧 STEP 4C: UTILITY APPLICATIONS"
    if ! command -v brew &>/dev/null; then print_warning "Homebrew not found, skipping."; return; fi
    if ! ask_yes_no "Install utility applications?"; then
        print_skip "Skipping all utility application installations."
        return
    fi

    local utility_apps=( "raycast" "bitwarden" "rectangle" "maccy" "imageoptim" "keycastr" )
    for app in "${utility_apps[@]}"; do
        if ask_yes_no "Install Utility: ${app}?"; then
            execute "brew install --cask $app" "Installing ${app}..." && print_success "Installed ${app}." || print_warning "Failed to install ${app}."
        else print_skip "Skipped ${app}."; fi
    done
}

install_communication_apps() {
    print_section "💬 STEP 4D: COMMUNICATION APPS"
    if ! command -v brew &>/dev/null; then print_warning "Homebrew not found, skipping."; return; fi
    if ! ask_yes_no "Install communication applications?"; then
        print_skip "Skipping all communication app installations."
        return
    fi

    local comm_apps=( "slack" "discord" "signal" "zoom" "skype" )
    for app in "${comm_apps[@]}"; do
        if ask_yes_no "Install Communication: ${app}?"; then
            execute "brew install --cask $app" "Installing ${app}..." && print_success "Installed ${app}." || print_warning "Failed to install ${app}."
        else print_skip "Skipped ${app}."; fi
    done
}

install_media_apps() {
    print_section "🎥 STEP 4E: MEDIA & CREATIVE APPS"
    if ! command -v brew &>/dev/null; then print_warning "Homebrew not found, skipping."; return; fi
    if ! ask_yes_no "Install media and creative applications?"; then
        print_skip "Skipping all media app installations."
        return
    fi

    local media_apps=( "vlc" "obs" "shotcut" "figma" "calibre" )
    for app in "${media_apps[@]}"; do
        if ask_yes_no "Install Media App: ${app}?"; then
            execute "brew install --cask $app" "Installing ${app}..." && print_success "Installed ${app}." || print_warning "Failed to install ${app}."
        else print_skip "Skipped ${app}."; fi
    done
}

install_security_apps() {
    print_section "🔐 STEP 4F: SECURITY & PRIVACY APPS"
    if ! command -v brew &>/dev/null; then print_warning "Homebrew not found, skipping."; return; fi
    if ! ask_yes_no "Install security and privacy applications?"; then
        print_skip "Skipping all security app installations."
        return
    fi

    local security_apps=( "protonvpn" )
    for app in "${security_apps[@]}"; do
        if ask_yes_no "Install Security App: ${app}?"; then
            execute "brew install --cask $app" "Installing ${app}..." && print_success "Installed ${app}." || print_warning "Failed to install ${app}."
        else print_skip "Skipped ${app}."; fi
    done
}

install_dev_apps() {
    print_section "🛠️ STEP 5: DEVELOPMENT TOOLS"
    if ! command -v brew &>/dev/null; then print_warning "Homebrew not found, skipping."; return; fi
    if ! ask_yes_no "Install development tools and applications?"; then
        print_skip "Skipping all development application installations."
        return
    fi

    local dev_apps=( "docker" "postman" "sequel-ace" "ngrok" )
    for app in "${dev_apps[@]}"; do
        if ask_yes_no "Install Dev Tool: ${app}?"; then
            execute "brew install --cask $app" "Installing ${app}..." && print_success "Installed ${app}." || print_warning "Failed to install ${app}."
        else print_skip "Skipped ${app}."; fi
    done
}

install_databases() {
    print_section "🗄️ STEP 5B: DATABASE SYSTEMS"
    if ! ask_yes_no "Install database systems?"; then
        print_skip "Skipping all database installations."
        return
    fi

    # Redis installation via Homebrew
    if ask_yes_no "Install Redis (in-memory data store)?"; then
        if command -v brew &>/dev/null; then
            if execute "brew install redis" "Installing Redis..." 3; then
                print_success "Redis installed successfully."
                print_info "Start Redis with: brew services start redis"
                verify_installation "Redis" "redis-server"
            else
                print_warning "Failed to install Redis after multiple attempts."
            fi
        else
            print_warning "Homebrew not found, skipping Redis installation."
        fi
    else
        print_skip "Skipping Redis installation."
    fi

    # PostgreSQL installation via DMG
    if ask_yes_no "Install PostgreSQL (relational database)?"; then
        local POSTGRES_URL="https://sbp.enterprisedb.com/getfile.jsp?fileid=1259745"
        local DMG_PATH="/tmp/postgresql-installer.dmg"
        local MOUNT_POINT="/Volumes/PostgreSQL"

        print_info "Downloading PostgreSQL installer..."
        if download_with_retry "$POSTGRES_URL" "$DMG_PATH" 3; then
            print_success "PostgreSQL installer downloaded successfully."

            print_info "Mounting PostgreSQL installer..."
            if hdiutil attach "$DMG_PATH" -quiet; then
                # Find the installer package in the mounted volume
                local INSTALLER_PKG=$(find "$MOUNT_POINT" -name "*.app" -o -name "*.pkg" | head -1)

                if [ -n "$INSTALLER_PKG" ] && [ -f "$INSTALLER_PKG" ]; then
                    print_info "PostgreSQL installer found. Opening installer (follow the installation wizard)..."
                    open "$INSTALLER_PKG"

                    print_info "Waiting for installation to complete. Press ENTER when finished..."
                    read -r

                    # Unmount and cleanup
                    hdiutil detach "$MOUNT_POINT" -quiet 2>/dev/null || true
                    rm -f "$DMG_PATH"
                    print_success "PostgreSQL installation completed and installer files cleaned up."

                    # Try to verify installation
                    if command_exists "psql"; then
                        verify_installation "PostgreSQL" "psql"
                    else
                        print_info "PostgreSQL may need to be added to PATH. Check /Applications/PostgreSQL*/bin/"
                    fi
                else
                    print_warning "Could not find PostgreSQL installer in the mounted volume."
                    hdiutil detach "$MOUNT_POINT" -quiet 2>/dev/null || true
                    rm -f "$DMG_PATH"
                fi
            else
                print_warning "Failed to mount PostgreSQL installer."
                rm -f "$DMG_PATH"
            fi
        else
            print_warning "Failed to download PostgreSQL installer after multiple attempts."
        fi
    else
        print_skip "Skipping PostgreSQL installation."
    fi
}

install_cli_tools() {
    print_section "${TOOLS} STEP 6: COMMAND-LINE TOOLS"
    if ! command -v brew &>/dev/null; then print_warning "Homebrew not found, skipping."; return; fi
    if ! ask_yes_no "Install command-line tools?"; then
        print_skip "Skipping all command-line tool installations."
        return
    fi

    local terminal_tools=( "wget" "exa" "git" "yarn" "pnpm" "graphicsmagick" "commitizen" "cmatrix" "vips" )
    for tool in "${terminal_tools[@]}"; do
        if ask_yes_no "Install CLI Tool: ${tool}?"; then
            if execute "brew install $tool" "Installing ${tool}..." 3; then
                print_success "Installed ${tool}."
                # Verify installation for important tools
                case "$tool" in
                    "git"|"yarn"|"pnpm")
                        verify_installation "$tool" "$tool"
                        ;;
                esac
            else
                print_warning "Failed to install ${tool} after multiple attempts."
            fi
        else
            print_skip "Skipped ${tool}."
        fi
    done
}

configure_environments() {
    print_section "${ENV} STEP 7: PROGRAMMING ENVIRONMENTS"
    if ! ask_yes_no "Configure programming language environments?"; then
        print_skip "Skipping all environment setups."
        return
    fi

    # --- Node.js Setup ---
    if ask_yes_no "Configure Node.js environment?"; then
        print_info "This will install NVM (Node Version Manager) and Node.js."

        # Check if NVM is already installed
        if [ -s "$HOME/.nvm/nvm.sh" ]; then
            print_success "NVM is already installed."
            # Source NVM for current session
            export NVM_DIR="$HOME/.nvm"
            \. "$NVM_DIR/nvm.sh"
        else
            # Install NVM using the official script
            print_info "Installing NVM (Node Version Manager)..."
            if curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash; then
                print_success "NVM installation script completed."

                # Source NVM for the current session
                export NVM_DIR="$HOME/.nvm"
                if [ -s "$NVM_DIR/nvm.sh" ]; then
                    \. "$NVM_DIR/nvm.sh"
                    print_success "NVM sourced for current session."
                else
                    print_warning "NVM installation completed but nvm.sh not found. Please restart your terminal."
                fi
            else
                print_warning "Failed to install NVM. Skipping Node.js setup."
                return
            fi
        fi

        # Check if NVM command is available
        if command -v nvm &>/dev/null; then
            # Install Node.js if requested
            if ask_yes_no "Install Node.js v22 (LTS)?"; then
                print_info "Installing Node.js v22..."
                if nvm install 22; then
                    nvm use 22
                    nvm alias default 22
                    print_success "Node.js v22 installed and set as default."

                    # Verify installation
                    local NODE_VERSION=$(node --version 2>/dev/null)
                    local NPM_VERSION=$(npm --version 2>/dev/null)
                    if [ -n "$NODE_VERSION" ] && [ -n "$NPM_VERSION" ]; then
                        print_success "Node.js $NODE_VERSION and npm $NPM_VERSION are working correctly."
                    else
                        print_warning "Node.js installed but verification failed."
                    fi
                else
                    print_warning "Failed to install Node.js v22."
                fi
            else
                print_skip "Skipping Node.js v22 installation."
            fi

            # Configure NPM if Node.js is available
            if command -v npm &>/dev/null && ask_yes_no "Set npm default author details?"; then
                printf "${YELLOW}Enter your full name for npm packages: ${NC}"; read -r npm_name
                printf "${YELLOW}Enter your email for npm packages: ${NC}"; read -r npm_email
                printf "${YELLOW}Enter your URL (e.g., website.com): ${NC}"; read -r npm_url

                if [ -n "$npm_name" ] && [ -n "$npm_email" ]; then
                    npm set init-author-name="$npm_name"
                    npm set init-author-email="$npm_email"
                    [ -n "$npm_url" ] && npm set init-author-url="$npm_url"
                    print_success "NPM author defaults configured."
                else
                    print_warning "Invalid input. NPM author defaults not set."
                fi
            else
                print_skip "Skipping npm author defaults."
            fi
        else
            print_warning "NVM installation completed but command not available. Please restart your terminal and run 'nvm install 22' manually."
        fi
    else
        print_skip "Skipping Node.js setup."
    fi

    # --- Python Setup ---
    if ask_yes_no "Configure Python environment?"; then
        if ask_yes_no "Install Python 3.13.7 from python.org?"; then
            local PYTHON_URL="https://www.python.org/ftp/python/3.13.7/python-3.13.7-macos11.pkg"
            local PKG_PATH="/tmp/python-3.13.7.pkg"

            execute "curl -L -o $PKG_PATH $PYTHON_URL" "Downloading Python 3.13.7..."

            if [ -f "$PKG_PATH" ]; then
                print_info "Python package downloaded. Installer requires administrator password."
                sudo installer -pkg "$PKG_PATH" -target /
                rm "$PKG_PATH"
                print_success "Python 3.13.7 installed and package deleted."
            else
                print_warning "Failed to download Python package."
            fi
        else
            print_skip "Skipping Python installation."
        fi
    else
        print_skip "Skipping Python setup."
    fi

    # --- Java Setup ---
    if ask_yes_no "Configure Java environment?"; then
        if ask_yes_no "Install Java 25 (JDK) from Oracle?"; then
            local JAVA_URL="https://download.oracle.com/java/25/latest/jdk-25_macos-x64_bin.tar.gz"
            local TAR_PATH="/tmp/jdk-25.tar.gz"
            local JAVA_HOME_DIR="/Library/Java/JavaVirtualMachines"

            print_info "Downloading Java 25 JDK..."
            if download_with_retry "$JAVA_URL" "$TAR_PATH" 3; then
                print_success "Java JDK downloaded successfully."

                print_info "Extracting Java JDK (requires administrator password)..."
                sudo mkdir -p "$JAVA_HOME_DIR"

                if sudo tar -xzf "$TAR_PATH" -C "$JAVA_HOME_DIR"; then
                    rm -f "$TAR_PATH"

                    # Find the extracted JDK directory
                    local JDK_DIR=$(find "$JAVA_HOME_DIR" -name "jdk-25*" -type d | head -1)

                    if [ -n "$JDK_DIR" ] && [ -d "$JDK_DIR" ]; then
                        print_success "Java 25 JDK installed to $JDK_DIR"

                        # Add JAVA_HOME to shell profiles
                        local JAVA_EXPORT="export JAVA_HOME=\"$JDK_DIR/Contents/Home\""
                        local PATH_EXPORT="export PATH=\"\$JAVA_HOME/bin:\$PATH\""

                        # Add to .zprofile and .zshrc for zsh
                        if ! grep -q "JAVA_HOME.*jdk-25" ~/.zprofile 2>/dev/null; then
                            echo "$JAVA_EXPORT" >> ~/.zprofile
                            echo "$PATH_EXPORT" >> ~/.zprofile
                            print_success "JAVA_HOME added to ~/.zprofile"
                        fi

                        if ! grep -q "JAVA_HOME.*jdk-25" ~/.zshrc 2>/dev/null; then
                            echo "$JAVA_EXPORT" >> ~/.zshrc
                            echo "$PATH_EXPORT" >> ~/.zshrc
                            print_success "JAVA_HOME added to ~/.zshrc"
                        fi

                        # Set for current session
                        export JAVA_HOME="$JDK_DIR/Contents/Home"
                        export PATH="$JAVA_HOME/bin:$PATH"

                        # Verify installation
                        if verify_installation "Java" "java"; then
                            print_success "Java environment configured successfully."
                        else
                            print_warning "Java installed but verification failed. Try running 'java --version' in a new terminal."
                        fi
                    else
                        print_warning "Could not locate extracted JDK directory."
                    fi
                else
                    print_warning "Failed to extract Java JDK."
                    rm -f "$TAR_PATH"
                fi
            else
                print_warning "Failed to download Java JDK after multiple attempts."
            fi
        else
            print_skip "Skipping Java installation."
        fi
    else
        print_skip "Skipping Java setup."
    fi
}

configure_git_ssh() {
    print_section "${KEY} STEP 8: GIT & SSH CONFIGURATION"
    if ! ask_yes_no "Configure Git and SSH?"; then
        print_skip "Skipping Git & SSH configuration."
        return
    fi

    if command -v git &>/dev/null && ask_yes_no "Configure Git global name and email?"; then
        printf "${YELLOW}Enter your full name for Git commits: ${NC}"; read -r git_name
        printf "${YELLOW}Enter your email for Git commits: ${NC}"; read -r git_email
        git config --global user.name "$git_name"
        git config --global user.email "$git_email"
        print_success "Git user configured."
    else print_skip "Skipping Git user configuration."; fi

    if ask_yes_no "Set default Git branch to 'main'?"; then
        git config --global init.defaultBranch main && print_success "Default branch set to 'main'."
    else print_skip "Skipping default branch change."; fi

    if ask_yes_no "Add improved 'git lg' alias for logs?"; then
        git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" && print_success "'git lg' alias added."
    else print_skip "Skipping 'git lg' alias."; fi

    if ask_yes_no "Generate a new SSH key for GitHub?"; then
        mkdir -p ~/.ssh
        ssh-keygen -t ed25519 -C "github" -f ~/.ssh/github
        print_info "SSH key created at ~/.ssh/github"
        touch ~/.ssh/config
        echo -e "Host *\n  AddKeysToAgent yes\n  UseKeychain yes\n  IdentityFile ~/.ssh/github" >> ~/.ssh/config
        print_success "SSH config updated for new key."
        ssh-add --apple-use-keychain ~/.ssh/github
        print_success "SSH key added to Keychain."
        pbcopy < ~/.ssh/github.pub
        print_warning "Your new public SSH key has been copied to the clipboard. Please add it to your GitHub account."
    else print_skip "Skipping SSH key generation."; fi
}

configure_vscode_settings() {
    print_section "${CODE} STEP 9: VS CODE SETTINGS"
    if [[ ! -d "/Applications/Visual Studio Code.app" ]]; then print_warning "VS Code not found, skipping."; return; fi
    if ! ask_yes_no "Apply custom settings to Visual Studio Code?"; then
        print_skip "Skipping all VS Code settings."
        return
    fi

    if ask_yes_no "Apply custom VS Code settings.json?"; then
        mkdir -p "$HOME/Library/Application Support/Code/User"
        cat > "$HOME/Library/Application Support/Code/User/settings.json" << 'EOF'
{
  "editor.lightbulb.enabled": "off", "editor.cursorBlinking": "solid", "editor.cursorStyle": "line", "editor.cursorWidth": 2, "window.titleBarStyle": "native", "window.customTitleBarVisibility": "never", "window.title": "${activeEditorMedium}", "files.trimTrailingWhitespace": true, "explorer.confirmDelete": false, "explorer.compactFolders": false, "workbench.sideBar.location": "right", "workbench.startupEditor": "none", "workbench.statusBar.visible": true, "workbench.editor.enablePreview": false, "workbench.editor.restoreViewState": true, "workbench.activityBar.location": "hidden", "workbench.colorTheme": "GitHub Dark Default", "terminal.integrated.fontSize": 14, "terminal.integrated.fontFamily": "Hack Nerd Font Mono", "editor.find.addExtraSpaceOnTop": true, "editor.padding.top": 36, "editor.stickyScroll.enabled": false, "editor.fontFamily": "Hack Nerd Font Mono", "editor.fontSize": 14, "editor.tabSize": 2, "editor.lineHeight": 0, "editor.insertSpaces": true, "editor.detectIndentation": false, "editor.renderWhitespace": "none", "editor.scrollBeyondLastLine": true, "editor.minimap.enabled": false, "editor.lineNumbers": "on", "editor.find.seedSearchStringFromSelection": "never", "editor.renderLineHighlight": "all", "workbench.colorCustomizations": { "editor.lineHighlightBackground": "#102032", "editorCursor.foreground": "#ffffff", "terminalCursor.foreground": "#ffffff" }, "files.associations": { ".env*": "makefile" }, "editor.formatOnSave": true, "[markdown]": { "editor.formatOnSave": false }, "[javascript]": { "editor.defaultFormatter": "esbenp.prettier-vscode" }, "[javascriptreact]": { "editor.defaultFormatter": "esbenp.prettier-vscode" }, "[typescript]": { "editor.defaultFormatter": "esbenp.prettier-vscode" }, "[typescriptreact]": { "editor.defaultFormatter": "esbenp.prettier-vscode" }, "prettier.documentSelectors": ["**/*.astro"], "[astro]": { "editor.defaultFormatter": "esbenp.prettier-vscode" }, "editor.codeActionsOnSave": { "source.fixAll.eslint": "explicit" }, "eslint.validate": ["javascript", "javascriptreact", "typescript", "typescriptreact"], "typescript.updateImportsOnFileMove.enabled": "never", "explorer.confirmDragAndDrop": false, "editor.inlineSuggest.enabled": true, "github.copilot.enable": { "*": true, "plaintext": false, "markdown": true }
}
EOF
        print_success "VS Code settings.json configured."
    else print_skip "Skipping VS Code settings.json."; fi

    if ask_yes_no "Apply custom VS Code keybindings.json?"; then
        cat > "$HOME/Library/Application Support/Code/User/keybindings.json" << 'EOF'
[
  { "key": "ctrl+up", "command": "cursorMove", "args": { "to": "up", "by": "line", "value": 10 }, "when": "editorTextFocus" },
  { "key": "ctrl+down", "command": "cursorMove", "args": { "to": "down", "by": "line", "value": 10 }, "when": "editorTextFocus" }
]
EOF
        print_success "VS Code keybindings.json configured."
    else print_skip "Skipping VS Code keybindings.json."; fi
}

show_completion() {
    print_section "🎉 SETUP COMPLETE 🎉"
    print_success "Your Mac is now a fully configured development machine."
    print_warning "Please restart your terminal for all changes to take effect."
    echo ""
}

# --- MAIN EXECUTION FLOW ---
main() {
    check_macos
    show_welcome
    system_prep
    configure_system_prefs
    install_core_tools
    install_browsers
    install_ides
    install_utility_apps
    install_communication_apps
    install_media_apps
    install_security_apps
    install_dev_apps
    install_databases
    install_cli_tools
    configure_environments
    configure_git_ssh
    configure_vscode_settings
    show_completion
}

main "$@"


