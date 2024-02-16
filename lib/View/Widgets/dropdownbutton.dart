import 'package:flutter/material.dart';

import '../../constant.dart';


class ReusableDropdownButton extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;
  final String labelText;
  final IconData prefixIcon;

  ReusableDropdownButton({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.labelText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: items.map((e) {
          return DropdownMenuItem(child: Text(e), value: e);
        }).toList(),
        onChanged: onChanged,
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: kTextColor, // Ensure that kTextColor is correctly defined
        ),
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon, color: kTextColor), // Ensure kTextColor is defined
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
}
