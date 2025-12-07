import { component$, $ } from '@builder.io/qwik';
import { useTranslation } from '~/hooks/useTranslation';
import { changeLocale } from '~/store/language-store';
import { locales } from '~/locales';
import type { Locale } from '~/types/i18n';

/**
 * Language Switcher Component
 * Displays a dropdown to switch between available languages
 */
export default component$(() => {
  const { t, locale, localeSignal, translationSignal } = useTranslation();

  const handleLocaleChange = $((newLocale: Locale) => {
    changeLocale(localeSignal, translationSignal, newLocale);
  });

  return (
    <div class="dropdown dropdown-end">
      <label tabIndex={0} class="btn btn-ghost btn-sm gap-2">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-5 w-5"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M3 5h12M9 3v2m1.048 9.5A18.022 18.022 0 016.412 9m6.088 9h7M11 21l5-10 5 10M12.751 5C11.783 10.77 8.07 15.61 3 18.129"
          />
        </svg>
        <span class="hidden sm:inline">{t('common.language')}</span>
      </label>
      <ul
        tabIndex={0}
        class="dropdown-content menu p-2 shadow-lg bg-base-200 rounded-box w-52 mt-3"
      >
        {locales.map((loc) => (
          <li key={loc.code}>
            <button
              onClick$={() => handleLocaleChange(loc.code)}
              class={[
                'flex items-center gap-3',
                locale() === loc.code && 'active bg-primary text-primary-content',
              ]}
            >
              <span class="text-2xl">{loc.flag}</span>
              <span class="flex-1">{loc.name}</span>
              {locale() === loc.code && (
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-5 w-5"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                >
                  <path
                    fill-rule="evenodd"
                    d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                    clip-rule="evenodd"
                  />
                </svg>
              )}
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
});
