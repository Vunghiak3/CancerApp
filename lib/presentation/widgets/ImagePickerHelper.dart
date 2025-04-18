import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../theme/text_styles.dart';
import '../../utils/navigation_helper.dart';
import '../screens/chooseCancer/chooseCancer.dart';

class ImagePickerHelper {
  static Future<File?> pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      return File(returnImage.path);
    }
    return null;
  }

  static Future<File?> pickImageFromFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  static void showImagePickerDialog(
      BuildContext context, Function(File) onImagePicked) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context)!.selectPhotoFrom,
              style: AppTextStyles.title,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.blue),
                  title: Text(
                    AppLocalizations.of(context)!.googlePhotos,
                    style: AppTextStyles.content,
                  ),
                  onTap: () async {
                    File? image = await pickImageFromGallery();
                    if (image != null) {
                      NavigationHelper.nextPage(
                          context, ChooseCancerPage(selectedImage: image));
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image, color: Colors.green),
                  title: Text(
                    AppLocalizations.of(context)!.libary,
                    style: AppTextStyles.content,
                  ),
                  onTap: () async {
                    File? image = await pickImageFromFiles();
                    if (image != null) {
                      NavigationHelper.nextPage(
                          context, ChooseCancerPage(selectedImage: image));
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: AppTextStyles.cancel,
                  ))
            ],
          );
        });
  }
}
