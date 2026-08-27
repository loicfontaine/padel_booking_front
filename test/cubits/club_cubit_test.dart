import 'package:flutter_test/flutter_test.dart';
import 'package:padel_booking_front/cubits/club_cubit.dart';
import 'package:padel_booking_front/cubits/club_state.dart';
import 'package:padel_booking_front/models/club.dart';
import 'package:padel_booking_front/services/club_service.dart';

class FakeClubService extends ClubService {
  @override
  Future<List<Club>> getAllClubs() async {
    return [
      Club(
        id: 1,
        name: 'Padel Lausanne',
        address: 'Rue du Sport 12, Lausanne',
        openingTime: '08:00',
        closingTime: '22:00',
      ),
    ];
  }
}

void main() {
  group('ClubCubit', () {
    test(
      'émet ClubLoading puis ClubLoaded lorsque le chargement réussit',
      () async {
        final cubit = ClubCubit(FakeClubService());
        final states = <ClubState>[];
        final subscription = cubit.stream.listen(states.add);

        await cubit.loadClubs();
        await Future<void>.delayed(Duration.zero);

        expect(states, hasLength(2));
        expect(states.first, isA<ClubLoading>());

        final loadedState = states.last as ClubLoaded;
        expect(loadedState.clubs, hasLength(1));
        expect(loadedState.clubs.single.name, 'Padel Lausanne');

        await subscription.cancel();
        await cubit.close();
      },
    );
  });
}
