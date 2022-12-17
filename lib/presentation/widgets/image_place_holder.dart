import 'package:flutter/material.dart';
import 'package:marvel_characters/core/app_colors.dart';

class ImagePlaceHolder extends StatelessWidget {
  final String assetImageName;
  const ImagePlaceHolder({Key? key, required this.assetImageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 150,
        width: 150,
        color: AppColors.placeHolderColor,
        child: Center(
          child: SizedBox(
              height: 50, width: 50, child: Image.asset(assetImageName)),
        ));
  }
}
