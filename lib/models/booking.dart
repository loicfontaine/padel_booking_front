import 'package:padel_booking_front/models/slot.dart';

class Booking {
  final String status;
  final DateTime creationDate;
  final DateTime? cancellationDate;
  final Slot slot;

  Booking({
    required this.status,
    required this.creationDate,
    required this.slot,
    this.cancellationDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      status: json['status'],
      creationDate: DateTime.parse(json['creationDate']),
      slot: Slot.fromJson(json['slot']),
      cancellationDate: json['cancellationDate'] != null
          ? DateTime.parse(json['cancellationDate'])
          : null,
    );
  }
}
