import 'api_client.dart';

class AuthService {
  final _dio = ApiClient().dio;

  Future<String> login(String email, String password) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return response.data['token'];
  }

  Future<String> register(String name, String email, String password) async {
    final response = await _dio.post(
      '/auth/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    return response.data['token'];
  }
}
