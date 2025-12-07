# Personal Security Checklist

<div align="center">

![Digital Defense](https://i.ibb.co/Rb6P6h6/personal-security-checklist.png)

### 🔒 Daftar Lengkap untuk Mengamankan Kehidupan Digital Anda

[![Awesome](https://awesome.re/badge.svg)](https://awesome.re)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[English](README.md) | **Bahasa Indonesia** | [Website](https://digital-defense.io)

</div>

---

## 📋 Tentang Project Ini

**Personal Security Checklist** adalah daftar periksa komprehensif yang dirancang untuk membantu Anda meningkatkan keamanan digital dan melindungi privasi online Anda. Project ini mencakup lebih dari **100+ tips keamanan praktis** yang diorganisir dalam **12 kategori** dengan tingkat prioritas yang berbeda.

### ✨ Fitur Utama

- ✅ **100+ Security Tips** - Panduan keamanan terverifikasi dan terupdate
- 🎯 **12 Kategori** - Authentication, Browsing, Email, Messaging, Social Media, Networking, Mobile, PC, Smart Home, Finance, Human, Physical
- 📊 **3 Tingkat Prioritas** - Essential, Optional, Advanced
- 🌐 **Web App Interaktif** - Browse, filter, dan track progress
- 💾 **Local Storage** - Data tersimpan lokal, tanpa tracking
- 🎨 **13 Tema** - Pilihan tema dengan DaisyUI
- 📱 **Responsive Design** - Optimal di desktop dan mobile
- 🔓 **100% Open Source** - MIT License

---

## 🚀 Quick Start

### Instalasi Cepat (One-Liner)

```bash
# Menggunakan curl
curl -fsSL https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-curl.sh | bash

# Atau menggunakan wget
wget -qO- https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-curl.sh | bash
```

### Instalasi Lengkap (dengan Auto-install Dependencies)

```bash
# Download installer
curl -fsSL https://raw.githubusercontent.com/Lissy93/personal-security-checklist/master/install-git.sh -o install-git.sh

# Jalankan installer
chmod +x install-git.sh
./install-git.sh
```

### Instalasi Manual

```bash
# Clone repository
git clone https://github.com/Lissy93/personal-security-checklist.git
cd personal-security-checklist/web

# Install dependencies
npm install

# Jalankan development server
npm run dev
```

Buka browser ke **http://localhost:5173**

---

## 📖 Dokumentasi

### Dokumentasi Bahasa Indonesia

- 📘 **[INSTALASI.md](INSTALASI.md)** - Panduan instalasi lengkap dalam Bahasa Indonesia
- 📊 **[ANALISIS.md](ANALISIS.md)** - Analisis mendalam tentang arsitektur dan fitur project

### File Penting

- `personal-security-checklist.yml` - Data sumber utama (1,967 baris)
- `CHECKLIST.md` - Checklist dalam format markdown (auto-generated)
- `install-git.sh` - Script instalasi otomatis via Git
- `install-curl.sh` - Script instalasi cepat via Curl

---

## 🛡️ Kategori Keamanan

### 1. 🔐 Authentication
- Password management
- Two-Factor Authentication (2FA)
- Biometric security
- Password managers

### 2. 🌐 Web Browsing
- Secure browsers
- Browser extensions
- Cookie management
- HTTPS enforcement

### 3. 📧 Email
- Email encryption
- Anti-phishing
- Email providers
- Email clients

### 4. 💬 Secure Messaging
- End-to-end encryption
- Secure messaging apps
- Metadata protection

### 5. 📱 Social Media
- Privacy settings
- Data sharing controls
- Account security
- Social engineering awareness

### 6. 🌍 Networking
- VPN usage
- DNS security
- Firewall configuration
- Network monitoring

### 7. 📱 Mobile Devices
- Smartphone security
- App permissions
- Mobile encryption
- Remote wipe

### 8. 💻 Personal Computers
- OS hardening
- Disk encryption
- Software updates
- Antivirus/antimalware

### 9. 🏠 Smart Home
- IoT device security
- Network segmentation
- Smart speaker privacy

### 10. 💰 Personal Finance
- Online banking security
- Cryptocurrency wallets
- Financial app security

### 11. 👤 Human Aspect
- Social engineering awareness
- Password hygiene
- Security training

### 12. 🔒 Physical Security
- Device physical security
- Screen privacy
- USB security

---

## 🎯 Tingkat Prioritas

| Prioritas | Ikon | Deskripsi |
|-----------|------|-----------|
| **Essential** | ⚫ | Langkah keamanan kritis yang wajib diterapkan |
| **Optional** | 🔵 | Praktek yang sangat direkomendasikan |
| **Advanced** | 🔴 | Untuk model ancaman tinggi (journalists, activists, dll) |

---

## 💻 Teknologi

### Frontend
- **Framework**: Qwik 1.1.4
- **Language**: TypeScript
- **Styling**: TailwindCSS + DaisyUI
- **Build**: Vite 4.0.4

### Backend/Utilities
- **Python**: 3.8+
- **Libraries**: PyYAML, requests

### DevOps
- **CI/CD**: GitHub Actions
- **Deployment**: Vercel
- **Hosting**: GitHub Pages

---

## 🔧 Development

### Menjalankan Development Server

```bash
cd web
npm run dev
```

### Build untuk Production

```bash
npm run build
```

### Build Static Files

```bash
npm run build.static
```

### Linting dan Formatting

```bash
npm run lint  # ESLint
npm run fmt   # Prettier
```

### Python Utilities

```bash
cd lib

# Generate CHECKLIST.md dari YAML
python3 generate.py

# Validasi YAML structure
python3 validate.py
```

---

## 🤝 Kontribusi

Kontribusi sangat diterima! Lihat [CONTRIBUTING.md](.github/CONTRIBUTING.md) untuk panduan lengkap.

### Cara Kontribusi

1. **Fork** repository ini
2. **Clone** fork Anda
3. **Edit** file `personal-security-checklist.yml`
4. **Commit** perubahan Anda
5. **Push** ke fork
6. **Submit** Pull Request

### Guidelines

- Pastikan YAML valid (gunakan `python3 lib/validate.py`)
- Tambahkan sumber jika menambah tips baru
- Ikuti struktur data yang ada
- Tulis commit message yang jelas

---

## 📊 Statistik Project

- ⭐ **16.8k+ GitHub Stars**
- 👥 **40+ Contributors**
- 📝 **500+ Commits**
- 🔄 **Actively Maintained**
- 📜 **MIT License**

---

## 🌐 Links

### Live Website
- 🌐 **Primary**: https://digital-defense.io
- 🔗 **Alternative**: https://personal-security-checklist.as93.net
- 🪞 **Mirror**: https://codeberg.org/alicia/personal-security-checklist

### Repository
- 💾 **GitHub**: https://github.com/Lissy93/personal-security-checklist
- 🐛 **Issues**: https://github.com/Lissy93/personal-security-checklist/issues
- 💬 **Discussions**: https://github.com/Lissy93/personal-security-checklist/discussions

---

## 🔒 Privasi & Keamanan

### Privacy-First Design

- ✅ **No Tracking** - Tidak ada analytics atau tracking
- ✅ **No Cookies** - Tidak menggunakan cookies
- ✅ **Local Storage Only** - Data tersimpan lokal di browser
- ✅ **No Backend** - Aplikasi static, tidak ada server
- ✅ **Open Source** - Kode dapat diaudit publik

### Security Best Practices

- ✅ Content Security Policy (CSP)
- ✅ HTTPS Only
- ✅ No Third-party Scripts
- ✅ Subresource Integrity (SRI)
- ✅ Regular Dependency Updates

---

## 📚 Resources Tambahan

### Artikel (dalam `/articles`)

- **Why It Matters** - Pentingnya keamanan digital
- **TLDR Short List** - Ringkasan singkat tips essential
- **Privacy-Respecting Software** - Rekomendasi software privacy-friendly
- **Privacy & Security Gadgets** - Gadget untuk meningkatkan privasi
- **Privacy & Security Links** - Kumpulan link berguna

### Tools Recommended

- **Password Managers**: Bitwarden, 1Password, KeePass
- **VPN**: Mullvad, ProtonVPN, IVPN
- **Browsers**: Firefox, Brave, Tor Browser
- **Messaging**: Signal, Element, Session
- **Email**: ProtonMail, Tutanota

---

## 👨‍💻 Author & Credits

### Maintainer
**Alicia Sykes** ([@Lissy93](https://github.com/Lissy93))

### Contributors
Terima kasih kepada 40+ contributors yang telah membantu project ini! 🙏

<a href="https://github.com/Lissy93/personal-security-checklist/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Lissy93/personal-security-checklist" />
</a>

---

## 📄 License

Project ini dilisensikan di bawah **MIT License** - lihat file [LICENSE](LICENSE) untuk detail.

```
MIT License

Copyright (c) 2025 Alicia Sykes

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files...
```

---

## ⭐ Support Project Ini

Jika project ini bermanfaat untuk Anda:

- ⭐ **Star** repository ini
- 🍴 **Fork** dan berkontribusi
- 📢 **Share** ke teman dan kolega
- 💬 **Feedback** melalui Issues atau Discussions
- ☕ **Sponsor** via GitHub Sponsors

---

## 🙏 Acknowledgments

Terima kasih kepada:

- Semua kontributor yang telah menambahkan dan memverifikasi tips keamanan
- Komunitas open source yang mendukung project ini
- Security researchers dan privacy advocates di seluruh dunia

---

## 📞 Kontak & Bantuan

- **Issues**: Laporkan bug atau request fitur
- **Discussions**: Tanya jawab dan diskusi
- **Email**: Kontak maintainer untuk pertanyaan khusus

---

<div align="center">

### 🔐 Stay Secure, Stay Private

**Made with ❤️ by the open source community**

[⬆ Back to Top](#personal-security-checklist)

</div>
