import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_bloc.dart';
import 'package:srhealthcare/pages/authPage/login_page.dart';
import 'package:srhealthcare/pages/bottomNavigation/management/bottomNavigation_bloc.dart';
import 'package:srhealthcare/services/authApiService/login_api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBloc>(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(LoginApiService()),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'SR Healthcare',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: LoginPage(), // Home page (LoginPage) with LoginCubit and BottomNavigationBloc
      ),
    );
  }
}
