import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_cubit/login_cubit.dart';
import 'package:flutter_bloc_cubit/login_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  LoginCubit loginCubit;

  setUp(() {
    loginCubit = LoginCubit();
  });

  tearDown(() {
    loginCubit?.close();
  });

  test(
    'pastikan initialState adalah InitialLoginState',
    () async {
      // assert
      expect(loginCubit.state, InitialLoginState());
    },
  );

  test(
    'pastikan tidak ada state yang ter-emit ketika cubit sudah ter-close',
    () async {
      // act
      await loginCubit.close();

      // assert
      expect(loginCubit.state, InitialLoginState());
    },
  );

  blocTest(
    'pastikan emit [LoadingLoginState, SuccessLoginState] dengan proses berhasil login',
    build: () {
      return loginCubit;
    },
    act: (LoginCubit cubit) {
      return cubit.submitLogin('admin', 'admin');
    },
    expect: [
      LoadingLoginState(),
      SuccessLoginState(),
    ],
  );

  blocTest(
    'pastikan emit [LoadingLoginState, FailureLoginState] dengan proses gagal login',
    build: () {
      return loginCubit;
    },
    act: (LoginCubit cubit) {
      return cubit.submitLogin('admin2', 'admin2');
    },
    expect: [
      LoadingLoginState(),
      FailureLoginState('Wrong username and password'),
    ],
  );
}
