import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'cubits/auth_cubit.dart';
import 'cubits/auth_state.dart';
import 'presentation/screens/clubs_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR');
  runApp(const PadelBookingApp());
}

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
            print('AUTH STATE: ${state.runtimeType}');
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
