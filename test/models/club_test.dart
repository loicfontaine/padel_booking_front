import 'package:flutter_test/flutter_test.dart';
import 'package:padel_booking_front/models/club.dart';

void main() {
  group('Club.fromJson', () {
    test('crée un club à partir de la réponse de l’API', () {
      final club = Club.fromJson({
        'id': 1,
        'name': 'Padel Lausanne',
        'address': 'Rue du Sport 12, Lausanne',
        'openingTime': '08:00',
        'closingTime': '22:00',
      });

      expect(club.id, 1);
      expect(club.name, 'Padel Lausanne');
      expect(club.address, 'Rue du Sport 12, Lausanne');
      expect(club.openingTime, '08:00');
      expect(club.closingTime, '22:00');
    });
  });
}
