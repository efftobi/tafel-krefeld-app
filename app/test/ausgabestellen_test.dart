import 'package:flutter_test/flutter_test.dart';
import 'package:tafel_krefeld/data/ausgabestellen.dart';

void main() {
  test('PLZ-Zuordnung findet die richtige Ausgabestelle', () {
    expect(ausgabestelleFuerPlz('47805')!.id, 'sued');
    expect(ausgabestelleFuerPlz('47809')!.id, 'oppum');
    expect(ausgabestelleFuerPlz('47798')!.id, 'taegliches-brot');
    expect(ausgabestelleFuerPlz('40210'), isNull); // Düsseldorf → keine Zuordnung
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
