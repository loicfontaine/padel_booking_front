// lib/cubits/club_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/slot_service.dart';
import 'slot_state.dart';

class SlotCubit extends Cubit<SlotState> {
  final SlotService _SlotService;

  SlotCubit(this._SlotService) : super(SlotInitial());

  Future<void> loadSlotsByCourt(int courtId, DateTime date) async {
    emit(SlotLoading());
    try {
      final slots = await _SlotService.getAllSlotsByCourt(courtId, date);
      emit(SlotLoaded(slots));
    } catch (e) {
      emit(SlotError(e.toString()));
    }
  }
}
