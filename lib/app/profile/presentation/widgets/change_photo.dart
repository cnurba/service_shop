import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';
import 'package:service_shop/injection.dart';

import '../../../../core/presentation/theme/colors.dart';

class ChangePhoto extends StatefulWidget {
  const ChangePhoto({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<ChangePhoto> createState() => _ChangePhotoState();
}

class _ChangePhotoState extends State<ChangePhoto> {
  String imageUrl = '';

  @override
  void initState() {
    imageUrl = widget.imageUrl;
    super.initState();
  }

  XFile? pickedImage;

  Future<void> pickPhoto() async {
    final picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (img != null) {
      final profRepository = getIt<IProfileRepository>();
      final uploadedUrl = await profRepository.setProfileImage(File(img.path));

      setState(() {
        imageUrl = uploadedUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: ServiceColors.primaryColor,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: ServiceColors.white,
            child: imageUrl.isEmpty
                ? SizedBox.shrink()
                : Stack(
                    //alignment: Alignment.topRight,
                    children: [
                      AppImageContainer(image: imageUrl, borderRadius: 40),
                      Positioned(
                        right: 20,

                        child: IconButton(
                          onPressed: pickPhoto,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                            color: ServiceColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        if (imageUrl.isEmpty)
          GestureDetector(
            onTap: pickPhoto,
            child: Icon(
              Icons.add_a_photo,
              size: 30,
              color: ServiceColors.primaryColor,
            ),
          ),
      ],
    );

    //   Column(
    //   children: [
    //     GestureDetector(
    //       onTap: pickPhoto,
    //       child: CircleAvatar(
    //         radius: 40,
    //         backgroundColor: ServiceColors.primaryColor,
    //         backgroundImage: pickedImage != null
    //             ? FileImage(File(pickedImage!.path))
    //             : null,
    //         child: pickedImage == null
    //             ? const Icon(
    //                 Icons.add_a_photo,
    //                 size: 40,
    //                 color: ServiceColors.white,
    //               )
    //             : null,
    //       ),
    //     ),
    //
    //     if (pickedImage != null) ...[
    //       const SizedBox(height: 8),
    //       ElevatedButton(
    //         onPressed: pickPhoto,
    //         child: const Text("Изменить фото"),
    //       ),
    //       const SizedBox(height: 16),
    //     ],
    //   ],
    // );
  }
}
