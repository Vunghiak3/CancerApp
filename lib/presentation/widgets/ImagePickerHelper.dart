import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:testfile/presentation/widgets/CustomTopNotification.dart';
import '../../theme/text_styles.dart';

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
      final file = File(result.files.single.path!);
      if (_isValidImage(file)) {
        return file;
      } else {
        return null;
      }
    }
    return null;
  }

  static bool _isValidImage(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    return extension == 'png' || extension == 'jpeg' || extension == 'jpg';
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
                    if (image != null && image.existsSync() && image.lengthSync() > 0) {
                      Navigator.pop(context);
                      onImagePicked(image);
                    } else {
                      CustomTopNotification.show(
                        context,
                        message: 'Invalid Image Error. Please select again.',
                        color: Colors.red,
                        icon: Icons.error,
                      );
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
                    if (image != null && image.existsSync() && image.lengthSync() > 0) {
                      Navigator.pop(context);
                      onImagePicked(image);
                    } else {
                      CustomTopNotification.show(
                        context,
                        message: 'Invalid Image Error. Please select again.',
                        color: Colors.red,
                        icon: Icons.error,
                      );
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
