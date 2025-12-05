import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/theme/colors.dart';

class ChangePhoto extends StatefulWidget {
  const ChangePhoto({super.key});

  @override
  State<ChangePhoto> createState() => _ChangePhotoState();
}

class _ChangePhotoState extends State<ChangePhoto> {
  XFile? pickedImage;

  Future<void> pickPhoto() async {
    final picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (img != null) {
      setState(() {
        pickedImage = img;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          GestureDetector(
            onTap: pickPhoto,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: ServiceColors.primaryColor,
              backgroundImage:
              pickedImage != null ? FileImage(File(pickedImage!.path)) : null,
              child: pickedImage == null
                  ? const Icon(Icons.add_a_photo,
                  size: 40, color: ServiceColors.white)
                  : null,
            ),
          ),


          if (pickedImage != null) ...[
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: pickPhoto,
              child: const Text("Изменить фото"),
            ),
            const SizedBox(height: 16)

          ]
        ]);
  }
}
