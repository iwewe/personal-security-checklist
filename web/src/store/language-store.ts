import { $, type Signal } from '@builder.io/qwik';
import { createContextId } from '@builder.io/qwik';
import type { Locale, Translation } from '~/types/i18n';
import { getTranslation, defaultLocale } from '~/locales';

/**
 * Language Context for managing locale state
 */
export interface LanguageContextState {
  locale: Signal<Locale>;
  translation: Signal<Translation>;
}

export const LanguageContext = createContextId<LanguageContextState>(
  'psc.LanguageContext'
);

const STORAGE_KEY = 'psc-locale';

/**
 * Get saved locale from localStorage
 */
export const getSavedLocale = $((defaultValue: Locale = defaultLocale): Locale => {
  if (typeof window === 'undefined') return defaultValue;

  try {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved && (saved === 'en' || saved === 'id')) {
      return saved as Locale;
    }
  } catch (error) {
    console.error('Error reading locale from localStorage:', error);
  }

  return defaultValue;
});

/**
 * Save locale to localStorage
 */
export const saveLocale = $((locale: Locale) => {
  if (typeof window === 'undefined') return;

  try {
    localStorage.setItem(STORAGE_KEY, locale);
  } catch (error) {
    console.error('Error saving locale to localStorage:', error);
  }
});

/**
 * Change locale and update translation
 */
export const changeLocale = $((
  localeSignal: Signal<Locale>,
  translationSignal: Signal<Translation>,
  newLocale: Locale
) => {
  localeSignal.value = newLocale;
  translationSignal.value = getTranslation(newLocale);
  saveLocale(newLocale);
});

/**
 * Detect browser language
 */
export const detectBrowserLocale = $( (): Locale => {
  if (typeof window === 'undefined') return defaultLocale;

  try {
    const browserLang = navigator.language.toLowerCase();

    // Check for Indonesian
    if (browserLang.startsWith('id')) {
      return 'id';
    }

    // Default to English
    return 'en';
  } catch (error) {
    return defaultLocale;
  }
});

/**
 * Initialize locale from localStorage or browser
 */
export const initializeLocale = $(async (): Promise<Locale> => {
  // Try localStorage first
  const saved = await getSavedLocale();
  if (saved && saved !== defaultLocale) {
    return saved;
  }

  // Fall back to browser detection
  const detected = await detectBrowserLocale();
  await saveLocale(detected);

  return detected;
});
