import 'package:flutter_test/flutter_test.dart';
import 'package:tafel_krefeld/data/ausgabestellen.dart';

void main() {
  List<String> idsFuer(String plz) =>
      ausgabestellenFuerPlz(plz).map((a) => a.id).toList();

  test('PLZ-Zuordnung findet die richtige Ausgabestelle', () {
    expect(idsFuer('47809'), ['oppum']);
    expect(idsFuer('47798'), ['taegliches-brot']);
    expect(idsFuer('47804'), ['stahldorf']);
    expect(idsFuer('40210'), isEmpty); // Düsseldorf → keine Zuordnung
  });

  test('Überlappende PLZ liefern mehrere Ausgabestellen', () {
    // 47805 + 47807: Süd und Stahldorf (Stand 20.07.2026).
    expect(idsFuer('47805'), containsAll(['sued', 'stahldorf']));
    expect(idsFuer('47807'), containsAll(['sued', 'stahldorf']));
    // 47800 + 47829: Westwall und Gartenstadt.
    expect(idsFuer('47800'), containsAll(['westwall', 'gartenstadt']));
    expect(idsFuer('47829'), containsAll(['westwall', 'gartenstadt']));
  });

  test('Westwall deckt den erweiterten PLZ-Bereich ab', () {
    for (final plz in ['47799', '47800', '47802', '47803', '47829']) {
      expect(idsFuer(plz), contains('westwall'), reason: 'PLZ $plz → Westwall');
    }
  });

  test('47806 ist nicht mehr zugeordnet (nicht auf der Website)', () {
    expect(idsFuer('47806'), isEmpty);
  });

  test('naechsteAusgabe liefert den nächsten passenden Wochentag', () {
    final sued = ausgabestellen.firstWhere((a) => a.id == 'sued'); // Di 10:30
    // Montag, 20.07.2026, 09:00 → nächste Ausgabe Dienstag 21.07., 10:30
    final termin = sued.naechsteAusgabe(DateTime(2026, 7, 20, 9));
    expect(termin.weekday, DateTime.tuesday);
    expect(termin.day, 21);
    expect(termin.hour, 10);
    expect(termin.minute, 30);
  });

  test('naechsteAusgabe überspringt heute, wenn die Zeit vorbei ist', () {
    final sued = ausgabestellen.firstWhere((a) => a.id == 'sued');
    // Dienstag 21.07.2026, 11:00 (Ausgabe war 10:30) → nächster Dienstag 28.07.
    final termin = sued.naechsteAusgabe(DateTime(2026, 7, 21, 11));
    expect(termin.day, 28);
  });

  test('Westwall hat zwei Ausgabetage (Mi + Do)', () {
    final ww = ausgabestellen.firstWhere((a) => a.id == 'westwall');
    // Mittwoch 22.07.2026, 13:00 (Mi 12:00 vorbei) → Donnerstag 23.07.
    final termin = ww.naechsteAusgabe(DateTime(2026, 7, 22, 13));
    expect(termin.weekday, DateTime.thursday);
    expect(termin.day, 23);
  });
}
