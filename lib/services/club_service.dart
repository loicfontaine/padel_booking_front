import '../models/club.dart';
import 'api_client.dart';

class ClubService {
  final _dio = ApiClient().dio;

  Future<List<Club>> getAllClubs() async {
    final response = await _dio.get('/clubs');
    return (response.data as List).map((json) => Club.fromJson(json)).toList();
  }
}
