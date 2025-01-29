import 'package:srhealthcare/model/login_user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResModel loginData;

  LoginSuccess(this.loginData);
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
