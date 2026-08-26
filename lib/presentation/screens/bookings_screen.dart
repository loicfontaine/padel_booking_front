import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_booking_front/cubits/booking_cubit.dart';
import 'package:padel_booking_front/cubits/booking_state.dart';
import 'package:padel_booking_front/models/booking.dart';

import '../../services/booking_service.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(BookingService())..loadUserBookings(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Mes réservations')),
        body: BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BookingError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      'Une erreur est survenue',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<BookingCubit>().loadUserBookings();
                      },
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              );
            }

            if (state is BookingLoaded) {
              if (state.bookings.isEmpty) {
                return const Center(
                  child: Text('Vous n\'avez aucune réservation.'),
                );
              }

              return RefreshIndicator(
                onRefresh: () {
                  return context.read<BookingCubit>().loadUserBookings();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = state.bookings[index];

                    return _BookingCard(booking: booking);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Booking booking;

  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final slot = booking.slot;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.sports_tennis, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Réservation',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _StatusChip(status: booking.status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Text(_formatDate(slot.slotStart)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 8),
                Text(
                  '${_formatTime(slot.slotStart)} - '
                  '${_formatTime(slot.slotEnd)}',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.confirmation_number_outlined, size: 18),
                const SizedBox(width: 8),
                Text('Créneau #${slot.id}'),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Réservée le ${_formatDateTime(booking.creationDate)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (booking.cancellationDate != null) ...[
              const SizedBox(height: 4),
              Text(
                'Annulée le '
                '${_formatDateTime(booking.cancellationDate!)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }

  static String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  static String _formatDateTime(DateTime date) {
    return '${_formatDate(date)} à ${_formatTime(date)}';
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final isCancelled = status.toUpperCase() == 'CANCELLED';

    return Chip(
      label: Text(isCancelled ? 'Annulée' : status),
      avatar: Icon(isCancelled ? Icons.cancel : Icons.check_circle, size: 18),
    );
  }
}
