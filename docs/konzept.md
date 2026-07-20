# Tafel Krefeld — App-Konzept

**Projekt:** Mobile App für die Gäste der Tafel Krefeld e. V.
**Stand:** Juli 2026 · **Autor:** Tobias (mit Claude)
**Leitidee:** Eine App, die den Gästen der Tafel den Weg und den Alltag leichter macht — mehrsprachig, ohne Hürden, mit allen Infos, Anmeldung und digitaler Gästekarte.

---

## 1. Ausgangslage in Krefeld

Die Tafel Krefeld e. V. (Westwall 37, 47798 Krefeld, Tel. 02151–538898) betreibt bzw. koordiniert **sechs Ausgabestellen**, die den Gästen nach Postleitzahl zugeordnet sind:

PLZ-Zuordnung verifiziert am 20.07.2026 auf tafel-krefeld.de/was-wir-tun. Die
Bereiche überschneiden sich (eine PLZ kann zu mehreren Stellen gehören):

| PLZ-Bereich | Ausgabestelle | Adresse | Ausgabezeit |
|---|---|---|---|
| 47798 | „das tägliche brot" (Kooperation) | St. Josef Kirche, Südstraße 84 | Sa ab 12:00 (Anmeldung Sa 12:45 vor Ort) |
| 47799, 47800, 47802, 47803, 47829 u. a. | Westwall | Westwall 37 | Mi + Do ab 12:00 |
| 47800, 47829 | Gartenstadt | Pius-Lukas-Kirche, Traarer Str. 380 | Di ab 12:00 |
| 47805, 47807 | Süd | Freizeitzentrum, Kölner Str. 190 | Di ab 10:30 |
| 47804, 47805, 47807 | Stahldorf | Pfarrsaal, Bonifatiusstr. 17 | Fr ab 13:00 |
| 47809 | Oppum | Jugendfreizeitzentrum, Herbertzstr. 205 | Do ab 11:00 |

Unbekannte PLZ werden in der App auf „Geschäftsstelle anrufen" (02151–538898)
geleitet. Gartenstadt und Oppum waren am 20.07.2026 nicht mit PLZ gelistet;
ihre Zuordnung stammt aus früherer Recherche und ist noch zu bestätigen.

Anmeldung neuer Gäste: Mi–Do 10:00–12:00 Uhr am Westwall 37, mit Leistungsbescheid (Jobcenter, Rente, Sozialleistung) und Ausweis. Dazu kommen die **Kindertafel Krefeld**, ein warmer Mittagstisch und weitere Angebote (Zuschüsse für Bildung, Kultur, Sport).

Die Kooperations-Ausgabestelle „das tägliche brot" zeigt, wie die Abläufe heute organisiert sind — und wo eine App ansetzen kann: Gästekarten mit Nummern, wöchentlich um 100 rotierende Startnummern, Karte wird nach 4 unentschuldigten Fehlterminen ungültig, 1 € Kostenbeitrag pro Erwachsenem, Regeln auf Arabisch, Englisch und Farsi. All das wird heute über Websites, Aushänge und Zettel kommuniziert.

**Das Kernproblem der Gäste:** Welche Ausgabestelle ist meine? Wann ist Ausgabe, und fällt sie diese Woche aus? Welche Nummer ist diese Woche zuerst dran — wann muss ich also da sein? Was muss ich zur Anmeldung/Verlängerung mitbringen? Und das alles in einer Sprache, die ich verstehe.

## 2. Was andere Tafeln bereits machen (Recherche)

