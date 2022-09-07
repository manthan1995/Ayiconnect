import 'dart:io';

import 'package:flutter/material.dart';

import '../../constant/img_name.dart';

class CustImage extends StatelessWidget {
  final String imgURL;
  final double? height;
  final double? width;
  final double? cornerRadius;
  final String errorImage;
  final bool zoomablePhoto;
  final Color? backgroundColor;
  final Color? imgColor;
  final BoxFit boxfit;
  final String name;
  final Color? textColor;
  final EdgeInsets letterPadding;

  const CustImage({
    Key? key,
    this.imgURL = "",
    this.cornerRadius = 0,
    this.height,
    this.width,
    this.boxfit = BoxFit.cover,
    this.errorImage = ImgName.noProfile,
    this.zoomablePhoto = false,
    this.backgroundColor,
    this.imgColor,
    this.textColor,
    this.name = "",
    this.letterPadding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  Widget defaultImg(BuildContext context) => name.isEmpty
      ? Image.asset(
          errorImage,
          color: imgColor,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            errorImage,
            fit: BoxFit.cover,
            color: imgColor,
            height: height,
            width: width,
          ),
          fit: BoxFit.cover,
          height: height,
          width: width,
        )
      : userName(context);

  Widget userName(BuildContext context) => Padding(
        padding: letterPadding,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            name[0],
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: textColor ?? const Color(0xFF808080),
                ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget image = defaultImg(context);
    if (imgURL.isNotEmpty) {
      // Check if Network image...
      if (isNetworkImage(imgURL)) {
        image = _cacheImage(context);

        // Check if Asset image...
      } else if (isAssetImage(imgURL)) {
        image = Image.asset(
          imgURL,
          height: height,
          width: width,
          color: imgColor,
          errorBuilder: (context, error, stackTrace) => defaultImg(context),
          fit: boxfit,
        );

        // Check if File image...
      } else if (isFileImage(imgURL)) {
        image = Image.file(
          File(imgURL),
          height: height,
          width: width,
          color: imgColor,
          errorBuilder: (context, error, stackTrace) => defaultImg(context),
          fit: boxfit,
        );
      }
    } else if (name.trim().isNotEmpty) {
      image = userName(context);
    }

    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: name.trim().isNotEmpty
            ? Colors.grey.withOpacity(0.5)
            : backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(cornerRadius ?? 0.0),
        ),
      ),
      height: height,
      width: width,
      child: image,
    );
  }

  Widget _cacheImage(BuildContext context) {
    return Image.network(
      imgURL,
      fit: boxfit,
      height: height,
      width: width,
      color: imgColor,
      errorBuilder: (context, error, stackTrace) => defaultImg(context),
    );
  }

  bool isAssetImage(String url) => url.toLowerCase().contains(ImgName.imgPath);

  bool isFileImage(String url) => !isAssetImage(url);

  bool isNetworkImage(String url) =>
      url.toLowerCase().startsWith("http://") ||
      url.toLowerCase().startsWith("https://");
}
