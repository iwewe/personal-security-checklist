import { component$, useContextProvider, Slot, useSignal, useVisibleTask$ } from "@builder.io/qwik";
import { routeLoader$, type RequestHandler } from "@builder.io/qwik-city";
import jsyaml from "js-yaml";

import Navbar from "~/components/furniture/nav";
import Footer from "~/components/furniture/footer";
import { ChecklistContext } from "~/store/checklist-context";
import { LanguageContext, initializeLocale } from "~/store/language-store";
import { getTranslation, defaultLocale } from "~/locales";
import type { Sections } from "~/types/PSC";
import type { Locale } from "~/types/i18n";

export const useChecklists = routeLoader$(async () => {
  const remoteUrl = 'https://raw.githubusercontent.com/Lissy93/personal-security-checklist/HEAD/personal-security-checklist.yml';
  return fetch(remoteUrl)
    .then((res) => res.text())
    .then((res) => jsyaml.load(res) as Sections)
    .catch(() => []);
});

export const onGet: RequestHandler = async ({ cacheControl }) => {
  cacheControl({
    staleWhileRevalidate: 60 * 60 * 24 * 7,
    maxAge: 5,
  });
};

export default component$(() => {
  const checklists = useChecklists();
  useContextProvider(ChecklistContext, checklists);

  // Initialize language
  const locale = useSignal<Locale>(defaultLocale);
  const translation = useSignal(getTranslation(defaultLocale));

  // Initialize locale from localStorage or browser on client-side
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  useVisibleTask$(async ({ track }) => {
    track(() => locale.value);
    const initialLocale = await initializeLocale();
    if (initialLocale !== locale.value) {
      locale.value = initialLocale;
      translation.value = getTranslation(initialLocale);
    }
  });

  useContextProvider(LanguageContext, { locale, translation });

  return (
    <>
      <Navbar />
      <main class="bg-base-100 min-h-full">
        <Slot />
      </main>
      <Footer />
    </>
  );
});
