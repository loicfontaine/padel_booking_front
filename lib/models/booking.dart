class Booking {
  final String status;
  final DateTime creationDate;
  final DateTime? cancellationDate;

  Booking({
    required this.status,
    required this.creationDate,
    this.cancellationDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      status: json['status'],
      creationDate: DateTime.parse(json['creationDate']),
      cancellationDate: json['cancellationDate'] != null
          ? DateTime.parse(json['cancellationDate'])
          : null,
    );
  }
}
