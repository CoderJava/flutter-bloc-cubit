import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit.dart';
import 'login_state.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final loginCubit = LoginCubit();
  final formLoginState = GlobalKey<FormState>();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final focusLabel = FocusNode();

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var widthScreen = mediaQueryData.size.width;
    var widthTextField = widthScreen / 3;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC Cubit'),
      ),
      body: BlocProvider<LoginCubit>(
        create: (context) => loginCubit,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Form(
              key: formLoginState,
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  var isLoading = state is LoadingLoginState;
                  return IgnorePointer(
                    ignoring: isLoading,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Focus(
                          focusNode: focusLabel,
                          child: Text(
                            'RAPATORY',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildWidgetMessageResultSignIn(state, widthTextField),
                        SizedBox(height: 16),
                        SizedBox(
                          width: widthTextField,
                          child: TextFormField(
                            controller: controllerUsername,
                            decoration: InputDecoration(
                              labelText: 'Username',
                            ),
                            validator: (value) {
                              return value.isEmpty ? 'Please fill username' : null;
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: widthTextField,
                          child: TextFormField(
                            controller: controllerPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              return value.isEmpty ? 'Please fill password' : null;
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: widthTextField,
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : RaisedButton(
                                  color: Colors.blue,
                                  child: Text('SIGN IN'),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (formLoginState.currentState.validate()) {
                                      var username = controllerUsername.text.trim();
                                      var password = controllerPassword.text.trim();
                                      focusLabel.requestFocus();
                                      loginCubit.submitLogin(username, password);
                                    }
                                  },
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetMessageResultSignIn(LoginState state, double width) {
    Color backgroundColor;
    String message;
    if (state is FailureLoginState) {
      backgroundColor = Colors.red[300];
      message = state.errorMessage;
    } else if (state is SuccessLoginState) {
      backgroundColor = Colors.green[300];
      message = 'Sign in successfully';
    } else {
      return Container(width: 0);
    }
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
