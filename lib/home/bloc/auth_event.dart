part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InitializeLoginReqEvent extends AuthEvent {
  final String deviceId;

  const InitializeLoginReqEvent(this.deviceId);
}

class LoginReqEvent extends AuthEvent {
  final String deviceId;

  const LoginReqEvent(this.deviceId);
}
