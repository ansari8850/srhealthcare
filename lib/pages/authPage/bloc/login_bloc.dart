import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_event.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_state.dart';
import 'package:srhealthcare/services/authApiService/login_api_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginApiService apiService;

  LoginBloc(this.apiService) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      final response = await apiService.login(event.email, event.password);

      if (response?.$1 == null && response?.$2 != null) {
        yield LoginSuccess(response!.$2!);
      } else {
        yield LoginFailure(response?.$1 ?? "Login failed");
      }
    }
  }
}
