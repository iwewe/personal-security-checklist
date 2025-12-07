import { useContext } from '@builder.io/qwik';
import { LanguageContext } from '~/store/language-store';
import type { Locale, Translation } from '~/types/i18n';
import { getNestedValue } from '~/locales';

/**
 * Hook to access translation and locale
 */
export const useTranslation = () => {
  const context = useContext(LanguageContext);

  /**
   * Get translated string by key
   * Supports nested keys like "nav.home"
   */
  const t = (key: string): string => {
    return getNestedValue(context.translation.value, key);
  };

  /**
   * Get current locale
   */
  const locale = (): Locale => {
    return context.locale.value;
  };

  /**
   * Get full translation object
   */
  const translation = (): Translation => {
    return context.translation.value;
  };

  return {
    t,
    locale,
    translation,
    localeSignal: context.locale,
    translationSignal: context.translation,
  };
};
