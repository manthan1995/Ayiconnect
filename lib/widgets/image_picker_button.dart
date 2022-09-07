import 'package:flutter/material.dart';

import '../../utils/image_picker_service.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({
    Key? key,
    required this.child,
    required this.onImageSelected,
    this.onRemovePhoto,
  }) : super(key: key);
  final void Function(List<String>) onImageSelected;
  final void Function()? onRemovePhoto;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: child,
      onTap: () {
        ImagePickerService(
          onRemovePhoto: onRemovePhoto,
          pickedImg: (imgPath) {
            if (imgPath == null) return;
            onImageSelected(imgPath);
          },
        ).openImagePikcer(
          multipicker: false,
          context: context,
          iosImagePicker: false,
        );
      },
    );
  }
}
