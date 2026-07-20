/// Ausgabestellen der Tafel Krefeld — Stand der Recherche Juli 2026
/// (Quelle: tafel-krefeld.de / das-taegliche-brot.de).
///
/// v0.1: lokale Daten. Ab v0.2 kommen diese Daten aus dem Supabase-Backend
/// (siehe backend/supabase), damit die Geschäftsstelle sie selbst pflegen kann.
/// VOR DEM ECHTEN EINSATZ mit der Tafel Krefeld verifizieren!
library;

class Ausgabezeit {
  /// Wochentag nach DateTime-Konvention: 1 = Montag … 7 = Sonntag.
  final int wochentag;
  final String ab; // "12:00"
  const Ausgabezeit(this.wochentag, this.ab);
}

class Ausgabestelle {
  final String id;
  final String name;
  final String ort; // Gebäude/Einrichtung
  final String strasse;
  final String plzOrt;
  final List<String> plzBereiche; // zugeordnete PLZ
  final List<Ausgabezeit> zeiten;
  final String? hinweis;

  const Ausgabestelle({
    required this.id,
    required this.name,
    required this.ort,
    required this.strasse,
    required this.plzOrt,
    required this.plzBereiche,
    required this.zeiten,
    this.hinweis,
  });

  String get adresse => '$strasse, $plzOrt';

  /// Nächster Ausgabetermin ab [von] (inkl. heute, sofern die Zeit noch nicht
  /// vorbei ist — sonst der Termin in der Folgewoche).
  DateTime naechsteAusgabe(DateTime von) {
    DateTime? best;
    final heute = DateTime(von.year, von.month, von.day);
    for (final z in zeiten) {
      final teile = z.ab.split(':');
      final stunde = int.parse(teile[0]);
      final minute = int.parse(teile[1]);
      // 8 Tage vorausschauen: Ist der Termin heute schon vorbei,
      // greift derselbe Wochentag eine Woche später (i == 7).
      for (var i = 0; i <= 7; i++) {
        final kandidat = heute.add(Duration(days: i));
        if (kandidat.weekday != z.wochentag) continue;
        final termin = DateTime(
            kandidat.year, kandidat.month, kandidat.day, stunde, minute);
        if (termin.isAfter(von) && (best == null || termin.isBefore(best))) {
          best = termin;
        }
      }
    }
    return best ?? von;
  }
}

const geschaeftsstelle = (
  name: 'Tafel Krefeld e. V. — Geschäftsstelle',
  adresse: 'Westwall 37, 47798 Krefeld',
  telefon: '02151538898',
  telefonAnzeige: '02151 – 53 88 98',
  email: 'info@tafel-krefeld.de',
  anmeldung: 'Mi + Do, 10:00 – 12:00 Uhr',
);

const ausgabestellen = <Ausgabestelle>[
  Ausgabestelle(
    id: 'westwall',
    name: 'Westwall',
    ort: 'Tafel Krefeld, Geschäftsstelle',
    strasse: 'Westwall 37',
    plzOrt: '47798 Krefeld',
    plzBereiche: ['47799'],
    zeiten: [Ausgabezeit(3, '12:00'), Ausgabezeit(4, '12:00')],
  ),
  Ausgabestelle(
    id: 'taegliches-brot',
    name: 'das tägliche brot',
    ort: 'St. Josef Kirche',
    strasse: 'Südstraße 84',
    plzOrt: '47798 Krefeld',
    plzBereiche: ['47798'],
    zeiten: [Ausgabezeit(6, '12:00')],
    hinweis: 'Kooperations-Ausgabestelle · eigene Gästekarten · Tel. 02151 602179',
  ),
  Ausgabestelle(
    id: 'gartenstadt',
    name: 'Gartenstadt',
    ort: 'Pius-Lukas-Kirche',
    strasse: 'Traarer Straße 380',
    plzOrt: '47829 Krefeld',
    plzBereiche: ['47800', '47829'],
    zeiten: [Ausgabezeit(2, '12:00')],
  ),
  Ausgabestelle(
    id: 'sued',
    name: 'Süd',
    ort: 'Freizeitzentrum Süd',
    strasse: 'Kölner Straße 190',
    plzOrt: '47805 Krefeld',
    plzBereiche: ['47805'],
    zeiten: [Ausgabezeit(2, '10:30')],
  ),
  Ausgabestelle(
    id: 'stahldorf',
    name: 'Stahldorf',
    ort: 'Pfarrsaal St. Bonifatius',
    strasse: 'Bonifatiusstraße 17',
    plzOrt: '47807 Krefeld',
    plzBereiche: ['47804', '47806', '47807'],
    zeiten: [Ausgabezeit(5, '13:00')],
  ),
  Ausgabestelle(
    id: 'oppum',
    name: 'Oppum',
    ort: 'Jugendfreizeitzentrum',
    strasse: 'Herbertzstraße 205',
    plzOrt: '47809 Krefeld',
    plzBereiche: ['47809'],
    zeiten: [Ausgabezeit(4, '11:00')],
  ),
];

/// Zuständige Ausgabestelle für eine PLZ, oder null wenn unbekannt.
Ausgabestelle? ausgabestelleFuerPlz(String plz) {
  for (final a in ausgabestellen) {
    if (a.plzBereiche.contains(plz)) return a;
  }
  return null;
}
