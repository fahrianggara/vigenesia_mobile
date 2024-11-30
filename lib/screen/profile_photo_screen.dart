import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/model/user.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/bottom_sheet.dart';
import 'package:vigenesia/utils/utilities.dart';

@RoutePage()
class ProfilePhotoScreen extends StatefulWidget {
  final User user;
  final bool isProfilePage;
  const ProfilePhotoScreen({super.key, required this.user, this.isProfilePage = false});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> 
{
  ProfileController profileController = Get.put(ProfileController());
  AuthController authController = Get.put(AuthController());

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
              FutureBuilder<int>(
                future: authController.getAuthId(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == widget.user.id && widget.isProfilePage) {
                      return IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          photoProfileBottomSheet(context, profileController, title: 'Edit Foto Profile');
                        },
                      );
                    }
                  }
                  return Container();
                },
              )
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
                        image: NetworkImage(
                          widget.isProfilePage
                            ? profileController.user.value?.photoUrl ?? ''
                            : widget.user.photoUrl ?? '',
                        ),
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