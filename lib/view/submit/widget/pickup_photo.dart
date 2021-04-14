import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class PickupPhoto extends StatelessWidget {
  final VoidCallback onTap;
  final List<int> data;
  final bool isProcessing;

  const PickupPhoto({
    Key key,
    this.onTap,
    this.data,
    this.isProcessing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200,
        color: isProcessing ? AppColors.theme.shade50 : Colors.black12,
        child: data == null
            ? Center(
                child: isProcessing
                    ? CircularProgressIndicator()
                    : Icon(
                        Icons.add_a_photo,
                        color: Colors.black54,
                        size: 54,
                      ),
              )
            : Image.memory(
                data,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
