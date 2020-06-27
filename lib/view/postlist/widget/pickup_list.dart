import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class PickupList extends StatelessWidget {
  final ValueChanged<int> onItemTap;

  const PickupList({
    Key key,
    this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.accent.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Text(
              '注目のお魚',
              style: AppTextStyle.label,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Row(
                children: List.generate(10, (index) => index)
                  .expand((element) => [
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () => onItemTap(element),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/aodai.jpeg', // TODO: dummy
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
