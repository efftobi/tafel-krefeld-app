# Meine Tafel — App für die Tafel Krefeld

Mobile App für die **Gäste der Tafel Krefeld e. V.** — mehrsprachig, ohne Hürden, mit allen
Infos rund um Ausgabestellen, Ausgabezeiten, Anmeldung und weitere Hilfsangebote in Krefeld.

> 🌐 **Im Browser öffnen:** <https://efftobi.github.io/tafel-krefeld-app/>
> Die Web-Version läuft direkt im Browser (auch auf dem iPhone in Safari) und lässt sich
> über „Teilen → Zum Home-Bildschirm" wie eine echte App installieren. Sie wird bei jedem
> Push auf `main` automatisch über GitHub Actions neu gebaut und veröffentlicht.

> Status: **v0.1 — erste lauffähige Version** (MVP-Screens mit lokalen Beispieldaten,
> noch ohne Backend-Anbindung). Konzept siehe [`docs/konzept.md`](docs/konzept.md),
> Design-Mockup siehe [`docs/design-mockup.html`](docs/design-mockup.html).

## Struktur (Monorepo)

```
tafel-krefeld-app/
├── app/       Flutter-App (iOS + Android, eine Codebasis)
├── backend/   Supabase: Datenbank-Schema, Seed-Daten (später: Edge Functions, Admin)
└── docs/      Konzept und Design-Entwurf
```

## App starten (Entwicklung)

Voraussetzung: [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable, ≥ 3.22).

```bash
cd app
flutter create . --platforms=android,ios --project-name tafel_krefeld  # erzeugt android/ + ios/ (einmalig)
flutter pub get
flutter run
```

Die mobilen Plattform-Ordner (`android/`, `ios/`) sind bewusst nicht eingecheckt — sie werden
mit `flutter create .` generiert. Eingecheckt sind der eigentliche App-Code (`lib/`, `pubspec.yaml`)
sowie der angepasste `web/`-Ordner (Titel, Manifest, Icons, Theme-Farbe für die Web-/PWA-Version).

## Web-Version & Deployment (GitHub Pages)

Die App läuft auch als Web-App und wird automatisch nach GitHub Pages deployt:
<https://efftobi.github.io/tafel-krefeld-app/>.

Lokal bauen bzw. ausführen:

```bash
cd app
flutter run -d chrome                                   # lokal im Browser testen
flutter build web --release --base-href /tafel-krefeld-app/   # Produktions-Build (wie in der CI)
```

Der Workflow [`.github/workflows/deploy-web.yml`](.github/workflows/deploy-web.yml) baut bei
jedem Push auf `main` die Web-Version (`flutter analyze`, `flutter test`, `flutter build web`)
und veröffentlicht sie über GitHub Pages.

> **Einmalige Einrichtung:** Unter **Settings → Pages → Source** muss **GitHub Actions**
> ausgewählt sein. Der Workflow versucht dies über `actions/configure-pages` (`enablement: true`)
> automatisch zu aktivieren; klappt das aufgrund der Repo-Berechtigungen nicht, genügt dieser
> eine Klick in den Einstellungen.

## Was v0.1 kann

- **Erster Start:** Sprachwahl (Deutsch/Englisch vollständig, weitere Sprachen vorbereitet) + PLZ-Eingabe
- **Start:** „Deine Ausgabestelle" anhand der PLZ, nächster Ausgabetermin (berechnet), Route öffnen, alle sechs Ausgabestellen im Überblick
- **Anmeldung:** Schritt-für-Schritt-Anleitung mit Dokumenten-Checkliste
- **Hilfe:** Kindertafel, Mittagstisch und weitere Anlaufstellen in Krefeld
- **Mehr:** Sprache/PLZ ändern, Kontakt zur Geschäftsstelle

Alle Ausgabestellen-Daten liegen in v0.1 lokal in
[`app/lib/data/ausgabestellen.dart`](app/lib/data/ausgabestellen.dart) und entsprechen dem
Recherche-Stand Juli 2026 (Quelle: tafel-krefeld.de). **Vor dem ersten echten Einsatz mit der
Tafel Krefeld verifizieren!**

## Roadmap (aus dem Konzept)

1. **v0.1** — dieses Grundgerüst ✅
2. **v0.2** — Supabase-Anbindung (Ausgabestellen, Ausfälle, Wochen-Infos aus der Datenbank), Admin-Backend
3. **v0.3** — Push-Benachrichtigungen (FCM-Topics je Ausgabestelle), weitere Sprachen inkl. RTL (Arabisch, Farsi)
4. **v1.0** — Beta-Test mit der Tafel, Store-Launch
5. **v2.x** — digitale Gästekarte (QR), Abwesenheit melden, Bescheid-Erinnerung

## Backend

`backend/supabase/migrations/0001_init.sql` enthält das komplette Datenbank-Schema
(Ausgabestellen, Ausfälle/Sondertermine, Wochen-Infos, mehrsprachige Inhalte, Vor-Anmeldungen),
`seed.sql` die sechs Krefelder Ausgabestellen. Einspielen mit der
[Supabase CLI](https://supabase.com/docs/guides/cli): `supabase db push`.

## Datenschutz-Grundsätze

Kein Tracking, keine Analytics, keine Werbung, keine Nutzerkonten im MVP.
Lokal gespeichert werden nur Sprachwahl und PLZ (auf dem Gerät, `shared_preferences`).

## Lizenz

MIT — siehe [LICENSE](LICENSE).
