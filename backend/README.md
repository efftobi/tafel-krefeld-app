# Backend — Supabase

Datenbank-Schema und Seed-Daten für die Tafel-Krefeld-App.
Die App (v0.1) nutzt noch lokale Daten; ab v0.2 liest sie aus diesem Backend,
damit die Geschäftsstelle Zeiten, Ausfälle und Wochen-Infos selbst pflegen kann.

## Einrichten

1. Projekt auf [supabase.com](https://supabase.com) anlegen — **Region Frankfurt (eu-central-1)** wählen (DSGVO).
2. [Supabase CLI](https://supabase.com/docs/guides/cli) installieren und verknüpfen:

```bash
supabase login
supabase link --project-ref <PROJECT_REF>
supabase db push          # spielt migrations/ ein
psql "$DATABASE_URL" -f supabase/seed.sql   # oder über den SQL-Editor im Dashboard
```

## Struktur

- `migrations/0001_init.sql` — Tabellen + Row Level Security:
  öffentliche Inhalte anon lesbar, Schreiben nur für Admins,
  Vor-Anmeldungen anon **nur einfügbar** (nie lesbar).
- `seed.sql` — die sechs Krefelder Ausgabestellen, PLZ-Zuordnung, Ausgabezeiten
  (Recherche-Stand Juli 2026 — vor Produktivbetrieb verifizieren).

## Später (v0.2+)

- Edge Function für Push-Versand (FCM-Topics je Ausgabestelle) bei neuen
  `termin_abweichungen` / `wochen_infos`
- Admin-Oberfläche für die Geschäftsstelle (einfaches Web-Frontend)
- Übersetzungs-Workflow: Inhalte de pflegen → KI-Erstübersetzung → `geprueft`-Flag
  nach Prüfung durch Muttersprachler:innen
