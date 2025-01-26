import 'package:flutter/material.dart';

@immutable
abstract class BottomNavigationState {
  final int selectedIndex;
  BottomNavigationState({required this.selectedIndex});
}

class BottomNavigationInitial extends BottomNavigationState {
BottomNavigationInitial({required super.selectedIndex});
}
