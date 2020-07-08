import 'package:flutter/material.dart';

class PickupPhoto extends StatelessWidget {
  final VoidCallback onTap;
  final List<int> data;

  const PickupPhoto({
    Key key,
    this.onTap,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200,
        color: Colors.black12,
        child: data == null ? Center(
          child: Icon(
            Icons.add_a_photo,
            color: Colors.black54,
            size: 54,
          ),
        ) : Image.memory(
          data,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
