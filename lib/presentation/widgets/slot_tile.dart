import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:padel_booking_front/cubits/booking_cubit.dart';
import 'package:padel_booking_front/models/slot.dart';

class SlotTile extends StatelessWidget {
  final Slot slot;

  const SlotTile({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
    final bool available = !slot.booked;
    return ListTile(
      leading: Icon(
        available ? Icons.check_circle : Icons.cancel,
        color: available ? Colors.green : Colors.red,
      ),
      title: Text(
        '${DateFormat('HH:mm').format(slot.slotStart)} - ${DateFormat('HH:mm').format(slot.slotEnd)}',
      ),
      trailing: Chip(label: Text(available ? 'Libre' : 'Réservé')),
      onTap: available ? () => _showBookingConfirmation(context) : null,
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Confirmer la réservation'),
          content: Text(
            'Voulez-vous réserver le créneau '
            '${DateFormat('HH:mm').format(slot.slotStart)} - ${DateFormat('HH:mm').format(slot.slotEnd)} ?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                context.read<BookingCubit>().createBooking(slot.id);
              },
              child: const Text('Réserver'),
            ),
          ],
        );
      },
    );
  }
}
