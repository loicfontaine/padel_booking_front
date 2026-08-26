// lib/widgets/app_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_booking_front/cubits/auth_cubit.dart';
import 'package:padel_booking_front/cubits/auth_state.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FittedBox(child: Image(image: AssetImage('assets/logo.png'))),
      ),
      actions: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is! Authenticated) {
              return const SizedBox.shrink();
            }
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    state.email,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Déconnexion',
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                    if (context.mounted) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
