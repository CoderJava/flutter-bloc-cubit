import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class FailureLoginState extends LoginState {
  final String errorMessage;

  FailureLoginState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureLoginState{errorMessage: $errorMessage}';
  }
}

class SuccessLoginState extends LoginState {}