-- Seed: Ausgabestellen der Tafel Krefeld — Recherche-Stand Juli 2026
-- (Quellen: tafel-krefeld.de, das-taegliche-brot.de)
-- VOR PRODUKTIVBETRIEB mit der Tafel Krefeld verifizieren!

insert into ausgabestellen (id, name, ort, strasse, plz, traeger, telefon, hinweis, sortierung) values
  ('westwall',        'Westwall',          'Tafel Krefeld, Geschäftsstelle', 'Westwall 37',        '47798', 'Tafel Krefeld e.V.', '02151538898', null, 1),
  ('taegliches-brot', 'das tägliche brot', 'St. Josef Kirche',               'Südstraße 84',       '47798', 'das tägliche brot (Kooperation)', '02151602179', 'Eigene Gästekarten · Anmeldung samstags 12:45 Uhr vor Ort (nicht über die Geschäftsstelle)', 2),
  ('gartenstadt',     'Gartenstadt',       'Pius-Lukas-Kirche',              'Traarer Straße 380', '47829', 'Tafel Krefeld e.V.', null, null, 3),
  ('sued',            'Süd',               'Freizeitzentrum Süd',            'Kölner Straße 190',  '47805', 'Tafel Krefeld e.V.', null, null, 4),
  ('stahldorf',       'Stahldorf',         'Pfarrsaal St. Bonifatius',       'Bonifatiusstraße 17','47807', 'Tafel Krefeld e.V.', null, null, 5),
  ('oppum',           'Oppum',             'Jugendfreizeitzentrum',          'Herbertzstraße 205', '47809', 'Tafel Krefeld e.V.', null, null, 6);

-- PLZ -> Ausgabestelle. Bereiche überschneiden sich (mehrfach-Zuordnung).
-- Verifiziert am 20.07.2026 auf tafel-krefeld.de/was-wir-tun.
-- Westwall führt laut Website zusätzlich "und weitere" PLZ (nicht abschließend).
-- Gartenstadt/Oppum wurden am 20.07.2026 nicht mit PLZ aufgeführt; bisherige
-- Recherche belassen (47800/47829 überschneiden sich dadurch mit Westwall).
-- 47806 stand nicht auf der Website und wurde entfernt.
insert into plz_zuordnung (plz, ausgabestelle_id) values
  ('47799', 'westwall'),
  ('47800', 'westwall'),
  ('47802', 'westwall'),
  ('47803', 'westwall'),
  ('47829', 'westwall'),
  ('47798', 'taegliches-brot'),
  ('47800', 'gartenstadt'),
  ('47829', 'gartenstadt'),
  ('47805', 'sued'),
  ('47807', 'sued'),
  ('47804', 'stahldorf'),
  ('47805', 'stahldorf'),
  ('47807', 'stahldorf'),
  ('47809', 'oppum');

insert into ausgabezeiten (ausgabestelle_id, wochentag, zeit_ab) values
  ('westwall',        3, '12:00'),  -- Mittwoch
  ('westwall',        4, '12:00'),  -- Donnerstag
  ('taegliches-brot', 6, '12:00'),  -- Samstag
  ('gartenstadt',     2, '12:00'),  -- Dienstag
  ('sued',            2, '10:30'),  -- Dienstag
  ('stahldorf',       5, '13:00'),  -- Freitag
  ('oppum',           4, '11:00');  -- Donnerstag
