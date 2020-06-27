import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class MultipleLineTextField extends StatelessWidget {
  final bool isRequired;

  const MultipleLineTextField({
    Key key,
    this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
