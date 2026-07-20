/// Einfache eigene Mehrsprachigkeit für v0.1.
///
/// Deutsch und Englisch sind vollständig; weitere Sprachen sind angelegt und
/// fallen auf Deutsch zurück, bis die Übersetzungen (KI-Erstübersetzung +
/// Prüfung durch mehrsprachige Ehrenamtliche) eingepflegt sind.
/// Ab v0.2 kommen Übersetzungen aus dem Backend (Tabelle `uebersetzungen`).
library;

class AppLang {
  final String code;
  final String nativeName;
  final String germanName;
  final bool rtl;
  const AppLang(this.code, this.nativeName, this.germanName, {this.rtl = false});
}

const appLanguages = <AppLang>[
  AppLang('de', 'Deutsch', 'Deutsch'),
  AppLang('en', 'English', 'Englisch'),
  AppLang('ar', 'العربية', 'Arabisch', rtl: true),
  AppLang('fa', 'فارسی', 'Farsi', rtl: true),
  AppLang('uk', 'Українська', 'Ukrainisch'),
  AppLang('ru', 'Русский', 'Russisch'),
  AppLang('tr', 'Türkçe', 'Türkisch'),
  AppLang('pl', 'Polski', 'Polnisch'),
];

const _de = <String, String>{
  'app.title': 'Meine Tafel',
  'app.subtitle': 'KREFELD',
  'onboarding.welcome': 'Willkommen!',
  'onboarding.chooseLanguage': 'Wähle deine Sprache',
  'onboarding.plzLabel': 'Deine Postleitzahl in Krefeld',
  'onboarding.plzHint': 'z. B. 47805',
  'onboarding.go': 'Los geht’s',
  'onboarding.plzInvalid': 'Bitte eine 5-stellige Postleitzahl eingeben.',
  'tab.start': 'Start',
  'tab.anmeldung': 'Anmeldung',
  'tab.hilfe': 'Hilfe',
  'tab.mehr': 'Mehr',
  'start.yourStation': 'DEINE AUSGABESTELLE',
  'start.multipleStations':
      'Für deine Postleitzahl sind mehrere Ausgabestellen zuständig. '
      'Du kannst dir eine aussuchen:',
  'start.callOffice': 'Geschäftsstelle anrufen',
  'start.unknownPlz':
      'Für deine Postleitzahl haben wir keine eigene Zuordnung gefunden. '
      'Bitte ruf die Geschäftsstelle an — sie sagt dir, welche Ausgabestelle deine ist.',
  'start.nextIssue': 'Nächste Ausgabe',
  'start.route': 'Route',
  'start.call': 'Anrufen',
  'start.allStations': 'Alle Ausgabestellen',
  'start.office': 'Geschäftsstelle',
  'start.officeRegistration': 'Anmeldung neuer Gäste',
  'start.takesPlace': 'findet statt',
  'start.contribution': '1 € Kostenbeitrag pro Erwachsenem',
  'weekday.1': 'Montag',
  'weekday.2': 'Dienstag',
  'weekday.3': 'Mittwoch',
  'weekday.4': 'Donnerstag',
  'weekday.5': 'Freitag',
  'weekday.6': 'Samstag',
  'weekday.7': 'Sonntag',
  'anmeldung.title': 'So meldest du dich an',
  'anmeldung.step1': 'Dokumente einpacken',
  'anmeldung.step2': 'Zur Geschäftsstelle gehen',
  'anmeldung.step3': 'Gästekarte bekommen',
  'anmeldung.docsTitle': 'Das musst du mitbringen',
  'anmeldung.doc1': 'Leistungsbescheid (Jobcenter, Rente oder Sozialamt)',
  'anmeldung.doc2': 'Personalausweis oder Reisepass',
  'anmeldung.doc3': 'Nachweis für alle Personen in deinem Haushalt',
  'anmeldung.whenWhere': 'Wann und wo?',
  'anmeldung.note':
      'Die Gästekarte gilt für eine Ausgabestelle. Bitte sag Bescheid, wenn du '
      'einmal nicht kommen kannst — sonst kann die Karte ungültig werden.',
  'hilfe.title': 'Hilfe in Krefeld',
  'hilfe.subtitle': 'Mehr als Lebensmittel',
  'hilfe.kindertafel': 'Kindertafel',
  'hilfe.kindertafelSub': 'Frühstück, Schulsachen und Aktionen für Kinder',
  'hilfe.mittagstisch': 'Mittagstisch',
  'hilfe.mittagstischSub': 'Warmes Essen — Zeiten und Orte erfährst du bei der Tafel',
  'hilfe.kleiderkammer': 'Kleiderkammer',
  'hilfe.kleiderkammerSub': 'Kleidung günstig oder gratis',
  'hilfe.beratung': 'Beratung',
  'hilfe.beratungSub': 'Jobcenter, Sozialamt, Schuldnerberatung',
  'hilfe.sport': 'Sport & Kultur',
  'hilfe.sportSub': 'Zuschüsse für Vereine, Musik und Ausflüge',
  'hilfe.sprache': 'Sprachhilfe',
  'hilfe.spracheSub': 'Deutschkurse und Dolmetscher-Angebote',
  'mehr.title': 'Mehr',
  'mehr.language': 'Sprache',
  'mehr.plz': 'Postleitzahl ändern',
  'mehr.contact': 'Kontakt',
  'mehr.about': 'Über diese App',
  'mehr.aboutText':
      'Diese App wird ehrenamtlich für die Gäste der Tafel Krefeld e. V. entwickelt. '
      'Kein Tracking, keine Werbung. Alle Angaben ohne Gewähr — verbindlich sind '
      'die Auskünfte der Tafel Krefeld.',
  'mehr.dataNote': 'Gespeichert werden nur deine Sprache und Postleitzahl — auf deinem Gerät.',
};

