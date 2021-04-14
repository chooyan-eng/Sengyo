import 'package:flutter/material.dart';
import 'package:sengyo/repository/image_file_repository.dart';

class FixedSizeImage extends StatelessWidget {
  final String imagePath;
  final bool withMask;
  final Widget child;

  const FixedSizeImage({
    Key key,
    this.imagePath,
    this.withMask,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        imagePath != null
            ? FutureBuilder<String>(
                future: ImageFileRepository.toDownloadUrl(imagePath),
                builder: (context, snapshot) => Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.black12,
                  child: snapshot.hasData
                      ? Image.network(
                          snapshot.data,
                          fit: BoxFit.cover,
                        )
                      : SizedBox.shrink(),
                ),
              )
            : Container(
                width: double.infinity,
                height: 200,
                color: Colors.black12,
                child: Center(
                  child: Text(
                    'No Image',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
        withMask
            ? Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(150),
                        Colors.black.withAlpha(200)
                      ]),
                ),
                child: child,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
