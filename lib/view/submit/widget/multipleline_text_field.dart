import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class MultipleLineTextField extends StatelessWidget {
  final bool isRequired;
  final TextEditingController controller;

  const MultipleLineTextField({
    Key key,
    this.isRequired,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      minLines: 5,
      decoration: InputDecoration(
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
