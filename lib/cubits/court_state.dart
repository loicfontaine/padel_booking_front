// lib/cubits/club_state.dart
import 'package:equatable/equatable.dart';

import '../models/court.dart';

abstract class CourtState extends Equatable {
  const CourtState();

  @override
  List<Object?> get props => [];
}

class CourtInitial extends CourtState {}

class CourtLoading extends CourtState {}

class CourtLoaded extends CourtState {
  final List<Court> courts;

  const CourtLoaded(this.courts);

  @override
  List<Object?> get props => [courts];
}

class CourtError extends CourtState {
  final String message;

  const CourtError(this.message);

  @override
  List<Object?> get props => [message];
}
