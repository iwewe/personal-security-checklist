#!/bin/bash

################################################################################
# Personal Security Checklist - Installer Script (Git Method)
# Skrip instalasi otomatis untuk Personal Security Checklist
#
# Metode: Clone dari Git Repository
# Lisensi: MIT
# Repository: https://github.com/Lissy93/personal-security-checklist
################################################################################

set -e  # Exit on error

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Variabel
REPO_URL="https://github.com/Lissy93/personal-security-checklist.git"
INSTALL_DIR="$HOME/personal-security-checklist"
NODE_REQUIRED_VERSION="16"
PYTHON_REQUIRED_VERSION="3.8"

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

# Fungsi untuk memeriksa apakah command tersedia
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Fungsi untuk membandingkan versi
version_ge() {
    printf '%s\n%s\n' "$2" "$1" | sort -V -C
}

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

################################################################################
# Instalasi Dependencies
################################################################################

check_git() {
    print_header "Memeriksa Git"

    if command_exists git; then
        GIT_VERSION=$(git --version | grep -oP '\d+\.\d+\.\d+' | head -1)
        print_success "Git sudah terinstal (versi $GIT_VERSION)"
        return 0
    else
        print_warning "Git belum terinstal"
        return 1
    fi
}

install_git() {
    print_info "Menginstal Git..."

    if [[ "$OS" == "linux" ]]; then
        if command_exists apt-get; then
            sudo apt-get update
            sudo apt-get install -y git
        elif command_exists yum; then
            sudo yum install -y git
        elif command_exists dnf; then
            sudo dnf install -y git
        elif command_exists pacman; then
            sudo pacman -S --noconfirm git
        else
            print_error "Package manager tidak dikenali. Silakan instal Git secara manual."
            exit 1
        fi
    elif [[ "$OS" == "macos" ]]; then
        if command_exists brew; then
            brew install git
        else
            print_error "Homebrew tidak terinstal. Silakan instal dari https://brew.sh"
            exit 1
        fi
    fi

    if command_exists git; then
        print_success "Git berhasil diinstal"
    else
        print_error "Gagal menginstal Git"
        exit 1
    fi
}

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
            return 1
        fi
    else
        print_warning "Node.js belum terinstal"
        return 1
    fi
}

install_node() {
    print_info "Menginstal Node.js..."

    if [[ "$OS" == "linux" ]]; then
        # Menggunakan NodeSource repository untuk versi terbaru
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
    elif [[ "$OS" == "macos" ]]; then
        if command_exists brew; then
            brew install node
        else
            print_error "Homebrew tidak terinstal"
            exit 1
        fi
    fi

    if command_exists node; then
        print_success "Node.js berhasil diinstal (versi $(node --version))"
    else
        print_error "Gagal menginstal Node.js"
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
        print_warning "npm/yarn belum terinstal"
        return 1
    fi
}

install_npm() {
    # npm biasanya terinstal bersama Node.js
    if command_exists npm; then
        print_success "npm tersedia"
        NPM_CMD="npm"
    else
        print_error "npm tidak ditemukan setelah instalasi Node.js"
        exit 1
    fi
}

check_python() {
    print_header "Memeriksa Python (Opsional)"

    if command_exists python3; then
        PYTHON_VERSION=$(python3 --version | grep -oP '\d+\.\d+' | head -1)
        print_success "Python3 sudah terinstal (versi $(python3 --version))"
        PYTHON_CMD="python3"
        return 0
    elif command_exists python; then
        PYTHON_VERSION=$(python --version | grep -oP '\d+\.\d+' | head -1)
        print_success "Python sudah terinstal (versi $(python --version))"
        PYTHON_CMD="python"
        return 0
    else
        print_warning "Python belum terinstal (opsional untuk utilities)"
        return 1
    fi
}

install_python() {
    print_info "Menginstal Python3..."

    if [[ "$OS" == "linux" ]]; then
        if command_exists apt-get; then
            sudo apt-get update
            sudo apt-get install -y python3 python3-pip
        elif command_exists yum; then
            sudo yum install -y python3 python3-pip
        elif command_exists dnf; then
            sudo dnf install -y python3 python3-pip
        elif command_exists pacman; then
            sudo pacman -S --noconfirm python python-pip
        fi
    elif [[ "$OS" == "macos" ]]; then
        if command_exists brew; then
            brew install python3
        fi
    fi

    if command_exists python3; then
        print_success "Python3 berhasil diinstal"
        PYTHON_CMD="python3"
    else
        print_warning "Gagal menginstal Python3 (tidak kritis)"
    fi
}

