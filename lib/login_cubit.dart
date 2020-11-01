import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  void submitLogin(String username, String password) async {
    emit(LoadingLoginState());
    await Future.delayed(Duration(seconds: 3)); // fake task
    var isLoginSuccess = username == 'admin' && password == 'admin';
    if (isLoginSuccess) {
      emit(SuccessLoginState());
    } else {
      emit(FailureLoginState('Wrong username and password'));
    }
  }
}