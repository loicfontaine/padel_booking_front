import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/club_service.dart';
import 'club_state.dart';

class ClubCubit extends Cubit<ClubState> {
  final ClubService _clubService;

  ClubCubit(this._clubService) : super(ClubInitial());

  Future<void> loadClubs() async {
    emit(ClubLoading());
    try {
      final clubs = await _clubService.getAllClubs();
      emit(ClubLoaded(clubs));
    } catch (e) {
      emit(ClubError(e.toString()));
    }
  }
}
