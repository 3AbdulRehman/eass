import 'package:flutter/material.dart';

class EassEmaiTextField extends StatelessWidget {
  EassEmaiTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
  }) : keyboardType = TextInputType.emailAddress;

  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  // Custom validator function to check if the entered text is a valid email
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double responsiveTextSize(double fontSize) {
      // Calculate responsive font size
      return fontSize * (w / 414); // 414 is a reference screen width
    }

    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: responsiveTextSize(18),
            color: Colors.black,
            fontFamily: "RegularFonts",
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),

        ),
        validator: validator ?? emailValidator,
      ),
    );
  }
}
