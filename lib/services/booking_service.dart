import '../models/booking.dart';
import 'api_client.dart';

class BookingService {
  final _dio = ApiClient().dio;

  Future<Booking> createBooking(int slotId) async {
    final response = await _dio.post('/bookings', data: {"slotId": slotId});
    return Booking.fromJson(response.data);
  }
}
