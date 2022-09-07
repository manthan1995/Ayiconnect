import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profile_demo/utils/app_permissions_service.dart';

import '../constant/constant_string.dart';
import '../widgets/custom_alert.dart';

class ImagePickerService {
  ImagePickerService({
    required this.pickedImg,
    this.onRemovePhoto,
  });
//-------------------------------------------------------------------- Variable ----------------------------------------------------------------------------------//

  final ImagePicker _picker = ImagePicker();
  void Function(List<String>?) pickedImg;
  void Function()? onRemovePhoto;

  Future<String> _pickImage(ImageSource source) async {
    // Pick an image...
    final XFile? image = await _picker.pickImage(source: source);
    return image?.path ?? "";
  }

  Future<String> pickVideo(ImageSource source) async {
    // Pick an image...
    final XFile? video = await _picker.pickVideo(source: source);
    return video?.path ?? "";
  }

  /// Pick multiple image...
  Future<List<String>> _pickMultipleImage() async {
    // Pick an image...
    final List<XFile>? images = await _picker.pickMultiImage();
    return (images?.isEmpty ?? true)
        ? []
        : images?.map<String>((img) => img.path).toList() ?? [];
  }

  // Open image picker ...
  Future<List<String>?> openImagePikcer(
      {required bool multipicker,
      required BuildContext context,
      required bool iosImagePicker}) async {
    return iosImagePicker == false
        // Image picker android
        ? await _buildImagePickerForAndroid(context, multipicker)
        // Image picker ios
        : await _buildImagePickerForIOS(context, multipicker);
  }

  //-------------------------------------------------------------------- Image Picker For Android----------------------------------------------------------------------------------//

  _buildImagePickerForAndroid(BuildContext context, bool multipicker) async {
    showDialog<List<String>?>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Image Options",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ImageSource.values
                    .map(
                      // Buttons...
                      (source) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              try {
                                Navigator.of(ctx).pop();
                                if (await _isCameraAndGalleryPermissionAllowed(
                                  context,
                                  source,
                                )) {
                                  List<String> selectedImg = multipicker
                                      ? await _pickMultipleImage()
                                      : [await _pickImage(source)];

                                  selectedImg.removeWhere(
                                    (imgPath) => imgPath.isEmpty,
                                  );

                                  pickedImg(selectedImg);
                                }
                              } catch (e) {
                                print(e);
                                rethrow;
                              }
                            },
                            icon: Icon(
                              _getSouceImage(source),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            toBeginningOfSentenceCase(
                                  describeEnum(source),
                                ) ??
                                "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

//-------------------------------------------------------------------- Image Picker For IOS ----------------------------------------------------------------------------------//

  _buildImagePickerForIOS(BuildContext context, bool multipicker) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: <Widget>[
          // Pick from library button...
          _buildCupertinoActionSheetAction(
            context: context,
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                if (await _isCameraAndGalleryPermissionAllowed(
                  context,
                  ImageSource.gallery,
                )) {
                  List<String> selectedImg = multipicker
                      ? await _pickMultipleImage()
                      : [
                          await _pickImage(ImageSource.gallery),
                        ];

                  selectedImg.removeWhere(
                    (imgPath) => imgPath.isEmpty,
                  );

                  pickedImg(selectedImg);
                }
              } catch (e) {
                print(e.toString());
                rethrow;
              }
            },
            buttonText: ConstantString.pickfromLibrary,
          ),
          // Take a photo button...
          _buildCupertinoActionSheetAction(
            context: context,
            onPressed: () async {
              try {
                Navigator.of(context).pop();
                if (await _isCameraAndGalleryPermissionAllowed(
                  context,
                  ImageSource.camera,
                )) {
                  List<String> selectedImg = multipicker
                      ? await _pickMultipleImage()
                      : [await _pickImage(ImageSource.camera)];

                  selectedImg.removeWhere(
                    (imgPath) => imgPath.isEmpty,
                  );

                  pickedImg(selectedImg);
                }
              } catch (e) {
                print(e.toString());
                rethrow;
              }
            },
            buttonText: ConstantString.takeAPhoto,
          ),
          // Remove photo button...
          onRemovePhoto == null
              ? const SizedBox()
              : _buildCupertinoActionSheetAction(
                  context: context,
                  buttonText: ConstantString.removePhoto,
                  onPressed: onRemovePhoto!,
                )
        ],
        // Cancle button...
        cancelButton: _buildCupertinoActionSheetAction(
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: ConstantString.cancel,
        ),
      ),
    );
  }
//-------------------------------------------------------------------- Helper Widgets ----------------------------------------------------------------------------------//

  // Cupertino Action Sheet Action
  Widget _buildCupertinoActionSheetAction(
      {required BuildContext context,
      required String buttonText,
      required void Function() onPressed}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: Colors.grey.shade500,
      ),
      child: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: onPressed,
          child: Text(
            buttonText,
            style:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 17.0),
          )),
    );
  }
//-------------------------------------------------------------------- Helper Function----------------------------------------------------------------------------------//

  // Get source icon image...
  static IconData _getSouceImage(ImageSource source) {
    switch (source) {
      case ImageSource.camera:
        return Icons.camera_alt_outlined;

      case ImageSource.gallery:
        return Icons.photo_outlined;
    }
  }

  // Check camera and gallery permission...
  Future<bool> _isCameraAndGalleryPermissionAllowed(
    context,
    ImageSource source,
  ) async {
    bool isGranted = false;
    String sourceName = "";
    String media = "";
    String suffixMsg = "";
    switch (source) {
      case ImageSource.camera:
        isGranted = await AppPermissionsService.checkCameraPermission;
        sourceName = Platform.isIOS ? "Camera" : "Storage";
        media = Platform.isIOS ? "capture" : "store";
        suffixMsg =
            " to set your profile picture"; // Add one white space at starting of message.
        break;
      case ImageSource.gallery:
        isGranted = await AppPermissionsService.isGalleryPermissionGranted;
        sourceName = Platform.isIOS ? "Photos" : "Storage";
        media = "access";
        suffixMsg =
            " to set your profile picture"; // Add one white space at starting of message.
        break;
    }

    // "Go to Settings - $_sourceName and grant permission to $_media photo$_suffixMsg.",
    if (!isGranted) {
      showAlert(
        context: context,
        message:
            "Go to Settings - $sourceName and grant permission to $media photo$suffixMsg.",
        title: "Permission denied",
        signleBttnOnly: false,
        leftBttnTitle: "Settings",
        rigthBttnTitle: "Cancel",
        onLeftAction: () {
          openAppSettings();
        },
      );
    }

    return isGranted;
  }
//-------------------------------------------------------------------- Button Action----------------------------------------------------------------------------------//

//   // Pick from library
//   void pickFromlibraryButtonAction() {
//     Get.back();
//   }

// // Take a photo Action
//   void takeAPhotoButtonAction({required BuildContext context}) {
//     Get.back();
//   }

// // Cancle story action...
//   void _cancleButtonAction() {
//     Get.back();
//   }
}
