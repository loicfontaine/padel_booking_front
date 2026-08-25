// lib/screens/clubs_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/club_cubit.dart';
import '../cubits/club_state.dart';
import '../services/club_service.dart';
import '../widgets/app_header.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClubCubit(ClubService())..loadClubs(),
      child: Scaffold(
        appBar: AppHeader(title: 'Clubs de padel'),
        body: BlocBuilder<ClubCubit, ClubState>(
          builder: (context, state) {
            if (state is ClubLoading || state is ClubInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ClubError) {
              return Center(child: Text('Erreur : ${state.message}'));
            }
            final clubs = (state as ClubLoaded).clubs;
            return ListView.builder(
              itemCount: clubs.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(clubs[index].name),
                subtitle: Text(clubs[index].address),
                trailing: Text('${clubs[index].openingTime} - ${clubs[index].closingTime}'),

              ),
            );
          },
        ),
      ),
    );
  }
}