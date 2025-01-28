import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srhealthcare/constant/color_constant.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? labelText;
  final Widget? suffixIcon;

  CustomTextField({
    required this.controller,
    required this.hintText,
    this.hintStyle,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false, // Default to false if not specified
    this.padding,
    this.margin,
    this.labelText,
    this.suffixIcon, // Optional suffix icon
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.only(top: 7),
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor.withOpacity(.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          border: InputBorder.none,
          hintStyle: widget.hintStyle ??
              GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: greyColor,
              ),
          suffixIcon: widget.obscureText
              ? IconButton(
                splashColor: Colors.transparent,
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility ,
                    color: greyColor,
                  ),
                  onPressed: _toggleObscureText,
                )
              : widget.suffixIcon, // Show the custom suffix icon for other fields
        ),
      ),
    );
  }
}
