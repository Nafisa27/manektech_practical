import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manektech_prac/app_utils/app_images.dart';
import 'package:manektech_prac/app_utils/dimens.dart';

Widget getImage(String url, {BoxFit fit = BoxFit.cover}) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: fit,
    progressIndicatorBuilder: (context, url, downloadProgress) => Container(
      width: Dimens.margin10,
      height: Dimens.margin10,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
      ),
    ),
    errorWidget: (context, url, error) => Container(
      color: Colors.white,
      child: Image.asset(
        placeHolder,
        fit: BoxFit.none,
      ),
    ),
  );
}