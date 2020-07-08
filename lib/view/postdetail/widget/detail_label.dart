import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class DetailLabel extends StatelessWidget {
  final String label;
  final String iconFileName;

  const DetailLabel({
    Key key,
    this.label,
    this.iconFileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/$iconFileName',
            height: 24,
            width: 24,
            color: AppColors.theme,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.theme,
            ),
          ),
        ],
      ),
    );
  }
}
