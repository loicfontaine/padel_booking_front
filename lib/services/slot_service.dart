import 'package:intl/intl.dart';

import '../models/slot.dart';
import 'api_client.dart';

class SlotService {
  final _dio = ApiClient().dio;

  Future<List<Slot>> getAllSlotsByCourt(int courtId, DateTime date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final response = await _dio.get(
      '/slots?date=${formattedDate}&courtId=${courtId}',
    );
    return (response.data as List).map((json) => Slot.fromJson(json)).toList();
  }
}
