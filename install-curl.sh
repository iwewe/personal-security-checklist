#!/bin/bash

################################################################################
# Personal Security Checklist - Quick Installer (Curl Method)
# Skrip instalasi cepat untuk Personal Security Checklist
#
# Metode: Download archive dari GitHub
# Lisensi: MIT
# Repository: https://github.com/Lissy93/personal-security-checklist
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-curl.sh | bash
#   atau
#   wget -qO- https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-curl.sh | bash
################################################################################

set -e  # Exit on error

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Variabel
REPO_OWNER="Lissy93"
REPO_NAME="personal-security-checklist"
REPO_URL="https://github.com/${REPO_OWNER}/${REPO_NAME}"
ARCHIVE_URL="${REPO_URL}/archive/refs/heads/master.zip"
TARBALL_URL="${REPO_URL}/archive/refs/heads/master.tar.gz"
INSTALL_DIR="$HOME/personal-security-checklist"
TEMP_DIR="/tmp/psc-install-$$"
NODE_REQUIRED_VERSION="16"

################################################################################
# Fungsi Helper
################################################################################

print_header() {
    echo -e "\n${BLUE}================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
        print_info "Temporary files cleaned up"
    fi
}

trap cleanup EXIT

################################################################################
# Pemeriksaan Sistem
################################################################################

check_system() {
    print_header "Memeriksa Sistem"

    # Deteksi OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        print_success "OS: Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        print_success "OS: macOS"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        OS="windows"
        print_success "OS: Windows (Git Bash/WSL)"
    else
        print_error "OS tidak didukung: $OSTYPE"
        exit 1
    fi
}

check_download_tool() {
    print_header "Memeriksa Download Tool"

    if command_exists curl; then
        DOWNLOAD_CMD="curl"
        print_success "curl tersedia"
        return 0
    elif command_exists wget; then
        DOWNLOAD_CMD="wget"
        print_success "wget tersedia"
        return 0
    else
        print_error "curl atau wget tidak ditemukan"
        print_error "Silakan instal salah satu dari tool tersebut"
        exit 1
    fi
}

check_extract_tool() {
    print_header "Memeriksa Extract Tool"

    if command_exists unzip; then
        EXTRACT_CMD="unzip"
        ARCHIVE_TYPE="zip"
        print_success "unzip tersedia"
        return 0
    elif command_exists tar; then
        EXTRACT_CMD="tar"
        ARCHIVE_TYPE="tar"
        print_success "tar tersedia"
        return 0
    else
        print_error "unzip atau tar tidak ditemukan"
        print_error "Silakan instal unzip: sudo apt-get install unzip"
        exit 1
    fi
}

################################################################################
# Dependencies Check
################################################################################

check_node() {
    print_header "Memeriksa Node.js"

    if command_exists node; then
        NODE_VERSION=$(node --version | grep -oP '\d+' | head -1)
        print_info "Node.js versi $(node --version) ditemukan"

        if [ "$NODE_VERSION" -ge "$NODE_REQUIRED_VERSION" ]; then
            print_success "Node.js versi memenuhi syarat (>= $NODE_REQUIRED_VERSION)"
            return 0
        else
            print_warning "Node.js versi terlalu lama (diperlukan >= $NODE_REQUIRED_VERSION)"
            print_info "Silakan update Node.js dari https://nodejs.org"
            return 1
        fi
    else
        print_error "Node.js belum terinstal"
        print_info "Silakan instal Node.js dari https://nodejs.org"
        print_info "Atau gunakan install-git.sh untuk instalasi otomatis dependencies"
        exit 1
    fi
}

check_npm() {
    print_header "Memeriksa npm/yarn"

    if command_exists npm; then
        print_success "npm sudah terinstal (versi $(npm --version))"
        NPM_CMD="npm"
        return 0
    elif command_exists yarn; then
        print_success "yarn sudah terinstal (versi $(yarn --version))"
        NPM_CMD="yarn"
        return 0
    else
        print_error "npm/yarn belum terinstal"
        print_info "npm biasanya terinstal bersama Node.js"
        exit 1
    fi
}

