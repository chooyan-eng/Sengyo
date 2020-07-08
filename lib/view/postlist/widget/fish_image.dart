import 'package:flutter/material.dart';
import 'package:sengyo/model/fish.dart';
import 'package:sengyo/repository/image_file_repository.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class FishImage extends StatelessWidget {

  final Fish data;

  const FishImage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data != null ? ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FutureBuilder<String>(
        future: ImageFileRepository.toDownloadUrl(data.imagePath),
        builder: (context, snapshot) => snapshot.hasData ? InkWell(
          child: Image.network(
            snapshot.data,
            height: 40,
            width: 40,
            fit: BoxFit.fill,
          ),
        ) : NoFishImage(),
      ),
    ) : NoFishImage();
  }
  
}

class NoFishImage extends StatelessWidget {
  const NoFishImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 40, width: 40, color: AppColors.theme.shade50);
  }
}