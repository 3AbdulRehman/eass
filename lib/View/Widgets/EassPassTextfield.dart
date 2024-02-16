import 'package:eass/constant.dart';
import 'package:flutter/material.dart';

class EassPassField extends StatefulWidget {
  EassPassField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
  });

  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  _ForexPassFieldState createState() => _ForexPassFieldState();
}

class _ForexPassFieldState extends State<EassPassField> {
  bool _isObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  double w = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;

  double responsiveTextSize(double fontSize) {
    // Calculate responsive font size
    return fontSize * (w / 414); // 414 is a reference screen width
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
        obscureText: _isObscure,
        controller: widget.controller,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontSize: responsiveTextSize(20),
            color: Colors.black,
            fontFamily: "RegularFonts",
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: kTextColor, // You can customize the icon color
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}
