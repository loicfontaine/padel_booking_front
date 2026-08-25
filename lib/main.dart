// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/auth_cubit.dart';
import 'cubits/auth_state.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';
import 'screens/clubs_screen.dart';

void main() => runApp(const PadelBookingApp());

class PadelBookingApp extends StatelessWidget {
  const PadelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthService())..checkAuthStatus(),
      child: MaterialApp(
        title: 'Padel Booking',
        theme: ThemeData(primarySwatch: Colors.green),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial || state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is Authenticated) {
              return const ClubsScreen();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}