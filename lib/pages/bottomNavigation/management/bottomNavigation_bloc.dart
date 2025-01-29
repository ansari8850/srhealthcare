// ignore: file_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srhealthcare/pages/bottomNavigation/management/bottomnavigation_event.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationBloc extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial(selectedIndex: 0)){
    on<BottomNavigationEvent>((event , emit){
      if(event is BottomNavigationIndexChanged){
        emit(BottomNavigationInitial(selectedIndex: event.index));
      };
    });
  }
  
}
