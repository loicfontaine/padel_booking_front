// lib/models/club.dart
class Club {
  final String name;
  final String address;
  final String openingTime;
  final String closingTime;

  Club({required this.name, required this.address, required this.openingTime, required this.closingTime});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(name: json['name'], address: json['address'], openingTime: json['openingTime'], closingTime: json['closingTime']);
  }
}