import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class SingleLineTextField extends StatelessWidget {
  final bool isRequired;
  final TextEditingController controller;
  final String hint;
  final ValueChanged onChanged;

  const SingleLineTextField({
    Key key,
    this.isRequired,
    this.controller,
    this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          hintText: hint,
          fillColor: AppColors.accent.shade50,
          filled: isRequired,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.theme,
            ),
          ),
        ),
      ),
    );
  }
}
