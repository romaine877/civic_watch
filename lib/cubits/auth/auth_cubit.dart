import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/user_model.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.initial());

  void signIn() {
    emit(const AuthState.loading());
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      emit(AuthState.authenticated(
        UserModel.testUser(),
      ));
    });
  }

  void signOut() {
    emit(const AuthState.loading());
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      emit(const AuthState.unauthenticated());
    });
  }


}
