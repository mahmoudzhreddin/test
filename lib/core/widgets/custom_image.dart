import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/navigation.dart';
import 'cached_image.dart';
import 'image_place_holder.dart';
import 'view_image.dart';

class CustomImage extends StatelessWidget {
  final double? cornerRadius;
  final bool viewInFullScreen;
  final double? width;
  final double? height;
  final dynamic image;
  final Widget? placeHolder;
  final bool isNetworkImage;
  final BoxDecoration? decoration;
  final Color? color;
  final BoxFit? fit;
  final bool? svg;

  const CustomImage._(
      {this.cornerRadius,
      this.viewInFullScreen = false,
      this.image,
      this.width,
      this.height,
      this.placeHolder,
      this.isNetworkImage = true,
      this.decoration,
      this.color,
      this.fit,
      this.svg});

  factory CustomImage.circular(
          {required double radius,
          bool viewInFullScreen = false,
          dynamic image,
          Widget? placeHolder,
          BoxDecoration? decoration,
          isNetworkImage = true,
          Color? color,
          BoxFit? fit,
          svg = false}) =>
      CustomImage._(
        viewInFullScreen: viewInFullScreen,
        image: image,
        cornerRadius: radius,
        height: radius,
        width: radius,
        isNetworkImage: isNetworkImage,
        svg: svg,
        placeHolder: placeHolder,
        decoration: decoration,
        color: color,
        fit: fit,
      );

  factory CustomImage.rectangle({
    double cornerRadius = 0.0,
    required dynamic image,
    bool viewInFullScreen = false,
    double? width,
    double? height,
    Widget? placeHolder,
    BoxDecoration? decoration,
    BoxFit? fit,
    Color? color,
    isNetworkImage = true,
    svg = false,
  }) =>
      CustomImage._(
        image: image,
        viewInFullScreen: viewInFullScreen,
        cornerRadius: cornerRadius,
        height: height,
        width: width,
        color: color,
        isNetworkImage: isNetworkImage,
        placeHolder: placeHolder ?? Container(),
        decoration: decoration ?? const BoxDecoration(),
        fit: fit ?? BoxFit.contain,
        svg: svg,
      );

  viewImageInFullScreen(context) async {
    final Image imageFile;
    if (isNetworkImage) {
      final fileInfo = await DefaultCacheManager().getFileFromCache(image);
      imageFile = Image.file(fileInfo!.file);
      Navigation.push(context, ViewImage(image: imageFile));
    } else {
      imageFile = image is XFile
          ? Image.file(
              File(image.path),
              fit: fit ?? BoxFit.fill,
            )
          : Image.asset(
              image!,
              fit: fit ?? BoxFit.fill,
              color: color,
            );
      if (!svg!) {
        Navigation.push(context, ViewImage(image: imageFile));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      width: width,
      height: height,
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius!),
        child: image == null
            ? ImagePlaceHolder()
            : isNetworkImage == true
                ? CachedImage(
                    imageUrl: image!,
                    placeholder: placeHolder,
                    fit: fit ?? BoxFit.fill,
                  )
                : svg!
                    ? SvgPicture.asset(
                        image!,
                        color: color,
                        fit: fit ?? BoxFit.fill,
                      )
                    : image is XFile
                        ? Image.file(
                            File(image.path),
                            fit: fit ?? BoxFit.fill,
                          )
                        : Image.asset(
                            image!,
                            fit: fit ?? BoxFit.fill,
                            color: color,
                          ),
      ),
    );
    return (viewInFullScreen && !svg!)
        ? GestureDetector(
            onTap:
                viewInFullScreen ? () => viewImageInFullScreen(context) : () {},
            child: child,
          )
        : child;
  }
}
