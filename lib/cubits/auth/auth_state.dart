part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.authenticated(UserModel userModel) =
      _Authenticated;
  const factory AuthState.unauthenticated({String? error}) =
      _Unauthenticated;
  const factory AuthState.loading() = _Loading;
}
