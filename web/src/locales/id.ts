import type { Translation } from '~/types/i18n';

/**
 * Indonesian (Bahasa Indonesia) Translations
 */
export const id: Translation = {
  nav: {
    home: 'Beranda',
    checklist: 'Daftar Periksa',
    about: 'Tentang',
    github: 'GitHub',
  },

  hero: {
    title: 'Daftar Periksa Keamanan Personal',
    subtitle: 'Pertahanan Digital',
    description: 'Daftar lengkap tips untuk mengamankan kehidupan digital Anda',
    getStarted: 'Mulai',
    viewChecklist: 'Lihat Daftar Periksa',
  },

  priority: {
    essential: 'Penting',
    optional: 'Opsional',
    advanced: 'Lanjutan',
  },

  checklist: {
    title: 'Daftar Periksa Keamanan',
    filterByPriority: 'Filter Berdasarkan Prioritas',
    showCompleted: 'Tampilkan Selesai',
    showIgnored: 'Tampilkan Diabaikan',
    showRemaining: 'Tampilkan Tersisa',
    markComplete: 'Tandai Selesai',
    markIgnore: 'Abaikan',
    markUncomplete: 'Tandai Belum Selesai',
    itemsTotal: 'Total Item',
    itemsCompleted: 'Selesai',
    itemsRemaining: 'Tersisa',
    progress: 'Progres',
    expand: 'Perluas Semua',
    collapse: 'Ciutkan Semua',
  },

  about: {
    title: 'Tentang',
    subtitle: 'Daftar Periksa Keamanan Personal',
    description: 'Daftar periksa terkurasi berisi tips untuk melindungi keamanan digital dan privasi Anda',
    contributing: 'Berkontribusi',
    license: 'Lisensi',
    author: 'Pembuat',
  },

  footer: {
    madeBy: 'Dibuat oleh',
    license: 'Dilisensikan di bawah MIT',
    contributors: 'Kontributor',
    viewOnGitHub: 'Lihat di GitHub',
  },

  common: {
    loading: 'Memuat...',
    error: 'Kesalahan',
    retry: 'Coba Lagi',
    close: 'Tutup',
    save: 'Simpan',
    cancel: 'Batal',
    delete: 'Hapus',
    edit: 'Edit',
    search: 'Cari',
    filter: 'Filter',
    sort: 'Urutkan',
    language: 'Bahasa',
  },

  categories: {
    authentication: 'Autentikasi',
    browsing: 'Browsing Web',
    email: 'Email',
    messaging: 'Pesan Aman',
    socialMedia: 'Media Sosial',
    networking: 'Jaringan',
    mobile: 'Perangkat Mobile',
    computer: 'Komputer Personal',
    smartHome: 'Rumah Pintar',
    finance: 'Keuangan Personal',
    human: 'Aspek Manusia',
    physical: 'Keamanan Fisik',
  },

  messages: {
    noData: 'Tidak ada data tersedia',
    loadingData: 'Memuat data...',
    errorLoading: 'Gagal memuat data',
    savedSuccessfully: 'Berhasil disimpan',
    copiedToClipboard: 'Disalin ke clipboard',
  },
};
