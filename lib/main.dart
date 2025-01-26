import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srhealthcare/pages/bottomNavigation/management/bottomNavigation_bloc.dart';
import 'package:srhealthcare/pages/bottomNavigation/bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SR Healthcare',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const BottomNavigation(), // Use the BottomNavigation widget
      ),
    );
  }
}
