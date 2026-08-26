import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_booking_front/services/api_client.dart';
import 'package:padel_booking_front/services/auth_service.dart';
import 'auth_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final ApiClient _apiClient = ApiClient();

  AuthCubit(this._authService): super(AuthInitial());

  Future<void> checkAuthStatus() async {
    final hasToken = await _apiClient.hasToken();
    if(hasToken) {
      final token = await _apiClient.readToken();
      final email = JwtDecoder.decode(token!)['sub'];
      emit(Authenticated(email));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final token = await _authService.login(email, password);
      await _apiClient.saveToken(token);
      emit(Authenticated(email));
    } catch(e) {
      emit(AuthError('Email ou mot de passe incorrect'));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final token = await _authService.register(name, email, password);
      await _apiClient.saveToken(token);
      emit(Authenticated(email));
    } catch (e) {
      emit(AuthError('Erreur lors de l\'inscription'));
    }
  }

  Future<void> logout() async {
    await _apiClient.clearToken();
    print('EMIT UNAUTHENTICATED');
    emit(Unauthenticated());
  }

}



