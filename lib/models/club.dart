// lib/models/club.dart
class Club {
  final int id;
  final String name;
  final String address;
  final String openingTime;
  final String closingTime;

  Club({required this.id, required this.name, required this.address, required this.openingTime, required this.closingTime});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(id: json['id'], name: json['name'], address: json['address'], openingTime: json['openingTime'], closingTime: json['closingTime']);
  }
}