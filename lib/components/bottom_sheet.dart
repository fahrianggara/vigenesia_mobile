import 'package:flutter/material.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/widget.dart';

Widget buildListTile({
  required IconData icon,
  required String title,
  required VoidCallback? onTap,
  Color? tileColor,
  Color? iconColor,
  TextStyle? textStyle,
  BorderRadius? borderRadius,
}) {
  return ListTile(
    shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(5)),
    tileColor: tileColor ?? VColors.gray.withOpacity(0.1),
    leading: Icon(icon, color: iconColor),
    title: Text(title, style: textStyle),
    titleTextStyle: TextStyle(letterSpacing: 0.1, color: Colors.black),
    onTap: onTap,
  );
}

Future<dynamic> modalBottomSheet(BuildContext context, WidgetBuilder builder) {
  return showMaterialModalBottomSheet(
    context: context,
    builder: builder,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}

Future<dynamic> editProfileBottomSheet(
  BuildContext context, 
  ProfileController profileController
) {
  profileController.nameController.text = profileController.user.value?.name ?? '';
  profileController.usernameController.text = profileController.user.value?.username ?? '';

  return modalBottomSheet(
    context,
    (builder) {
      return WillPopScope( // Menggunakan WillPopScope untuk mendeteksi pop
        onWillPop: () async {
          profileController.resetForm();
          return true; // Mengizinkan modal ditutup
        },
        child: Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: profileController.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _inputField(
                    label: 'Nama',
                    controller: profileController.nameController,
                    minLength: 3,
                    error: profileController.nameError,
                  ),
                  const SizedBox(height: 15),
                  _inputField(
                    label: 'Username',
                    controller: profileController.usernameController,
                    minLength: 3,
                    error: profileController.usernameError,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (profileController.formKey.currentState?.validate() ?? false) {
                        profileController.updateProfile(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: VColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundColor: Colors.white,
                    ),
                    child: Obx(() {
                      return profileController.isLoading.value
                          ? loadingIcon(color: VColors.white)
                          : Text(
                              'Perbarui',
                              style: TextStyle(
                                color: VColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ).whenComplete(() {
    profileController.resetForm(); // Reset saat modal ditutup
  });
}


Widget _inputField({
  required String label,
  required TextEditingController controller,
  int maxLines = 1,
  int? minLength,
  RxString? error,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: VColors.primary,
        ),
      ),
      SizedBox(height: 10),
      Obx(() {
        return TextFormField(
          controller: controller,
          maxLines: maxLines,
          cursorColor: VColors.primary,
          decoration: _inputDecoration(label).copyWith(
            errorText: error?.value.isNotEmpty == true ? error?.value : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Input ini tidak boleh kosong';
            }
            if (minLength != null && value.length < minLength) {
              return 'Minimal $minLength karakter';
            }
            return null;
          },
        );
      }),
    ],
  );
}


InputDecoration _inputDecoration(label) {
  return InputDecoration(
    filled: true,
    fillColor: VColors.border50,
    hintStyle: TextStyle(
      color: VColors.gray,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    hintText: 'Masukkan $label',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: VColors.primary,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    errorStyle: TextStyle(
      color: VColors.danger,
      fontSize: 13.5,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w500
    ),
  );
}
