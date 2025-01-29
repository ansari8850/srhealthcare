import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_event.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_state.dart';
import 'package:srhealthcare/services/authApiService/login_api_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginApiService apiService;

  LoginBloc(this.apiService) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final response = await apiService.login(event.email, event.password);

        if (response?.$1 == null && response?.$2 != null) {
          emit(LoginSuccess(response!.$2!)); // Use null assertion operator safely here
        } else {
          emit(LoginFailure(response?.$1 ?? "Login failed"));
        }
      } catch (e) {
        emit(LoginFailure(e.toString())); // Catch and emit any errors
      }
    });
  }
}