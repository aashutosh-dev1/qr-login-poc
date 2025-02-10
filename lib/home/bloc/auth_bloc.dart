// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:qr_login_poc/home/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthState()) {
    on<InitializeLoginReqEvent>((event, emit) async {
      try {
        emit(state.copyWith(initializeLoginReqState: StateStatus.loading));
        final res = await authRepository.loginReq(event.deviceId);
        if (res != null) {
          emit(state.copyWith(
              initializeLoginReqState: StateStatus.success, token: res));
        }
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(initializeLoginReqState: StateStatus.error));
      }
    });

    on<LoginReqEvent>((event, emit) async {
      try {
        emit(state.copyWith(loginReqState: StateStatus.loading));
        final res = await authRepository.login(event.deviceId);
        if (res) {
          emit(state.copyWith(
            loginReqState: StateStatus.success,
          ));
        }
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(loginReqState: StateStatus.error));
      }
    });
  }
}
