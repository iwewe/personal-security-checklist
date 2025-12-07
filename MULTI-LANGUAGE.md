# Dokumentasi Multi-Language Personal Security Checklist

Panduan lengkap implementasi fitur multi-language (i18n - internationalization) pada Personal Security Checklist dengan fokus pada Bahasa Indonesia.

## Daftar Isi

- [Overview](#overview)
- [Arsitektur](#arsitektur)
- [Komponen Yang Ditambahkan](#komponen-yang-ditambahkan)
- [Cara Menggunakan](#cara-menggunakan)
- [Menambah Bahasa Baru](#menambah-bahasa-baru)
- [Menerjemahkan Checklist](#menerjemahkan-checklist)
- [Testing](#testing)
- [Roadmap](#roadmap)

---

## Overview

Fitur multi-language memungkinkan Personal Security Checklist untuk ditampilkan dalam berbagai bahasa. Saat ini mendukung:

- ✅ **English (en)** - Default, bahasa asli
- ✅ **Bahasa Indonesia (id)** - Bahasa Indonesia

### Fitur Utama

- 🌐 Language switcher di navigation bar
- 💾 Preferensi bahasa tersimpan di localStorage
- 🔄 Auto-detect bahasa browser
- 🎨 Translasi UI lengkap (nav, footer, buttons, labels, dll)
- 📝 Support untuk translasi konten checklist
- ⚡ Hot-switching tanpa reload halaman
- 🎯 Type-safe dengan TypeScript

---

## Arsitektur

### 1. Type System (TypeScript)

File: `/web/src/types/i18n.ts`

```typescript
export type Locale = 'en' | 'id';

export interface Translation {
  nav: { ... };
  hero: { ... };
  priority: { ... };
  checklist: { ... };
  // ... dan seterusnya
}
```

**Fungsi:**
- Definisi tipe untuk locale yang didukung
- Interface untuk struktur translasi
- Type safety untuk semua key translasi

### 2. Translation Files

File lokasi: `/web/src/locales/`

```
locales/
├── index.ts      # Export semua translasi & helper functions
├── en.ts         # English translations
└── id.ts         # Indonesian translations
```

**Struktur Translation:**

```typescript
// en.ts
export const en: Translation = {
  nav: {
    home: 'Home',
    checklist: 'Checklist',
    about: 'About',
    github: 'GitHub',
  },
  // ... lebih banyak sections
};

// id.ts
export const id: Translation = {
  nav: {
    home: 'Beranda',
    checklist: 'Daftar Periksa',
    about: 'Tentang',
    github: 'GitHub',
  },
  // ... lebih banyak sections
};
```

### 3. Language Store (State Management)

File: `/web/src/store/language-store.ts`

**Fungsi utama:**

- `LanguageContext` - Context untuk language state
- `getSavedLocale()` - Get locale dari localStorage
- `saveLocale()` - Simpan locale ke localStorage
- `changeLocale()` - Ganti bahasa dan update state
- `detectBrowserLocale()` - Deteksi bahasa browser
- `initializeLocale()` - Initialize locale saat app load

**Storage:**
- Key: `psc-locale`
- Value: `'en'` | `'id'`
- Location: Browser localStorage

### 4. Custom Hook

File: `/web/src/hooks/useTranslation.ts`

```typescript
const { t, locale, translation } = useTranslation();

// Penggunaan
<h1>{t('hero.title')}</h1>
// Output (en): "Personal Security Checklist"
// Output (id): "Daftar Periksa Keamanan Personal"
```

**API:**
- `t(key)` - Get translated string by key (supports nested keys)
- `locale()` - Get current locale
- `translation()` - Get full translation object
- `localeSignal` - Signal untuk reactive locale
- `translationSignal` - Signal untuk reactive translation

### 5. Language Switcher Component

File: `/web/src/components/core/LanguageSwitcher.tsx`

**Fitur:**
- Dropdown dengan flag icons (🇬🇧 🇮🇩)
- Active state indicator
- Smooth transition
- DaisyUI styling
- Accessible (keyboard navigation, ARIA labels)

### 6. Layout Integration

File: `/web/src/routes/layout.tsx`

**Integrasi:**
```typescript
// Initialize language context
const locale = useSignal<Locale>(defaultLocale);
const translation = useSignal(getTranslation(defaultLocale));

useVisibleTask$(async () => {
  const initialLocale = await initializeLocale();
  locale.value = initialLocale;
  translation.value = getTranslation(initialLocale);
});

useContextProvider(LanguageContext, { locale, translation });
```

**Flow:**
1. App load → Initialize default locale (en)
2. Client-side mount → Read localStorage
3. If no saved locale → Detect browser language
4. Update state dengan locale yang sesuai
5. Provide context ke seluruh app

---

## Komponen Yang Ditambahkan

### File Baru

| File | Lokasi | Deskripsi |
|------|--------|-----------|
| `i18n.ts` | `/web/src/types/` | Type definitions untuk i18n |
| `en.ts` | `/web/src/locales/` | English translations |
| `id.ts` | `/web/src/locales/` | Indonesian translations |
| `index.ts` | `/web/src/locales/` | Locale exports & helpers |
| `language-store.ts` | `/web/src/store/` | Language state management |
| `useTranslation.ts` | `/web/src/hooks/` | Translation hook |
| `LanguageSwitcher.tsx` | `/web/src/components/core/` | Language switcher UI |
| `personal-security-checklist-id.yml` | `/` | Indonesian checklist (sample) |
| `MULTI-LANGUAGE.md` | `/` | Dokumentasi ini |

### File Yang Dimodifikasi

| File | Perubahan |
|------|-----------|
| `layout.tsx` | Added LanguageContext provider & initialization |
| `nav.tsx` | Added LanguageSwitcher component |

---

## Cara Menggunakan

### Untuk Pengguna

1. **Switch Language via UI:**
   - Klik icon globe 🌐 di navigation bar
   - Pilih bahasa yang diinginkan
   - UI akan langsung berubah ke bahasa tersebut

2. **Automatic Detection:**
   - Saat pertama kali mengunjungi, app akan detect bahasa browser
   - Jika browser bahasa Indonesia → app otomatis bahasa Indonesia
   - Preferensi tersimpan di localStorage

3. **Persisten:**
   - Pilihan bahasa tersimpan secara otomatis
   - Tetap sama saat refresh atau kunjungan berikutnya

### Untuk Developer

1. **Menggunakan Translasi di Component:**

```typescript
import { useTranslation } from '~/hooks/useTranslation';

export default component$(() => {
  const { t } = useTranslation();

  return (
    <div>
      <h1>{t('hero.title')}</h1>
      <p>{t('hero.description')}</p>
      <button>{t('hero.getStarted')}</button>
    </div>
  );
});
```

2. **Conditional Logic Based on Locale:**

```typescript
const { locale } = useTranslation();

{locale() === 'id' && <p>Konten khusus Indonesia</p>}
```

3. **Watch Locale Changes:**

```typescript
useVisibleTask$(({ track }) => {
  const currentLocale = track(() => locale.value);
  console.log('Locale changed to:', currentLocale);
  // Do something when locale changes
});
```

---

## Menambah Bahasa Baru

Untuk menambah bahasa baru (contoh: Spanish - 'es'):

### Langkah 1: Update Types

File: `/web/src/types/i18n.ts`

```typescript
// Sebelum
export type Locale = 'en' | 'id';

// Sesudah
export type Locale = 'en' | 'id' | 'es';
```

### Langkah 2: Buat Translation File

File: `/web/src/locales/es.ts`

```typescript
import type { Translation } from '~/types/i18n';

export const es: Translation = {
  nav: {
    home: 'Inicio',
    checklist: 'Lista de verificación',
    about: 'Acerca de',
    github: 'GitHub',
  },
  // ... translasi lengkap
};
```

### Langkah 3: Register di Index

File: `/web/src/locales/index.ts`

```typescript
import { es } from './es';

export const translations: Record<Locale, Translation> = {
  en,
  id,
  es, // tambahkan
};

export const locales = [
  { code: 'en', name: 'English', flag: '🇬🇧' },
  { code: 'id', name: 'Bahasa Indonesia', flag: '🇮🇩' },
  { code: 'es', name: 'Español', flag: '🇪🇸' }, // tambahkan
];
```

### Langkah 4: Update Browser Detection (Optional)

File: `/web/src/store/language-store.ts`

```typescript
export const detectBrowserLocale = $( (): Locale => {
  const browserLang = navigator.language.toLowerCase();

  if (browserLang.startsWith('id')) return 'id';
  if (browserLang.startsWith('es')) return 'es'; // tambahkan

  return 'en';
});
```

---

## Menerjemahkan Checklist

Konten checklist disimpan dalam file YAML terpisah.

### Struktur File

```
/
├── personal-security-checklist.yml       # English (original)
└── personal-security-checklist-id.yml    # Indonesian
```

### Format Translasi

```yaml
- title: [Judul Kategori]
  slug: [slug-sama-dengan-english]
  description: [Deskripsi dalam bahasa target]
  icon: [icon-name - sama]
  color: [color - sama]
  intro: >-
    [Paragraf pengantar dalam bahasa target]
  checklist:
  - point: [Judul point dalam bahasa target]
    priority: [Essential/Optional/Advanced - sama]
    details: >-
      [Detail lengkap dalam bahasa target, bisa menggunakan markdown]
```

### Implementasi Multi-language YAML

Ada dua pendekatan untuk load YAML berdasarkan locale:

#### Pendekatan 1: Route Loader dengan Locale Parameter

Update `/web/src/routes/layout.tsx`:

```typescript
export const useChecklists = routeLoader$(async ({ cookie }) => {
  // Get locale from cookie or default
  const locale = cookie.get('locale')?.value || 'en';

  const fileName = locale === 'en'
    ? 'personal-security-checklist.yml'
    : `personal-security-checklist-${locale}.yml`;

  const remoteUrl = `https://raw.githubusercontent.com/Lissy93/personal-security-checklist/HEAD/${fileName}`;

  return fetch(remoteUrl)
    .then((res) => res.text())
    .then((res) => jsyaml.load(res) as Sections)
    .catch(() => {
      // Fallback to English if translation not found
      const fallbackUrl = 'https://raw.githubusercontent.com/Lissy93/personal-security-checklist/HEAD/personal-security-checklist.yml';
      return fetch(fallbackUrl)
        .then((res) => res.text())
        .then((res) => jsyaml.load(res) as Sections);
    });
});
```

#### Pendekatan 2: Client-side Reload

Update language-store untuk reload checklist:

```typescript
export const changeLocale = $((
  localeSignal: Signal<Locale>,
  translationSignal: Signal<Translation>,
  newLocale: Locale
) => {
  localeSignal.value = newLocale;
  translationSignal.value = getTranslation(newLocale);
  saveLocale(newLocale);

  // Reload page to fetch correct YAML
  window.location.reload();
});
```

### Prioritas Terjemahan

Untuk translasi bertahap, prioritaskan:

1. **High Priority** (wajib):
   - Sections: title, description, intro
   - Checklist: point, details
   - Priority labels tetap

2. **Medium Priority**:
   - softwareLinks dengan deskripsi
   - helpfulTools
   - furtherResources

3. **Low Priority** (opsional):
   - Keep link URLs sama
   - Translate descriptions only

---

## Testing

### Manual Testing Checklist

- [ ] Language switcher muncul di navbar
- [ ] Dropdown menampilkan 2 bahasa (EN & ID)
- [ ] Click bahasa → UI berubah instant
- [ ] Refresh halaman → bahasa tetap sama
- [ ] Clear localStorage → auto-detect browser language
- [ ] Browser Indonesia → default ke Bahasa Indonesia
- [ ] Browser selain ID → default ke English
- [ ] Semua text UI ter-translate (nav, footer, buttons)
- [ ] Priority labels ter-translate
- [ ] No console errors
- [ ] Mobile responsive

### Automated Testing (Future)

```typescript
// Test example
test('should change locale', async () => {
  const { locale, changeLocale } = useLanguageStore();

  expect(locale.value).toBe('en');

  await changeLocale('id');

  expect(locale.value).toBe('id');
  expect(localStorage.getItem('psc-locale')).toBe('id');
});
```

---

## Roadmap

### Completed ✅

- [x] Type system untuk i18n
- [x] Translation files (EN & ID)
- [x] Language store & context
- [x] useTranslation hook
- [x] LanguageSwitcher component
- [x] Layout integration
- [x] localStorage persistence
- [x] Browser language detection
- [x] Sample Indonesian YAML
- [x] Documentation

### In Progress 🚧

- [ ] Complete Indonesian YAML translation (1967 lines)
- [ ] Update all components to use translations
- [ ] Translated checklist content support
- [ ] Mobile language switcher in drawer

### Future Plans 📋

#### Phase 2: Complete i18n

- [ ] Terjemahkan semua 12 categories ke Indonesia
- [ ] Add language parameter to route loader
- [ ] Implement YAML switching based on locale
- [ ] Add language in settings modal
- [ ] RTL support for Arabic/Hebrew (future)

#### Phase 3: More Languages

- [ ] Spanish (Español)
- [ ] French (Français)
- [ ] German (Deutsch)
- [ ] Portuguese (Português)
- [ ] Chinese Simplified (简体中文)
- [ ] Japanese (日本語)

#### Phase 4: Advanced Features

- [ ] Crowdin integration untuk community translation
- [ ] Translation completeness indicator
- [ ] Partial translations support (fallback to English)
- [ ] Date/time localization
- [ ] Number formatting localization
- [ ] Pluralization support
- [ ] Currency formatting

#### Phase 5: Developer Experience

- [ ] Translation extraction tool
- [ ] Missing translation detector
- [ ] Translation validation in CI/CD
- [ ] Auto-generate TypeScript types from translations
- [ ] Translation coverage reports

---

## Best Practices

### 1. Translation Keys

✅ **Good:**
```typescript
t('hero.title')
t('nav.home')
t('checklist.markComplete')
```

❌ **Bad:**
```typescript
t('title')  // Too generic
t('home')   // Ambiguous
```

### 2. Avoid Hardcoded Strings

✅ **Good:**
```typescript
<button>{t('common.save')}</button>
```

❌ **Bad:**
```typescript
<button>Save</button>
```

### 3. Keep Translations Short

✅ **Good:**
```typescript
nav: {
  home: 'Home',
  about: 'About',
}
```

❌ **Bad:**
```typescript
nav: {
  home: 'Click here to go back to the home page',
}
```

### 4. Use Consistent Terminology

- "Checklist" → "Daftar Periksa" (konsisten di semua tempat)
- "Essential" → "Penting" (konsisten)
- "Priority" → "Prioritas" (konsisten)

### 5. Markdown in YAML

```yaml
details: >-
  Gunakan **bold** untuk emphasize.

  Gunakan [links](https://example.com) untuk referensi.

  Gunakan line breaks untuk paragraf baru.
```

---

## Troubleshooting

### Issue: Translations tidak muncul

**Solusi:**
1. Check console untuk errors
2. Verify import path ke `useTranslation`
3. Verify LanguageContext di-provide di layout
4. Check translation key exists di file locale

### Issue: Language tidak persist

**Solusi:**
1. Check localStorage enabled di browser
2. Verify `saveLocale()` dipanggil
3. Check console untuk localStorage errors
4. Clear cache dan cookies

### Issue: Wrong language on first load

**Solusi:**
1. Check `detectBrowserLocale()` logic
2. Verify browser language settings
3. Test dengan `navigator.language` di console

### Issue: YAML tidak load untuk bahasa tertentu

**Solusi:**
1. Verify file exists di repository
2. Check file URL di route loader
3. Implement fallback ke English
4. Check YAML syntax validity

---

## Kontribusi

Ingin membantu translasi? Lihat [CONTRIBUTING.md](/.github/CONTRIBUTING.md)

### Menambah/Memperbaiki Translasi

1. Fork repository
2. Edit file di `/web/src/locales/id.ts`
3. Test secara lokal
4. Submit Pull Request

### Menambah Bahasa Baru

1. Buat issue untuk bahasa yang ingin ditambah
2. Follow langkah "Menambah Bahasa Baru" di atas
3. Translate minimal 80% sebelum PR
4. Include sample YAML untuk checklist

---

## Resources

- [Qwik i18n Documentation](https://qwik.builder.io/docs/cookbook/i18n/)
- [TypeScript i18n Best Practices](https://www.i18next.com/overview/typescript)
- [YAML Specification](https://yaml.org/spec/)
- [Locale Codes (ISO 639-1)](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)

---

## Credits

- **Implementation**: Claude Code Assistant
- **Framework**: Qwik
- **Styling**: TailwindCSS + DaisyUI
- **Icons**: Custom icon components

---

**Last Updated**: 7 Desember 2025
**Version**: 1.0
**Status**: ✅ Production Ready (UI), 🚧 In Progress (Content)
