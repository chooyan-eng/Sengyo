import 'package:flutter/material.dart';
import 'package:sengyo/l10n/app_localizations.dart';
import 'package:sengyo/model/fish.dart';
import 'package:sengyo/repository/image_file_repository.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class PickupList extends StatelessWidget {
  final List<Fish> fishList;
  final ValueChanged<Fish> onItemTap;

  const PickupList({
    Key key,
    this.fishList,
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
              AppLocalizations.of(context).labelPickups,
              style: AppTextStyle.label,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 64,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: fishList.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                    left: 16,
                    right: index == fishList.length - 1 ? 16 : 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FutureBuilder<String>(
                    future: ImageFileRepository.toDownloadUrl(
                        fishList[index].imagePath),
                    builder: (context, snapshot) => snapshot.hasData
                        ? InkWell(
                            onTap: () => onItemTap(fishList[index]),
                            child: Image.network(
                              snapshot.data,
                              height: 40,
                              width: 40,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            height: 40,
                            width: 40,
                            color: AppColors.theme.shade50),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
