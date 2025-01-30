abstract class DropdownState {}

class DropdownInitial extends DropdownState {}

class DropdownLoading extends DropdownState {}

class DropdownLoaded extends DropdownState {
  final List<String> dropdownItems;
  final String selectedItem;

  DropdownLoaded({required this.dropdownItems, required this.selectedItem});

  DropdownLoaded copyWith({List<String>? dropdownItems, String? selectedItem}) {
    return DropdownLoaded(
      dropdownItems: dropdownItems ?? this.dropdownItems,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}

class DropdownError extends DropdownState {
  final String errorMessage;
  DropdownError({required this.errorMessage});
}