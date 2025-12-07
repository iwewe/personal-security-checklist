# Panduan Instalasi Personal Security Checklist

Dokumentasi lengkap untuk instalasi dan penggunaan Personal Security Checklist dalam Bahasa Indonesia.

## Daftar Isi

- [Persyaratan Sistem](#persyaratan-sistem)
- [Metode Instalasi](#metode-instalasi)
  - [1. Instalasi Otomatis via Git](#1-instalasi-otomatis-via-git)
  - [2. Instalasi Otomatis via Curl](#2-instalasi-otomatis-via-curl)
  - [3. Instalasi Manual](#3-instalasi-manual)
- [Menjalankan Aplikasi](#menjalankan-aplikasi)
- [Command dan Perintah](#command-dan-perintah)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)

---

## Persyaratan Sistem

### Sistem Operasi yang Didukung

- ✅ Linux (Ubuntu, Debian, Fedora, Arch, dll)
- ✅ macOS (10.15 Catalina atau lebih baru)
- ✅ Windows (via WSL, Git Bash, atau Cygwin)

### Software yang Diperlukan

#### Wajib (Required)

- **Node.js** (versi 16 atau lebih baru)
  - Cek versi: `node --version`
  - Download: https://nodejs.org

- **npm** atau **yarn** (package manager)
  - npm biasanya terinstal bersama Node.js
  - Cek versi: `npm --version`

#### Opsional (Recommended)

- **Git** (untuk clone repository)
  - Cek versi: `git --version`
  - Download: https://git-scm.com

- **Python 3.8+** (untuk utilities tambahan)
  - Cek versi: `python3 --version`
  - Download: https://python.org

### Persyaratan Minimum Hardware

- **RAM**: 2 GB (4 GB recommended)
- **Storage**: 500 MB ruang kosong
- **Internet**: Diperlukan untuk download dependencies

---

## Metode Instalasi

### 1. Instalasi Otomatis via Git

Metode ini merekomendasikan untuk pengguna yang sudah memiliki Git terinstal atau ingin instalasi lengkap dengan auto-install dependencies.

#### Langkah 1: Download Installer Script

```bash
# Download installer script
curl -fsSL https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-git.sh -o install-git.sh

# Atau gunakan wget
wget https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-git.sh
```

#### Langkah 2: Berikan Permission Eksekusi

```bash
chmod +x install-git.sh
```

#### Langkah 3: Jalankan Installer

```bash
./install-git.sh
```

#### Apa yang Dilakukan Script Ini?

Script akan otomatis:
- ✅ Deteksi sistem operasi Anda
- ✅ Cek dan install Git (jika belum ada)
- ✅ Cek dan install Node.js (jika belum ada)
- ✅ Cek dan install Python (opsional, dengan konfirmasi)
- ✅ Clone repository dari GitHub
- ✅ Install semua dependencies (npm packages)
- ✅ Install Python dependencies (jika Python tersedia)
- ✅ Verifikasi instalasi

#### Output yang Diharapkan

```
================================
Personal Security Checklist berhasil diinstal!
================================

Lokasi instalasi:
  /home/user/personal-security-checklist

Untuk menjalankan aplikasi:
  cd /home/user/personal-security-checklist/web
  npm run dev

Aplikasi akan berjalan di:
  http://localhost:5173
```

---

### 2. Instalasi Otomatis via Curl

Metode tercepat untuk instalasi one-liner tanpa perlu clone repository terlebih dahulu.

#### Instalasi One-Liner

```bash
# Menggunakan curl
curl -fsSL https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-curl.sh | bash

# Atau menggunakan wget
wget -qO- https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-curl.sh | bash
```

#### Catatan Penting

⚠️ **Persyaratan**: Node.js dan npm harus sudah terinstal terlebih dahulu
- Script ini tidak akan menginstal Node.js secara otomatis
- Jika Node.js belum ada, gunakan metode instalasi via Git

#### Apa yang Dilakukan Script Ini?

Script akan otomatis:
- ✅ Download repository sebagai archive (.zip atau .tar.gz)
- ✅ Extract file ke direktori home
- ✅ Install dependencies npm
- ✅ Install Python dependencies (jika tersedia)
- ✅ Membuat shortcut alias di shell RC file

#### Alias yang Dibuat

Setelah instalasi, Anda dapat menggunakan shortcut berikut:

```bash
psc-dev      # Mulai development server
psc-build    # Build aplikasi
psc-dir      # Masuk ke direktori proyek
```

Aktifkan alias dengan:
```bash
source ~/.bashrc  # untuk bash
source ~/.zshrc   # untuk zsh
```

---

### 3. Instalasi Manual

Untuk pengguna yang ingin kontrol penuh atau instalasi di environment khusus.

#### Langkah 1: Clone Repository

```bash
# Clone dengan Git
git clone https://github.com/Lissy93/personal-security-checklist.git

# Masuk ke direktori
cd personal-security-checklist
```

#### Langkah 2: Install Dependencies Web App

```bash
# Masuk ke direktori web
cd web

# Install dengan npm
npm install

# Atau dengan yarn (jika lebih suka)
yarn install
```

#### Langkah 3: Install Python Dependencies (Opsional)

```bash
# Kembali ke root directory
cd ..

# Masuk ke lib directory
cd lib

# Install dengan pip
pip3 install -r requirements.txt

# Atau dengan user flag (jika tidak punya sudo)
pip3 install --user -r requirements.txt
```

#### Langkah 4: Verifikasi Instalasi

```bash
# Masuk ke web directory
cd ../web

# Test build
npm run build

# Jika sukses, Anda siap menjalankan aplikasi
```

---

## Menjalankan Aplikasi

### Development Mode

Mode development dengan hot-reload untuk development:

```bash
cd web
npm run dev
```

Atau dengan yarn:

```bash
cd web
yarn dev
```

**Akses aplikasi di**: http://localhost:5173

### Production Build

Build aplikasi untuk production:

```bash
cd web
npm run build
```

Preview production build:

```bash
npm run preview
```

### Static Build

Build untuk deploy sebagai static files:

```bash
npm run build.static
```

Output akan tersimpan di: `web/dist/`

---

## Command dan Perintah

### Web Application Commands

| Command | Deskripsi |
|---------|-----------|
| `npm run dev` | Jalankan development server dengan hot-reload |
| `npm run build` | Build aplikasi untuk production |
| `npm run build.static` | Build static files untuk hosting |
| `npm run preview` | Preview production build lokal |
| `npm run lint` | Jalankan ESLint untuk cek kode |
| `npm run fmt` | Format kode dengan Prettier |
| `npm run clean` | Bersihkan cache dan build artifacts |

### Python Utilities Commands

```bash
# Masuk ke lib directory
cd lib

# Generate CHECKLIST.md dari YAML
python3 generate.py

# Validasi struktur YAML
python3 validate.py
```

### Git Commands (untuk Kontributor)

```bash
# Update repository
git pull origin master

# Cek status
git status

# Lihat perubahan
git diff

# Commit perubahan
git add .
git commit -m "Deskripsi perubahan"

# Push ke fork Anda
git push origin master
```

---

## Troubleshooting

### Error: "node: command not found"

**Penyebab**: Node.js belum terinstal

**Solusi**:
```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# macOS dengan Homebrew
brew install node

# Atau download dari nodejs.org
```

### Error: "npm: command not found"

**Penyebab**: npm tidak terinstal (jarang terjadi jika Node.js terinstal dengan benar)

**Solusi**:
```bash
# Install npm secara terpisah
sudo apt-get install npm  # Linux
brew install npm           # macOS
```

### Error: Permission Denied saat npm install

**Penyebab**: npm mencoba install ke direktori yang memerlukan sudo

**Solusi**:
```bash
# Jangan gunakan sudo dengan npm
# Sebagai gantinya, konfigurasi npm untuk user directory
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# Tambahkan ke PATH di ~/.bashrc atau ~/.zshrc
export PATH=~/.npm-global/bin:$PATH

# Reload shell config
source ~/.bashrc
```

### Error: Port 5173 Already in Use

**Penyebab**: Port sudah digunakan oleh aplikasi lain

**Solusi**:
```bash
# Hentikan proses yang menggunakan port
lsof -ti:5173 | xargs kill -9

# Atau gunakan port lain
npm run dev -- --port 3000
```

### Build Gagal: Out of Memory

**Penyebab**: RAM tidak cukup untuk build process

**Solusi**:
```bash
# Increase Node.js memory limit
export NODE_OPTIONS="--max-old-space-size=4096"
npm run build
```

### Python Dependencies Installation Failed

**Penyebab**: pip tidak terinstal atau versi Python tidak sesuai

**Solusi**:
```bash
# Install pip
sudo apt-get install python3-pip  # Linux
brew install python3               # macOS

# Upgrade pip
pip3 install --upgrade pip

# Install dependencies dengan user flag
pip3 install --user -r requirements.txt
```

### Aplikasi Tidak Load Data

**Penyebab**: File YAML tidak ditemukan atau tidak dapat diakses

**Solusi**:
```bash
# Pastikan file YAML ada
ls -la personal-security-checklist.yml

# Cek koneksi internet (untuk fetch dari GitHub)
ping github.com

# Clear browser cache dan reload
```

---

## FAQ

### Q: Apakah saya perlu install Git?

**A**: Tidak wajib. Anda bisa gunakan metode instalasi via curl yang akan download archive tanpa Git. Namun, Git direkomendasikan jika Anda ingin kontribusi atau update secara berkala.

### Q: Berapa lama proses instalasi?

**A**:
- Download: 1-2 menit (tergantung internet)
- Install dependencies: 3-5 menit
- Total: Sekitar 5-10 menit

### Q: Apakah aplikasi ini gratis?

**A**: Ya, 100% gratis dan open source dengan lisensi MIT. Anda bebas menggunakan, memodifikasi, dan mendistribusikan.

### Q: Apakah data saya aman?

**A**: Ya, sangat aman. Aplikasi ini:
- Tidak menggunakan cookies
- Tidak melakukan tracking
- Data progress hanya tersimpan di browser lokal (localStorage)
- Tidak ada backend server yang menyimpan data

### Q: Bisakah saya menggunakan offline?

**A**: Setelah instalasi dan load pertama, Anda bisa menggunakan aplikasi secara offline. Namun, untuk update data checklist terbaru, koneksi internet diperlukan.

### Q: Bagaimana cara update ke versi terbaru?

**A**:
```bash
# Jika clone dengan git
cd personal-security-checklist
git pull origin master
cd web
npm install  # Update dependencies jika ada

# Jika install dengan curl, jalankan ulang script instalasi
```

### Q: Bisakah saya kontribusi?

**A**: Tentu! Lihat file `CONTRIBUTING.md` untuk panduan kontribusi. Secara singkat:
1. Fork repository
2. Edit file `personal-security-checklist.yml`
3. Submit Pull Request
4. Maintainer akan review

### Q: Aplikasi tidak jalan di Windows, kenapa?

**A**: Untuk Windows, Anda perlu menggunakan:
- **WSL (Windows Subsystem for Linux)** - Direkomendasikan
- **Git Bash** - Alternative
- **Cygwin** - Alternative

Native Windows Command Prompt mungkin tidak kompatibel dengan bash script.

### Q: Bisakah saya deploy ke hosting?

**A**: Ya! Anda bisa deploy ke:
- **Vercel** (recommended, one-click deploy)
- **Netlify**
- **GitHub Pages**
- **Cloudflare Pages**
- Server sendiri (nginx/apache)

Gunakan `npm run build.static` untuk generate static files.

### Q: Error "Cannot find module", bagaimana solusinya?

**A**:
```bash
# Hapus node_modules dan package-lock.json
rm -rf node_modules package-lock.json

# Install ulang
npm install

# Jika masih error, clear npm cache
npm cache clean --force
npm install
```

### Q: Bagaimana cara mengubah port development server?

**A**:
```bash
# Edit package.json di web/package.json
# Atau jalankan dengan flag --port
npm run dev -- --port 3000
```

### Q: Apakah ada versi mobile app?

**A**: Saat ini belum ada native mobile app. Namun, web app sudah responsive dan bisa diakses dengan baik di mobile browser. Anda juga bisa install sebagai PWA (Progressive Web App).

---

## Deployment

### Deploy ke Vercel

1. Push ke GitHub repository Anda
2. Import di Vercel dashboard
3. Set root directory ke `web`
4. Deploy!

### Deploy ke Netlify

```bash
cd web
npm run build.static

# Upload folder dist/ ke Netlify
```

### Deploy ke GitHub Pages

```bash
# Sudah ada GitHub Actions workflow
# Setiap push ke master akan auto-deploy ke GitHub Pages
```

---

## Resources

### Dokumentasi

- **README**: `/README.md` - Overview proyek
- **ANALISIS**: `/ANALISIS.md` - Analisis lengkap program
- **Contributing**: `/.github/CONTRIBUTING.md` - Panduan kontribusi
- **Code of Conduct**: `/.github/CODE_OF_CONDUCT.md`

### Links

- **Website Live**: https://digital-defense.io
- **GitHub Repo**: https://github.com/Lissy93/personal-security-checklist
- **Mirror**: https://codeberg.org/alicia/personal-security-checklist
- **Issues**: https://github.com/Lissy93/personal-security-checklist/issues
- **Discussions**: https://github.com/Lissy93/personal-security-checklist/discussions

### Community

- **Author**: [Alicia Sykes](https://github.com/Lissy93)
- **Contributors**: 40+ contributors
- **License**: MIT License

---

## Bantuan Lebih Lanjut

Jika mengalami masalah yang tidak tercakup dalam dokumentasi ini:

1. **Cek Issues**: https://github.com/Lissy93/personal-security-checklist/issues
2. **Buat Issue Baru**: Laporkan bug atau request fitur
3. **Discussions**: Tanya di GitHub Discussions
4. **Email**: Kontak maintainer jika urgent

---

**Terima kasih sudah menggunakan Personal Security Checklist!**

Jangan lupa beri ⭐ di GitHub jika project ini bermanfaat!

---

*Dokumentasi ini dibuat pada: 7 Desember 2025*
*Versi: 1.0*