check_python() {
    if command_exists python3; then
        print_success "Python3 tersedia (versi $(python3 --version))"
        PYTHON_CMD="python3"
        return 0
    elif command_exists python; then
        print_success "Python tersedia (versi $(python --version))"
        PYTHON_CMD="python"
        return 0
    else
        print_warning "Python tidak ditemukan (opsional untuk utilities)"
        return 1
    fi
}

################################################################################
# Download dan Extract
################################################################################

download_repository() {
    print_header "Mengunduh Repository"

    mkdir -p "$TEMP_DIR"
    cd "$TEMP_DIR"

    if [ "$EXTRACT_CMD" == "unzip" ]; then
        DOWNLOAD_URL="$ARCHIVE_URL"
        ARCHIVE_FILE="personal-security-checklist.zip"
    else
        DOWNLOAD_URL="$TARBALL_URL"
        ARCHIVE_FILE="personal-security-checklist.tar.gz"
    fi

    print_info "Downloading dari $DOWNLOAD_URL..."

    if [ "$DOWNLOAD_CMD" == "curl" ]; then
        curl -fsSL -o "$ARCHIVE_FILE" "$DOWNLOAD_URL"
    else
        wget -q -O "$ARCHIVE_FILE" "$DOWNLOAD_URL"
    fi

    if [ $? -eq 0 ]; then
        print_success "Repository berhasil diunduh"
    else
        print_error "Gagal mengunduh repository"
        exit 1
    fi
}

extract_repository() {
    print_header "Mengekstrak File"

    cd "$TEMP_DIR"

    if [ "$EXTRACT_CMD" == "unzip" ]; then
        print_info "Extracting dengan unzip..."
        unzip -q "$ARCHIVE_FILE"
        EXTRACTED_DIR="${REPO_NAME}-master"
    else
        print_info "Extracting dengan tar..."
        tar -xzf "$ARCHIVE_FILE"
        EXTRACTED_DIR="${REPO_NAME}-master"
    fi

    if [ $? -eq 0 ]; then
        print_success "File berhasil diekstrak"
    else
        print_error "Gagal mengekstrak file"
        exit 1
    fi
}

move_to_install_dir() {
    print_header "Memindahkan File"

    if [ -d "$INSTALL_DIR" ]; then
        print_warning "Direktori $INSTALL_DIR sudah ada"

        # Non-interactive mode: backup old directory
        BACKUP_DIR="${INSTALL_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
        print_info "Membuat backup ke $BACKUP_DIR"
        mv "$INSTALL_DIR" "$BACKUP_DIR"
    fi

    print_info "Memindahkan ke $INSTALL_DIR..."
    mv "$TEMP_DIR/$EXTRACTED_DIR" "$INSTALL_DIR"

    if [ $? -eq 0 ]; then
        print_success "File berhasil dipindahkan"
    else
        print_error "Gagal memindahkan file"
        exit 1
    fi
}

################################################################################
# Instalasi Dependencies
################################################################################

install_web_dependencies() {
    print_header "Menginstal Dependencies Web App"

    cd "$INSTALL_DIR/web"

    print_info "Menginstal dependencies dengan $NPM_CMD..."
    print_warning "Proses ini mungkin memakan waktu beberapa menit..."

    if [ "$NPM_CMD" == "yarn" ]; then
        yarn install
    else
        npm install
    fi

    if [ $? -eq 0 ]; then
        print_success "Dependencies web app berhasil diinstal"
    else
        print_error "Gagal menginstal dependencies"
        print_info "Coba jalankan manual: cd $INSTALL_DIR/web && npm install"
        exit 1
    fi
}

install_python_dependencies() {
    if command_exists $PYTHON_CMD; then
        print_header "Menginstal Python Dependencies (Opsional)"

        cd "$INSTALL_DIR/lib"

        if command_exists pip3; then
            PIP_CMD="pip3"
        elif command_exists pip; then
            PIP_CMD="pip"
        else
            print_warning "pip tidak ditemukan, skip Python dependencies"
            return 1
        fi

        print_info "Menginstal Python packages..."
        $PIP_CMD install --user -r requirements.txt

        if [ $? -eq 0 ]; then
            print_success "Python dependencies berhasil diinstal"
        else
            print_warning "Gagal menginstal Python dependencies (tidak kritis)"
        fi
    fi
}

################################################################################
# Setup Environment
################################################################################