**Tafel-Guide (früher „Tafel-OB", Oberhausener Tafel):** Der beste Referenzfall in Deutschland. Info-App mit Inhalten in **28 Sprachen** (zwei gleichzeitig anzeigbar — Sprechblasen zeigen Mutter- und Landessprache nebeneinander), **Ticketsystem** (Gäste sehen ihre Wartenummer vorab und müssen nicht stundenlang anstehen), **Push-Nachrichten** bei geänderten Öffnungszeiten und **Kundenkarten-Scan**. Seit 2024 als Plattform für weitere Tafeln und Vereine geöffnet. Bewertung 4,1★, aber noch sehr wenige Nutzer.

**Tafel.app (WebPX/Motus für Tafel Deutschland):** Vollständig entwickeltes System mit digitaler Registrierung, virtueller Warteschlange, QR-Check-in für Ehrenamtliche und Admin-Dashboard — wurde vom Dachverband aber **nie ausgerollt**. Interessant: der Tech-Stack (Flutter + Supabase) entspricht genau unserem CHTC-Ansatz.

**Tafel Deutschland „Tafel-App" (2019):** Im Wesentlichen nur ein Wrapper um die Website mit Tafel-Suche — kein Vorbild.

**Essener Tafel u. v. a.:** Tafel-Ausweis mit Haushaltsgröße, symbolischer Betrag (1,50 €/Erwachsener), zentrale Ausgabe + 10 Nebenstellen — alle Infos nur über die Website. Viele Tafeln kommunizieren Wochengruppen/Buchstaben nur per Aushang.

**Fazit der Recherche:** Es gibt kein etabliertes, flächendeckendes System — die meisten Tafeln arbeiten mit Website + Aushang. Die wenigen Apps zeigen aber klar, welche Funktionen tragen: Mehrsprachigkeit, Wartenummern/Tickets, Push bei Änderungen, digitale Karte. Genau daraus (plus unseren Erfahrungen aus den anderen Vereins-Apps) baut sich das Krefelder Konzept.

## 3. Zielgruppe und Designprinzipien

Die App ist **für die Gäste** der Tafel — nicht primär für Spender oder Ehrenamtliche. Das prägt alles:

1. **Mehrsprachig von Anfang an.** Deutsch, Englisch, Arabisch, Farsi, Ukrainisch, Russisch, Türkisch, Polnisch, Rumänisch, Bulgarisch als Startumfang. Alle Inhalte strukturiert übersetzbar; Sprachwahl beim ersten Start mit Flaggen/Selbstbezeichnung („العربية", „Українська").
2. **Niedrigschwellig.** Große Schrift, Icons und Piktogramme, wenig Text, Vorlesen-Funktion (Text-to-Speech) für Menschen mit Leseschwierigkeiten. Kein Login-Zwang für Infos.
3. **Läuft auf alten Geräten.** Viele Gäste haben ältere/preiswerte Android-Handys — kleine App-Größe, Android ab Version 8, sparsam mit Datenvolumen, voll offline-fähig mit letztem Stand.
4. **Würde und Datenschutz.** Kein Tracking, keine Werbung, minimale Datenerhebung. Niemand soll durch die App als „Tafel-Kunde" erkennbar werden — neutrales App-Icon und neutraler App-Name sind eine Überlegung wert (z. B. „Tafel KR" statt auffälliger Branding-Elemente auf dem Homescreen).

## 4. Funktionsumfang

### MVP (Version 1.0) — Information + Orientierung

**„Meine Ausgabestelle":** Beim ersten Start PLZ eingeben → die App zeigt die zuständige Ausgabestelle mit Adresse, Foto des Eingangs, Ausgabezeiten, Karten-Link („Route öffnen") und ÖPNV-Hinweis. Alle sechs Standorte sind auch als Liste/Karte durchsuchbar.

