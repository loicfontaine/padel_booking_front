import 'package:equatable/equatable.dart';

import '../models/club.dart';

abstract class ClubState extends Equatable {
  const ClubState();

  @override
  List<Object?> get props => [];
}

class ClubInitial extends ClubState {}

class ClubLoading extends ClubState {}

class ClubLoaded extends ClubState {
  final List<Club> clubs;

  const ClubLoaded(this.clubs);

  @override
  List<Object?> get props => [clubs];
}

class ClubError extends ClubState {
  final String message;

  const ClubError(this.message);

  @override
  List<Object?> get props => [message];
}
