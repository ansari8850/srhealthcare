import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srhealthcare/constant/color_constant.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/bloc/dropdown_bloc.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/bloc/dropdown_event.dart';
import 'package:srhealthcare/pages/homePage/homePage_Tools/bloc/dropdown_state.dart';

class DropdownExample extends StatefulWidget {
  final Function(String?) onLocationSelected;

  const DropdownExample({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {

  @override
  void initState() {
    super.initState();
    context.read<DropdownBloc>().add(FetchDropdownData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownBloc, DropdownState>(
      builder: (context, state) {
        if (state is DropdownLoading) {
          return const CircularProgressIndicator(); // Or a loading indicator
        } else if (state is DropdownLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 18, color: Colors.white),
              const SizedBox(width: 10),
              Flexible(
                fit: FlexFit.tight,
                child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(10),
                   alignment: Alignment.topLeft,
                  elevation: 0,
                  isDense: true,
                  isExpanded: true,
                  value: state.selectedItem,
                  items: state.dropdownItems.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )).toList(),
                  onChanged: (value) {
                    context.read<DropdownBloc>().add(SelectDropdownItem(value!));
                    widget.onLocationSelected(value);
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  icon: SizedBox.shrink(),
                  dropdownColor: ColorConstant. mainColor,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
            ],
          );
        } else if (state is DropdownError) {
          return Text(state.errorMessage); // Or display the error message
        } else {
          return const SizedBox.shrink(); // Handle other states if needed
        }
      },
    );
  }
}