**Ausgabe-Ampel + Wochen-Info:** Pro Ausgabestelle der nächste Ausgabetermin („Nächste Ausgabe: Dienstag ab 10:30"), Ausfälle und Sonderöffnungen (Feiertage, Ferien) prominent als Banner. Für Stellen mit rotierenden Startnummern (das tägliche brot): **„Diese Woche startet die Ausgabe bei Nummer 400"** — die Info, die heute nur am Aushang hängt und den Gästen stundenlanges Anstehen erspart.

**Anmeldung & Verlängerung:** Schritt-für-Schritt-Erklärung in allen Sprachen: Wer ist berechtigt, welche Dokumente mitbringen (Checkliste mit Icons: Leistungsbescheid ✓, Ausweis ✓), wann und wo anmelden, was kostet die Ausgabe (Kostenbeitrag). Plus **Vor-Anmeldeformular in der App**: Name, Haushaltsgröße, PLZ, Sprache → landet als Vorgang im Admin-Backend, die Geschäftsstelle bereitet die Karte vor und der Gast muss nur noch einmal mit den Dokumenten vorbeikommen („Fast Lane" bei der Anmeldung Mi/Do).

**Push-Benachrichtigungen** (pro Ausgabestelle abonnierbar, ohne Konto — wie beim CHTC über Topics): Ausgabe fällt aus / verschoben, Startnummer der Woche, Sonderausgaben (z. B. zusätzliche Ware), Erinnerung „Morgen ist Ausgabe".

**Infobereich:** Kindertafel, Mittagstisch, weitere Hilfen (Bildung/Kultur/Sport-Zuschüsse), wichtige Anlaufstellen in Krefeld (Beratungsstellen, Kleiderkammern, Sozialamt, Jobcenter — kuratierte Liste mit Adressen), Kontakt und Öffnungszeiten der Geschäftsstelle, Regeln der Ausgabe.

**Sprachen-Feature nach Tafel-Guide-Vorbild:** Jeder Inhalt lässt sich in zwei Sprachen gleichzeitig anzeigen (eigene Sprache + Deutsch) — das hilft Gästen auch im Gespräch mit Ehrenamtlichen vor Ort.

### Ausbaustufe 2 — Digitale Gästekarte

Die Gästekarte als QR-Code in der App (Kartennummer + Haushaltsgröße, verifiziert durch die Geschäftsstelle). Dazu: **Gültigkeits-Erinnerung** („Dein Leistungsbescheid läuft ab — bitte zur Verlängerung Bescheid mitbringen"), **Abwesenheit melden** per Knopfdruck (heute muss man anrufen — und nach 4 unentschuldigten Fehlterminen verfällt die Karte!), Historie der Abholungen. Die Ehrenamtlichen scannen den QR-Code an der Ausgabe (einfache Scanner-Ansicht im Admin-Teil oder Zweit-App). Plastikkarte bleibt parallel gültig — kein Smartphone-Zwang.

### Ausbaustufe 3 — Termine & Warteschlange

Wo die Ausgabestellen mitziehen: Zeitfenster-Slots („Komm zwischen 13:00 und 13:30") statt Anstehen, oder virtuelle Warteschlange mit Live-Stand („Aktuell wird Nummer 220 aufgerufen — vor dir: 14 Haushalte"). Das ist organisatorisch der größte Eingriff und bewusst NICHT im MVP — erst wenn App-Nutzung etabliert ist.

### Denkbar später

Ehrenamts-Bereich (Schichtplan, Fahrdienst-Touren), Spenderinfos, „Was gibt es diese Woche ungefähr" (Foto der Warenlage), Feedback-Kanal, Anbindung weiterer Krefelder Hilfsangebote.

## 5. Architektur

Gleicher, bewährter Stack wie beim CHTC-Konzept — eine Codebasis, die wir über alle Vereinsprojekte wiederverwenden:

```
┌─────────────────────┐        ┌──────────────────────────────┐
│  Flutter-App        │  HTTPS │  Backend (Supabase)          │
│  iOS + Android      │◄──────►│  · PostgreSQL                │
│                     │        │  · Auto-REST-API             │
│  · Ausgabestellen   │        │  · Auth (Admins + später     │
│  · Wochen-Infos     │        │    verifizierte Gäste)       │
│  · Anmeldung        │        │  · Admin-Oberfläche          │
│  · Mehrsprachigkeit │        │    (Geschäftsstelle pflegt   │
│  · Gästekarte (V2)  │        │    Zeiten, Ausfälle, Nummern)│
└─────────┬───────────┘        └──────────────┬───────────────┘
          │                                   │
          └──────── Push ◄── Firebase Cloud Messaging (Topics je Ausgabestelle)
```

Anders als beim CHTC gibt es **keine externe Datenquelle zum Parsen** — alle Inhalte pflegt die Geschäftsstelle selbst über ein einfaches Admin-Backend (Ausfall eintragen = zwei Klicks + automatischer Push in allen Sprachen über vorübersetzte Textbausteine). Das macht das Projekt technisch sogar einfacher als die Hockey-App; die Komplexität liegt hier in Mehrsprachigkeit und Barrierefreiheit.

**Datenmodell (Kern):** `ausgabestellen` (Name, Adresse, Geo, PLZ-Zuordnung, Zeiten), `termine/ausfaelle`, `wochen_infos` (Startnummer etc.), `inhalte` (Info-Seiten, key-basiert) + `uebersetzungen` (inhalt_key, sprache, text), `voranmeldungen` (V1), `gaeste/karten` + `checkins` (erst V2, mit strenger Zugriffsbeschränkung).

**Übersetzungs-Workflow:** Inhalte werden auf Deutsch gepflegt; Erstübersetzung per KI (Claude), Prüfung durch mehrsprachige Ehrenamtliche/Gäste — bei 10 Sprachen und überschaubarer Textmenge realistisch. Push-Texte kommen aus vorübersetzten Bausteinen.

## 6. Datenschutz — hier besonders wichtig

Tafel-Gäste sind eine besonders schutzwürdige Gruppe; Daten über Bedürftigkeit sind sensibel. Deshalb: MVP komplett **ohne Nutzerkonten** (nur anonyme Push-Topics und lokal gespeicherte PLZ) → minimaler DSGVO-Aufwand, unkritischer App-Store-Review. Die Vor-Anmeldung überträgt nur das Nötigste, verschlüsselt an das Backend mit EU-Hosting (Supabase-Region Frankfurt). Für die digitale Gästekarte (V2) vorher eine kurze Datenschutz-Folgenabschätzung machen und den Kostenbeitrag/Kartenprozess mit dem Vorstand abstimmen. Kein Tracking, keine Analytics von Drittanbietern, keine Werbung — auch als Vertrauenssignal.

## 7. Roadmap

**Phase 0 — Abstimmung (1–2 Wochen):** Konzept mit der Tafel Krefeld besprechen (Geschäftsstelle + „das tägliche brot" als Kooperationspartner einbeziehen). Klären: Wer pflegt Inhalte? Welche Sprachen zuerst? Stimmen die recherchierten Zeiten/Zuständigkeiten? Interesse an Startnummern-Veröffentlichung?

**Phase 1 — Fundament (2–3 Wochen):** Supabase-Projekt, Datenmodell, Admin-Backend für Ausgabestellen/Zeiten/Ausfälle/Wochen-Infos, Inhalte erfassen und übersetzen (10 Sprachen).

**Phase 2 — App-MVP (4–6 Wochen):** Flutter-App mit PLZ-Zuordnung, Ausgabestellen, Wochen-Infos, Anmeldungs-Guide + Vor-Anmeldeformular, Infobereich, Push, Offline-Cache, Mehrsprachigkeit inkl. Zweisprachen-Anzeige. Beta-Test mit Ehrenamtlichen und einer kleinen Gäste-Gruppe (mehrsprachig!).

**Phase 3 — Launch (2–3 Wochen):** Feinschliff aus dem Beta-Feedback, Stores-Einreichung (Herausgeber: Tafel Krefeld e. V.), Aushänge mit QR-Code zum Download in allen Ausgabestellen — der wichtigste Marketing-Kanal.

**Phase 4 — Ausbau:** Digitale Gästekarte, danach ggf. Slots/Warteschlange.

## 8. Kosten

| Posten | Kosten |
|---|---|
| Apple Developer (auf den e. V. registrieren) | 99 €/Jahr — für gemeinnützige Organisationen kann Apple die Gebühr erlassen (Fee Waiver beantragen) |
| Google Play Developer | 25 € einmalig |
| Supabase (Free Tier reicht lange) | 0–25 $/Monat |
| Firebase Cloud Messaging | kostenlos |
| **Laufend im Minimalbetrieb** | **ca. 0–130 €/Jahr** |

Gute Chancen auf Förderung: Tafel Deutschland hat mit „Tafel macht Zukunft" ein Digitalisierungsprogramm; auch Stadt Krefeld, Sparkassen-Stiftungen oder lokale Unternehmen fördern so etwas erfahrungsgemäß gern — die App ist ein dankbares, sichtbares Spendenprojekt.

## 9. Risiken

Das größte Risiko ist nicht die Technik, sondern die **Pflege-Disziplin**: Die App lebt davon, dass Ausfälle und Wochen-Infos zuverlässig eingetragen werden — es braucht eine verantwortliche Person in der Geschäftsstelle und je Ausgabestelle eine Vertretung (Lösung: Eintragen so einfach wie eine WhatsApp-Nachricht machen). Zweites Risiko: **Erreichbarkeit der Zielgruppe** — nicht alle Gäste haben Smartphones; die App ergänzt Aushang und Zuruf, ersetzt sie nicht. Drittens die **Zweiteilung Tafel Krefeld / das tägliche brot**: früh klären, dass beide ihre Daten in einer App bündeln (für die Gäste ist die Trennung ohnehin unsichtbar). Der App-Store-Review ist bei einer Info-App ohne Login unkritisch.

## 10. Nächste Schritte

1. Gespräch mit der Tafel Krefeld (Geschäftsstelle, Westwall 37): Konzept vorstellen, Bedarf und Prioritäten aus deren Sicht abfragen — vielleicht brennt ihnen etwas ganz anderes unter den Nägeln (z. B. Ehrenamts-Koordination).
2. Ausgabezeiten und PLZ-Zuordnungen mit der Geschäftsstelle final bestätigen (Website-Stand vom 20.07.2026 eingearbeitet; noch offen: PLZ von Gartenstadt und Oppum, die die Website nicht ausweist).
3. Sprachbedarf klären: Welche Sprachen sprechen die Gäste in Krefeld tatsächlich am häufigsten?
4. Danach kann ich direkt loslegen: Supabase-Schema, Admin-Backend und ein klickbarer Design-Entwurf der App (wie bei Gargellen/SVK72) als Diskussionsgrundlage fürs Gespräch mit der Tafel.
