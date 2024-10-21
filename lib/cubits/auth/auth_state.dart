part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.authenticated(UserModel userModel) = Authenticated;
  const factory AuthState.unauthenticated({String? error}) = Unauthenticated;
  const factory AuthState.loading() = Loading;
}