################################################################################
# Instalasi Aplikasi
################################################################################

clone_repository() {
    print_header "Mengunduh Repository"

    if [ -d "$INSTALL_DIR" ]; then
        print_warning "Direktori $INSTALL_DIR sudah ada"
        read -p "Apakah Anda ingin menghapus dan clone ulang? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$INSTALL_DIR"
            print_info "Direktori lama dihapus"
        else
            print_info "Menggunakan direktori yang ada"
            return 0
        fi
    fi

    print_info "Cloning repository dari $REPO_URL..."
    git clone "$REPO_URL" "$INSTALL_DIR"

    if [ $? -eq 0 ]; then
        print_success "Repository berhasil di-clone"
    else
        print_error "Gagal clone repository"
        exit 1
    fi
}

install_web_dependencies() {
    print_header "Menginstal Dependencies Web App"

    cd "$INSTALL_DIR/web"

    print_info "Menginstal dependencies dengan $NPM_CMD..."

    if [ "$NPM_CMD" == "yarn" ]; then
        yarn install
    else
        npm install
    fi

    if [ $? -eq 0 ]; then
        print_success "Dependencies web app berhasil diinstal"
    else
        print_error "Gagal menginstal dependencies"
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
        $PIP_CMD install -r requirements.txt

        if [ $? -eq 0 ]; then
            print_success "Python dependencies berhasil diinstal"
        else
            print_warning "Gagal menginstal Python dependencies (tidak kritis)"
        fi
    fi
}

################################################################################
# Testing
################################################################################

test_installation() {
    print_header "Menguji Instalasi"

    cd "$INSTALL_DIR/web"

    # Test build
    print_info "Menjalankan test build..."

    if [ "$NPM_CMD" == "yarn" ]; then
        timeout 60 yarn build || true
    else
        timeout 60 npm run build || true
    fi

    print_success "Build test selesai"
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
    echo -e "  cd $INSTALL_DIR/web"

    if [ "$NPM_CMD" == "yarn" ]; then
        echo -e "  yarn dev"
    else
        echo -e "  npm run dev"
    fi

    echo -e "\n${BLUE}Aplikasi akan berjalan di:${NC}"
    echo -e "  http://localhost:5173\n"

    echo -e "${BLUE}Command lainnya:${NC}"
    if [ "$NPM_CMD" == "yarn" ]; then
        echo -e "  yarn build         - Build untuk production"
        echo -e "  yarn build.static  - Build static files"
        echo -e "  yarn preview       - Preview production build"
        echo -e "  yarn lint          - Run linter"
        echo -e "  yarn fmt           - Format code"
    else
        echo -e "  npm run build         - Build untuk production"
        echo -e "  npm run build.static  - Build static files"
        echo -e "  npm run preview       - Preview production build"
        echo -e "  npm run lint          - Run linter"
        echo -e "  npm run fmt           - Format code"
    fi

    if command_exists $PYTHON_CMD; then
        echo -e "\n${BLUE}Python utilities:${NC}"
        echo -e "  cd $INSTALL_DIR/lib"
        echo -e "  $PYTHON_CMD generate.py  - Generate CHECKLIST.md"
        echo -e "  $PYTHON_CMD validate.py  - Validate YAML"
    fi

    echo -e "\n${BLUE}Dokumentasi:${NC}"
    echo -e "  https://github.com/Lissy93/personal-security-checklist"
    echo -e "  https://digital-defense.io\n"

    echo -e "${GREEN}Selamat menggunakan Personal Security Checklist!${NC}\n"
}

################################################################################
# Main Installation Flow
################################################################################

main() {
    clear
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════════╗"
    echo "║  Personal Security Checklist - Installer             ║"
    echo "║  Instalasi via Git Clone                             ║"
    echo "╚═══════════════════════════════════════════════════════╝"
    echo -e "${NC}\n"

    # System check
    check_system

    # Check dan install Git
    if ! check_git; then
        install_git
    fi

    # Check dan install Node.js
    if ! check_node; then
        install_node
    fi

    # Check npm/yarn
    if ! check_npm; then
        install_npm
    fi

    # Check Python (optional)
    if ! check_python; then
        read -p "Install Python untuk utilities? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_python
        fi
    fi

    # Clone repository
    clone_repository

    # Install dependencies
    install_web_dependencies

    # Install Python dependencies jika ada
    install_python_dependencies

    # Test installation
    # test_installation

    # Print final info
    print_final_info
}

# Run main installation
main
