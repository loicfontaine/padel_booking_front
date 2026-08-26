// lib/cubits/club_state.dart
import 'package:equatable/equatable.dart';

import '../models/slot.dart';

abstract class SlotState extends Equatable {
  const SlotState();

  @override
  List<Object?> get props => [];
}

class SlotInitial extends SlotState {}

class SlotLoading extends SlotState {}

class SlotLoaded extends SlotState {
  final List<Slot> slots;

  const SlotLoaded(this.slots);

  @override
  List<Object?> get props => [slots];
}

class SlotError extends SlotState {
  final String message;

  const SlotError(this.message);

  @override
  List<Object?> get props => [message];
}
