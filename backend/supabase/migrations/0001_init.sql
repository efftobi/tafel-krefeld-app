-- Tafel Krefeld App — Datenbank-Schema v1
-- Supabase / PostgreSQL. Einspielen: `supabase db push`
--
-- Grundsatz: Alle App-Inhalte sind öffentlich lesbar (anon SELECT),
-- Schreiben nur für authentifizierte Admins. Die einzige Ausnahme sind
-- Vor-Anmeldungen: anon darf einfügen (Formular), aber nie lesen.

-- ============================================================
-- Ausgabestellen
-- ============================================================
create table ausgabestellen (
  id          text primary key,               -- 'sued', 'oppum', ...
  name        text not null,
  ort         text not null,                  -- Gebäude/Einrichtung
  strasse     text not null,
  plz         text not null,
  stadt       text not null default 'Krefeld',
  lat         double precision,
  lng         double precision,
  telefon     text,
  hinweis     text,
  traeger     text not null default 'Tafel Krefeld e.V.',  -- oder Kooperationspartner
  sortierung  int  not null default 0,
  aktiv       boolean not null default true
);

-- Zuordnung PLZ -> Ausgabestelle (eine PLZ kann mehrfach vorkommen,
-- falls sich Zuständigkeiten überlappen; App zeigt dann beide).
create table plz_zuordnung (
  plz              text not null,
  ausgabestelle_id text not null references ausgabestellen (id) on delete cascade,
  primary key (plz, ausgabestelle_id)
);

-- Regelmäßige Ausgabezeiten
create table ausgabezeiten (
  id               bigint generated always as identity primary key,
  ausgabestelle_id text not null references ausgabestellen (id) on delete cascade,
  wochentag        int  not null check (wochentag between 1 and 7),  -- 1 = Montag
  zeit_ab          time not null,
  zeit_bis         time,
  anmerkung        text
);

-- Abweichungen vom Regelbetrieb: Ausfall, Verlegung, Sondertermin
create table termin_abweichungen (
  id               bigint generated always as identity primary key,
  ausgabestelle_id text not null references ausgabestellen (id) on delete cascade,
  datum            date not null,
  typ              text not null check (typ in ('ausfall', 'verlegt', 'sondertermin')),
  ersatz_datum     date,
  ersatz_zeit_ab   time,
  beschreibung     text,                      -- de; Übersetzungen s. uebersetzungen
  erstellt_am      timestamptz not null default now()
);

-- Wochen-Infos je Ausgabestelle (z. B. Startnummer der Woche)
create table wochen_infos (
  id               bigint generated always as identity primary key,
  ausgabestelle_id text not null references ausgabestellen (id) on delete cascade,
  woche_ab         date not null,             -- Montag der Woche
  startnummer      int,
  info             text,
  unique (ausgabestelle_id, woche_ab)
);

-- ============================================================
-- Mehrsprachige Inhalte (Info-Seiten, Regeln, Hilfe-Einträge)
-- ============================================================
create table inhalte (
  key         text primary key,               -- 'regeln', 'hilfe.kindertafel', ...
  bereich     text not null,                  -- 'info' | 'hilfe' | 'anmeldung' | 'push_vorlage'
  sortierung  int not null default 0,
  aktiv       boolean not null default true
);

create table uebersetzungen (
  inhalt_key  text not null references inhalte (key) on delete cascade,
  sprache     text not null,                  -- 'de', 'en', 'ar', 'fa', 'uk', 'ru', 'tr', 'pl'
  titel       text,
  text        text not null,
  geprueft    boolean not null default false, -- von Muttersprachler:in geprüft?
  primary key (inhalt_key, sprache)
);

-- ============================================================
-- Vor-Anmeldungen aus der App (Datensparsamkeit!)
-- ============================================================
create table voranmeldungen (
  id               uuid primary key default gen_random_uuid(),
  name             text not null,
  telefon          text,
  plz              text not null,
  haushalt_personen int not null check (haushalt_personen between 1 and 20),
  sprache          text not null default 'de',
  status           text not null default 'neu'
                   check (status in ('neu', 'in_bearbeitung', 'erledigt')),
  erstellt_am      timestamptz not null default now()
);

-- ============================================================
-- Row Level Security
-- ============================================================
alter table ausgabestellen      enable row level security;
alter table plz_zuordnung       enable row level security;
alter table ausgabezeiten       enable row level security;
alter table termin_abweichungen enable row level security;
alter table wochen_infos        enable row level security;
alter table inhalte             enable row level security;
alter table uebersetzungen      enable row level security;
alter table voranmeldungen      enable row level security;

-- Öffentlich lesbar
create policy "public read" on ausgabestellen      for select using (true);
create policy "public read" on plz_zuordnung       for select using (true);
create policy "public read" on ausgabezeiten       for select using (true);
create policy "public read" on termin_abweichungen for select using (true);
create policy "public read" on wochen_infos        for select using (true);
create policy "public read" on inhalte             for select using (true);
create policy "public read" on uebersetzungen      for select using (true);

-- Vor-Anmeldung: App darf nur einfügen, niemals lesen
create policy "anon insert" on voranmeldungen for insert with check (true);

-- Schreiben überall nur für angemeldete Admins (Supabase Auth)
create policy "admin write" on ausgabestellen      for all to authenticated using (true) with check (true);
create policy "admin write" on plz_zuordnung       for all to authenticated using (true) with check (true);
create policy "admin write" on ausgabezeiten       for all to authenticated using (true) with check (true);
create policy "admin write" on termin_abweichungen for all to authenticated using (true) with check (true);
create policy "admin write" on wochen_infos        for all to authenticated using (true) with check (true);
create policy "admin write" on inhalte             for all to authenticated using (true) with check (true);
create policy "admin write" on uebersetzungen      for all to authenticated using (true) with check (true);
create policy "admin read voranmeldungen" on voranmeldungen for select to authenticated using (true);
create policy "admin update voranmeldungen" on voranmeldungen for update to authenticated using (true) with check (true);
