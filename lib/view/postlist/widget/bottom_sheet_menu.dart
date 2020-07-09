import 'package:flutter/material.dart';

class BottomSheetMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const BottomSheetMenu({
    Key key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 24, color: Colors.black54),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
