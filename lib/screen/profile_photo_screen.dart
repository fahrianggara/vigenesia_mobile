import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/model/user.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/bottom_sheet.dart';
import 'package:vigenesia/utils/utilities.dart';

@RoutePage()
class ProfilePhotoScreen extends StatefulWidget {
  final User user;
  const ProfilePhotoScreen({super.key, required this.user});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> 
{
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgressHUD(
        inAsyncCall: profileController.isLoadingForm.value,
        color: Theme.of(context).colorScheme.surface,
        progressIndicator: CircularProgressIndicator(
          color: VColors.primary,
        ),
        child: Scaffold(
          appBar: appBar(
            context,
            title: 'Foto Profil',
            titleColor: Theme.of(context).colorScheme.onSurface,
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  photoProfileBottomSheet(context, profileController, title: 'Edit Foto Profile');
                },
              ),
            ],
          ),
          body: InteractiveViewer(
            maxScale: 5.0,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: 395,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(profileController.user.value!.photoUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}