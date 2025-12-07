import type { Locale, Translation } from '~/types/i18n';
import { en } from './en';
import { id } from './id';

/**
 * Available translations
 */
export const translations: Record<Locale, Translation> = {
  en,
  id,
};

/**
 * Default locale
 */
export const defaultLocale: Locale = 'en';

/**
 * Available locales with their display names
 */
export const locales: { code: Locale; name: string; flag: string }[] = [
  { code: 'en', name: 'English', flag: '🇬🇧' },
  { code: 'id', name: 'Bahasa Indonesia', flag: '🇮🇩' },
];

/**
 * Get translation by locale
 */
export function getTranslation(locale: Locale): Translation {
  return translations[locale] || translations[defaultLocale];
}

/**
 * Helper function to get nested translation value
 */
export function getNestedValue(obj: any, path: string): string {
  return path.split('.').reduce((prev, curr) => prev?.[curr], obj) || path;
}
