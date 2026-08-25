
class Slot {
  final int id;
  final DateTime slotStart;
  final DateTime slotEnd;
  final bool booked;

  Slot({
    required this.id,
    required this.slotStart,
    required this.slotEnd,
    required this.booked
});
  factory Slot.fromJson(Map<String, dynamic> json) {
    final booked;
    if(json['statut'] == "FREE") {
      booked = false;
    } else {
      booked = true;
    }
    return Slot(id: json['id'], slotStart: DateTime.parse(json['slotStart']), slotEnd: DateTime.parse(json['slotEnd']), booked: booked);
  }
}