// lib/cubits/club_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/court_service.dart';
import 'court_state.dart';

class CourtCubit extends Cubit<CourtState> {
  final CourtService _courtService;

  CourtCubit(this._courtService) : super(CourtInitial());

  Future<void> loadCourts(int clubId) async {
    emit(CourtLoading());
    try {
      final clubs = await _courtService.getAllCourtsByClub(clubId);
      emit(CourtLoaded(clubs));
    } catch (e) {
      emit(CourtError(e.toString()));
    }
  }
}