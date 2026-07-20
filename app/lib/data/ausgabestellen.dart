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
  // PLZ-Zuordnung verifiziert am 20.07.2026 auf tafel-krefeld.de/was-wir-tun.
  // Die Bereiche überschneiden sich (eine PLZ kann zu mehreren Stellen gehören)
  // — deshalb liefert ausgabestellenFuerPlz() eine Liste. Die Website nennt für
  // Westwall zusätzlich „und weitere" PLZ; die Liste ist also nicht
  // abschließend. Unbekannte PLZ → Hinweis „Geschäftsstelle anrufen".
  Ausgabestelle(
    id: 'westwall',
    name: 'Westwall',
    ort: 'Tafel Krefeld, Geschäftsstelle',
    strasse: 'Westwall 37',
    plzOrt: '47798 Krefeld',
    // Laut Website: 47799, 47800, 47802, 47803, 47829 „und weitere".
    plzBereiche: ['47799', '47800', '47802', '47803', '47829'],
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
    hinweis: 'Kooperations-Ausgabestelle · eigene Gästekarten · '
        'Anmeldung samstags 12:45 Uhr vor Ort (nicht über die Geschäftsstelle) · '
        'Tel. 02151 602179',
  ),
  Ausgabestelle(
    id: 'gartenstadt',
    name: 'Gartenstadt',
    ort: 'Pius-Lukas-Kirche',
    strasse: 'Traarer Straße 380',
    plzOrt: '47829 Krefeld',
    // Nicht Teil der Verifikation vom 20.07.2026 (Website führte Gartenstadt
    // dort nicht mit PLZ auf). Bisherige Recherche belassen; 47800/47829
    // überschneiden sich dadurch mit Westwall. Bei nächster Prüfung bestätigen.
    plzBereiche: ['47800', '47829'],
    zeiten: [Ausgabezeit(2, '12:00')],
  ),
  Ausgabestelle(
    id: 'sued',
    name: 'Süd',
    ort: 'Freizeitzentrum Süd',
    strasse: 'Kölner Straße 190',
    plzOrt: '47805 Krefeld',
    plzBereiche: ['47805', '47807'],
    zeiten: [Ausgabezeit(2, '10:30')],
  ),
  Ausgabestelle(
    id: 'stahldorf',
    name: 'Stahldorf',
    ort: 'Pfarrsaal St. Bonifatius',
    strasse: 'Bonifatiusstraße 17',
    plzOrt: '47807 Krefeld',
    // 47806 stand am 20.07.2026 nicht auf der Website → entfernt. 47805/47807
    // überschneiden sich mit Süd.
    plzBereiche: ['47804', '47805', '47807'],
    zeiten: [Ausgabezeit(5, '13:00')],
  ),
  Ausgabestelle(
    id: 'oppum',
    name: 'Oppum',
    ort: 'Jugendfreizeitzentrum',
    strasse: 'Herbertzstraße 205',
    plzOrt: '47809 Krefeld',
    // Nicht Teil der Verifikation vom 20.07.2026; bisherige Recherche belassen.
    plzBereiche: ['47809'],
    zeiten: [Ausgabezeit(4, '11:00')],
  ),
];

/// Alle für eine PLZ zuständigen Ausgabestellen (in Anzeige-Reihenfolge).
///
/// Bereiche überschneiden sich, daher können es mehrere sein. Ist die Liste
/// leer, ist die PLZ unbekannt → in der UI auf „Geschäftsstelle anrufen"
/// ($geschaeftsstelle.telefonAnzeige) hinweisen.
List<Ausgabestelle> ausgabestellenFuerPlz(String plz) =>
    [for (final a in ausgabestellen) if (a.plzBereiche.contains(plz)) a];