const _en = <String, String>{
  'app.title': 'My Tafel',
  'app.subtitle': 'KREFELD',
  'onboarding.welcome': 'Welcome!',
  'onboarding.chooseLanguage': 'Choose your language',
  'onboarding.plzLabel': 'Your postal code in Krefeld',
  'onboarding.plzHint': 'e.g. 47805',
  'onboarding.go': 'Let’s go',
  'onboarding.plzInvalid': 'Please enter a 5-digit postal code.',
  'tab.start': 'Home',
  'tab.anmeldung': 'Register',
  'tab.hilfe': 'Help',
  'tab.mehr': 'More',
  'start.yourStation': 'YOUR DISTRIBUTION POINT',
  'start.multipleStations':
      'Several distribution points serve your postal code. '
      'You can choose one:',
  'start.callOffice': 'Call the office',
  'start.unknownPlz':
      'We could not match your postal code to a distribution point. '
      'Please call the office — they will tell you which one is yours.',
  'start.nextIssue': 'Next distribution',
  'start.route': 'Route',
  'start.call': 'Call',
  'start.allStations': 'All distribution points',
  'start.office': 'Office',
  'start.officeRegistration': 'Registration for new guests',
  'start.takesPlace': 'takes place',
  'start.contribution': '€1 contribution per adult',
  'weekday.1': 'Monday',
  'weekday.2': 'Tuesday',
  'weekday.3': 'Wednesday',
  'weekday.4': 'Thursday',
  'weekday.5': 'Friday',
  'weekday.6': 'Saturday',
  'weekday.7': 'Sunday',
  'anmeldung.title': 'How to register',
  'anmeldung.step1': 'Pack your documents',
  'anmeldung.step2': 'Go to the office',
  'anmeldung.step3': 'Receive your guest card',
  'anmeldung.docsTitle': 'What you need to bring',
  'anmeldung.doc1': 'Benefit notice (Jobcenter, pension or social welfare office)',
  'anmeldung.doc2': 'ID card or passport',
  'anmeldung.doc3': 'Proof for every person in your household',
  'anmeldung.whenWhere': 'When and where?',
  'anmeldung.note':
      'The guest card is valid for one distribution point. Please let us know '
      'if you cannot come — otherwise the card may become invalid.',
  'hilfe.title': 'Help in Krefeld',
  'hilfe.subtitle': 'More than food',
  'hilfe.kindertafel': 'Kindertafel',
  'hilfe.kindertafelSub': 'Breakfast, school supplies and activities for children',
  'hilfe.mittagstisch': 'Warm lunch',
  'hilfe.mittagstischSub': 'Ask the Tafel for times and places',
  'hilfe.kleiderkammer': 'Clothing store',
  'hilfe.kleiderkammerSub': 'Clothes cheap or free',
  'hilfe.beratung': 'Counselling',
  'hilfe.beratungSub': 'Jobcenter, social welfare office, debt counselling',
  'hilfe.sport': 'Sports & culture',
  'hilfe.sportSub': 'Subsidies for clubs, music and trips',
  'hilfe.sprache': 'Language help',
  'hilfe.spracheSub': 'German courses and interpreter services',
  'mehr.title': 'More',
  'mehr.language': 'Language',
  'mehr.plz': 'Change postal code',
  'mehr.contact': 'Contact',
  'mehr.about': 'About this app',
  'mehr.aboutText':
      'This app is developed by volunteers for the guests of Tafel Krefeld e. V. '
      'No tracking, no ads. All information without guarantee — the Tafel Krefeld '
      'office is the authoritative source.',
  'mehr.dataNote': 'Only your language and postal code are stored — on your device.',
};

const _translations = <String, Map<String, String>>{
  'de': _de,
  'en': _en,
  // ar, fa, uk, ru, tr, pl: folgen — Fallback auf Deutsch (siehe t()).
};

/// Übersetzung für [key] in Sprache [lang], Fallback Deutsch.
String t(String lang, String key) =>
    _translations[lang]?[key] ?? _de[key] ?? key;
