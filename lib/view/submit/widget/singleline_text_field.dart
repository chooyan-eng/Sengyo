import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class SingleLineTextField extends StatelessWidget {
  final bool isRequired;

  const SingleLineTextField({
    Key key,
    this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextField(
        decoration: InputDecoration(
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
