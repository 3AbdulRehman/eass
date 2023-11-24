import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EassDropdown extends StatelessWidget {
  final String selectedValue;
  final List<Map<String, String>> dropDownListData;
  final void Function(String?) onChanged;
  final String labelText; // Added parameter for the label text

  EassDropdown({
    required this.selectedValue,
    required this.dropDownListData,
    required this.onChanged,
    this.labelText = "Select Package", // Default label text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: InputDecorator(
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            isDense: true,
            isExpanded: true,
            menuMaxHeight: 200,
            items: [
              DropdownMenuItem<String>(
                child: Text(
                  labelText, // Use the labelText parameter
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "RegularFonts"),
                ),
                value: "",
              ),
              ...dropDownListData.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem<String>(
                  child: Text(e['title']!),
                  value: e['value'],
                );
              }).toList(),
            ],
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
