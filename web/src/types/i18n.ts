/**
 * Internationalization (i18n) Types
 * Definisi tipe untuk sistem multi-bahasa
 */

export type Locale = 'en' | 'id';

export interface Translation {
  // Navigation
  nav: {
    home: string;
    checklist: string;
    about: string;
    github: string;
  };

  // Hero Section
  hero: {
    title: string;
    subtitle: string;
    description: string;
    getStarted: string;
    viewChecklist: string;
  };

  // Priority Labels
  priority: {
    essential: string;
    optional: string;
    advanced: string;
  };

  // Checklist Page
  checklist: {
    title: string;
    filterByPriority: string;
    showCompleted: string;
    showIgnored: string;
    showRemaining: string;
    markComplete: string;
    markIgnore: string;
    markUncomplete: string;
    itemsTotal: string;
    itemsCompleted: string;
    itemsRemaining: string;
    progress: string;
    expand: string;
    collapse: string;
  };

  // About Page
  about: {
    title: string;
    subtitle: string;
    description: string;
    contributing: string;
    license: string;
    author: string;
  };

  // Footer
  footer: {
    madeBy: string;
    license: string;
    contributors: string;
    viewOnGitHub: string;
  };

  // Common
  common: {
    loading: string;
    error: string;
    retry: string;
    close: string;
    save: string;
    cancel: string;
    delete: string;
    edit: string;
    search: string;
    filter: string;
    sort: string;
    language: string;
  };

  // Security Categories
  categories: {
    authentication: string;
    browsing: string;
    email: string;
    messaging: string;
    socialMedia: string;
    networking: string;
    mobile: string;
    computer: string;
    smartHome: string;
    finance: string;
    human: string;
    physical: string;
  };

  // Messages
  messages: {
    noData: string;
    loadingData: string;
    errorLoading: string;
    savedSuccessfully: string;
    copiedToClipboard: string;
  };
}

export type TranslationKey = keyof Translation;
export type NestedTranslationKey<T> = T extends object
  ? { [K in keyof T]: `${K & string}${T[K] extends object ? `.${NestedTranslationKey<T[K]> & string}` : ''}` }[keyof T]
  : never;
