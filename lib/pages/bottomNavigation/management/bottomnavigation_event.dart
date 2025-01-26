// Abstract class for all events related to BottomNavigation
abstract class BottomNavigationEvent {}

class BottomNavigationIndexChanged extends BottomNavigationEvent {
  final int index;

  BottomNavigationIndexChanged(this.index); 
}
