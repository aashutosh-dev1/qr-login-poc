// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_bloc.dart';

enum StateStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final StateStatus initializeLoginReqState;
  final StateStatus loginReqState;
  final String token;

  const AuthState({
    this.initializeLoginReqState = StateStatus.initial,
    this.loginReqState = StateStatus.initial,
    this.token = "",
  });

  AuthState copyWith({
    StateStatus? initializeLoginReqState,
    StateStatus? loginReqState,
    String? token,
  }) {
    return AuthState(
      initializeLoginReqState:
          initializeLoginReqState ?? this.initializeLoginReqState,
      loginReqState: loginReqState ?? this.loginReqState,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [initializeLoginReqState, loginReqState, token];
}