create_aliases() {
    print_header "Membuat Shortcut (Opsional)"

    SHELL_RC=""
    if [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
    fi

    if [ -n "$SHELL_RC" ]; then
        print_info "Menambahkan alias ke $SHELL_RC"

        echo "" >> "$SHELL_RC"
        echo "# Personal Security Checklist aliases" >> "$SHELL_RC"
        echo "alias psc-dev='cd $INSTALL_DIR/web && npm run dev'" >> "$SHELL_RC"
        echo "alias psc-build='cd $INSTALL_DIR/web && npm run build'" >> "$SHELL_RC"
        echo "alias psc-dir='cd $INSTALL_DIR'" >> "$SHELL_RC"

        print_success "Alias berhasil ditambahkan"
        print_info "Jalankan 'source $SHELL_RC' atau buka terminal baru"
        print_info "Kemudian gunakan: psc-dev, psc-build, psc-dir"
    fi
}

################################################################################
# Informasi Akhir
################################################################################

print_final_info() {
    print_header "Instalasi Selesai!"

    echo -e "${GREEN}Personal Security Checklist berhasil diinstal!${NC}\n"

    echo -e "${BLUE}Lokasi instalasi:${NC}"
    echo -e "  $INSTALL_DIR\n"

    echo -e "${BLUE}Untuk menjalankan aplikasi:${NC}"
    echo -e "  ${GREEN}cd $INSTALL_DIR/web${NC}"

    if [ "$NPM_CMD" == "yarn" ]; then
        echo -e "  ${GREEN}yarn dev${NC}"
    else
        echo -e "  ${GREEN}npm run dev${NC}"
    fi

    echo -e "\n${BLUE}Aplikasi akan berjalan di:${NC}"
    echo -e "  ${GREEN}http://localhost:5173${NC}\n"

    echo -e "${BLUE}Command berguna lainnya:${NC}"
    if [ "$NPM_CMD" == "yarn" ]; then
        echo -e "  yarn build         - Build untuk production"
        echo -e "  yarn build.static  - Build static files"
        echo -e "  yarn preview       - Preview production build"
    else
        echo -e "  npm run build         - Build untuk production"
        echo -e "  npm run build.static  - Build static files"
        echo -e "  npm run preview       - Preview production build"
    fi

    if command_exists $PYTHON_CMD; then
        echo -e "\n${BLUE}Python utilities:${NC}"
        echo -e "  cd $INSTALL_DIR/lib"
        echo -e "  $PYTHON_CMD generate.py  - Generate CHECKLIST.md dari YAML"
        echo -e "  $PYTHON_CMD validate.py  - Validasi YAML structure"
    fi

    echo -e "\n${BLUE}Quick start dengan alias:${NC}"
    echo -e "  psc-dev    - Mulai development server"
    echo -e "  psc-build  - Build aplikasi"
    echo -e "  psc-dir    - Masuk ke direktori proyek"

    echo -e "\n${BLUE}Dokumentasi lengkap:${NC}"
    echo -e "  Local:  $INSTALL_DIR/README.md"
    echo -e "  Online: https://github.com/Lissy93/personal-security-checklist"
    echo -e "  Live:   https://digital-defense.io\n"

    echo -e "${GREEN}Selamat menggunakan Personal Security Checklist!${NC}"
    echo -e "${YELLOW}Jangan lupa bintang repository di GitHub! ⭐${NC}\n"
}

################################################################################
# Main Installation Flow
################################################################################

main() {
    clear
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════════╗"
    echo "║  Personal Security Checklist - Quick Installer       ║"
    echo "║  Instalasi via Curl/Wget                             ║"
    echo "╚═══════════════════════════════════════════════════════╝"
    echo -e "${NC}\n"

    print_info "Skrip ini akan menginstal Personal Security Checklist"
    print_info "Lokasi: $INSTALL_DIR\n"

    # System checks
    check_system
    check_download_tool
    check_extract_tool

    # Dependencies check
    check_node
    check_npm
    check_python

    # Download and extract
    download_repository
    extract_repository
    move_to_install_dir

    # Install dependencies
    install_web_dependencies
    install_python_dependencies

    # Create shortcuts
    create_aliases

    # Print final info
    print_final_info
}

# Run main installation
main
