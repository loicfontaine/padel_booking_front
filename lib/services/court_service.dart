import '../models/court.dart';
import 'api_client.dart';

class CourtService {
  final _dio = ApiClient().dio;

  Future<List<Court>> getAllCourtsByClub(int clubId) async {
    final response = await _dio.get('/courts/club/${clubId}');
    return (response.data as List).map((json) => Court.fromJson(json)).toList();
  }
}
