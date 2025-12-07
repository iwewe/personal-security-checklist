import type { Translation } from '~/types/i18n';

/**
 * English (Default) Translations
 */
export const en: Translation = {
  nav: {
    home: 'Home',
    checklist: 'Checklist',
    about: 'About',
    github: 'GitHub',
  },

  hero: {
    title: 'Personal Security Checklist',
    subtitle: 'Digital Defense',
    description: 'The ultimate list of tips to secure your digital life',
    getStarted: 'Get Started',
    viewChecklist: 'View Checklist',
  },

  priority: {
    essential: 'Essential',
    optional: 'Optional',
    advanced: 'Advanced',
  },

  checklist: {
    title: 'Security Checklist',
    filterByPriority: 'Filter by Priority',
    showCompleted: 'Show Completed',
    showIgnored: 'Show Ignored',
    showRemaining: 'Show Remaining',
    markComplete: 'Mark as Complete',
    markIgnore: 'Ignore',
    markUncomplete: 'Mark as Incomplete',
    itemsTotal: 'Total Items',
    itemsCompleted: 'Completed',
    itemsRemaining: 'Remaining',
    progress: 'Progress',
    expand: 'Expand All',
    collapse: 'Collapse All',
  },

  about: {
    title: 'About',
    subtitle: 'Personal Security Checklist',
    description: 'A curated checklist of tips for protecting your digital security and privacy',
    contributing: 'Contributing',
    license: 'License',
    author: 'Author',
  },

  footer: {
    madeBy: 'Made by',
    license: 'Licensed under MIT',
    contributors: 'Contributors',
    viewOnGitHub: 'View on GitHub',
  },

  common: {
    loading: 'Loading...',
    error: 'Error',
    retry: 'Retry',
    close: 'Close',
    save: 'Save',
    cancel: 'Cancel',
    delete: 'Delete',
    edit: 'Edit',
    search: 'Search',
    filter: 'Filter',
    sort: 'Sort',
    language: 'Language',
  },

  categories: {
    authentication: 'Authentication',
    browsing: 'Web Browsing',
    email: 'Email',
    messaging: 'Secure Messaging',
    socialMedia: 'Social Media',
    networking: 'Networking',
    mobile: 'Mobile Devices',
    computer: 'Personal Computers',
    smartHome: 'Smart Home',
    finance: 'Personal Finance',
    human: 'Human Aspect',
    physical: 'Physical Security',
  },

  messages: {
    noData: 'No data available',
    loadingData: 'Loading data...',
    errorLoading: 'Error loading data',
    savedSuccessfully: 'Saved successfully',
    copiedToClipboard: 'Copied to clipboard',
  },
};
