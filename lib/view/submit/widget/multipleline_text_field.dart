import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class MultipleLineTextField extends StatelessWidget {
  final bool isRequired;
  final TextEditingController controller;
  final String hint;

  const MultipleLineTextField({
    Key key,
    this.isRequired,
    this.controller,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      minLines: 5,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: AppColors.accent.shade50,
        filled: isRequired,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.theme,
          ),
        ),
      ),
    );
  }
}
