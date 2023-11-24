import 'package:flutter/material.dart';

class EassTextField extends StatelessWidget {
  EassTextField({super.key, required this.labelText, required this.controller, this.validator, required this.keyboardType});

  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
   final TextInputType keyboardType; // Add keyboardType parameter



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
            fontSize: responsiveTextSize(20),
            color: Colors.black,
            fontFamily: "RegularFonts",
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
        ),
        validator: validator,
      ),

    );
  }
}
