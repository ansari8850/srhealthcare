import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAction extends StatelessWidget {
  final String image;
  final String label;

  const CustomAction({
    Key? key,
    required this.image,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: const Color(0xffBAF0F4).withOpacity(0.4),
          child: Image.asset(
            image,
            height: 15,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: const Color(0xff6656E0),
          ),
        ),
      ],
    );
  }
}
