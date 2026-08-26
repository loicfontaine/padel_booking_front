class Court {
  final int id;
  final String name;
  final String slotDuration;

  Court({required this.id, required this.name, required this.slotDuration});

  factory Court.fromJson(Map<String, dynamic> json) {
    return Court(
      id: json['id'],
      name: json['name'],
      slotDuration: json['slotDuration'],
    );
  }
}
