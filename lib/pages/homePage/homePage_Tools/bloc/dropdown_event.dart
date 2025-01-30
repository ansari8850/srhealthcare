abstract class DropdownEvent {}

class FetchDropdownData extends DropdownEvent {}

class SelectDropdownItem extends DropdownEvent {
  final String selectedItem;
  SelectDropdownItem(this.selectedItem);
}