import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_bloc.dart';
import 'package:srhealthcare/pages/authPage/login_page.dart';
import 'package:srhealthcare/pages/bottomNavigation/bottom_navigation.dart'; // Import BottomNavigation
import 'package:srhealthcare/pages/bottomNavigation/management/bottomNavigation_bloc.dart';
import 'package:srhealthcare/services/authApiService/login_api_service.dart';
import 'package:srhealthcare/services/dropDownService/home_page_dropdown.dart';
import 'package:srhealthcare/services/sharedprefrence_helper.dart';

import 'pages/homePage/homePage_Tools/bloc/dropdown_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper().init();
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
        BlocProvider<DropdownBloc>(
          create: (context) => DropdownBloc(apiService: HomePageDropdown()),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'SR Healthcare',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: _determineHomePage(), // Use a function to determine the home page
      ),
    );
  }

  Widget _determineHomePage() {
    final prefs = SharedPreferenceHelper();
    final accessToken = prefs.getAccessToken();

    if (accessToken != null) {
      // User is logged in, navigate to BottomNavigation
      return const BottomNavigation();
    } else {
      // User is not logged in, navigate to LoginPage
      return LoginPage();
    }
  }
}