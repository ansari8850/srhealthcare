import 'package:flutter/material.dart';

@immutable
abstract class BottomNavigationState {
  final int selectedIndex;
  const BottomNavigationState({required this.selectedIndex});
}

class BottomNavigationInitial extends BottomNavigationState {
const BottomNavigationInitial({required super.selectedIndex});
}
