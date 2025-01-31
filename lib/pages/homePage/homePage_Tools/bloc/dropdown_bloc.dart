import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/bloc/dropdown_event.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/bloc/dropdown_state.dart';
import 'package:srhealthcare/services/dropDownService/home_page_dropdown.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  final HomePageDropdown apiService;

  DropdownBloc({required this.apiService}) : super(DropdownInitial()) {
    on<FetchDropdownData>((event, emit) async {
      emit(DropdownLoading());
      try {
       final response = await apiService?.fethInitialData('location');
        if (response != null && response.masterList != null) {
          final dropdownItems = ["All", ...response.masterList!
              .where((item) => item.status == 'Active')
              .map((item) => item.name ?? "")
              .toList()];
          emit(DropdownLoaded(
              dropdownItems: dropdownItems, selectedItem: "All"));
        } else {
          emit(DropdownError(errorMessage: 'No data available'));
        }
      } catch (e) {
        emit(DropdownError(errorMessage: e.toString()));
      }
    });

    on<SelectDropdownItem>((event, emit) {
      if (state is DropdownLoaded) {
        final currentState = state as DropdownLoaded;
        emit(currentState.copyWith(selectedItem: event.selectedItem));
      }
    });
  }
}