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
    titleTextStyle: TextStyle(letterSpacing: 0.1, color: Colors.black, fontSize: 15),
    onTap: onTap,
  );
}

Widget _photoProfileItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: VColors.gray.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(icon, size: 30, color: VColors.primary),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: VColors.gray,
        ),
      ),
    ],
  );
}

Future<dynamic> modalBottomSheet(BuildContext context, WidgetBuilder builder, {
  bool enableDrag = true,
  bool isDismissible = true,
}) {
  return showMaterialModalBottomSheet(
    context: context,
    builder: builder,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}

Future<dynamic> photoProfileBottomSheet(
  BuildContext context,
  ProfileController profileController, {
  required String title,
}) {
  return modalBottomSheet(
    context, 
    enableDrag: false,
    isDismissible: false,
    (builder) {
      return WillPopScope(
        onWillPop: () async {
          profileController.resetForm();
          return true;
        },
        child: Obx(() {
          var photoUrl = profileController.user.value?.photoUrl;
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              profileController.resetForm();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (photoUrl.contains('photo.png') == false) {
                                // dialog konfirmasi
                                showAlertDialog(
                                  context,
                                  title: 'Hapus Foto Profil',
                                  message: 'Apakah kamu yakin ingin menghapus foto profil?',
                                  onConfirm: () {
                                    profileController.deletePhoto(context);
                                  }
                                );
                              }
                            },
                            icon: photoUrl!.contains('photo.png') ? const SizedBox() : Icon(
                              Icons.delete, 
                              color: VColors.danger,
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _photoProfileItem(
                              icon: Icons.camera_alt,
                              title: 'Kamera',
                              onTap: () {
                                profileController.pickImage(context, isCamera: true);
                              },
                            ),
                            const SizedBox(width: 20),
                            _photoProfileItem(
                              icon: Icons.photo,
                              title: 'Galeri',
                              onTap: () {
                                profileController.pickImage(context, isCamera: false);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Indikator loading
              if (profileController.isLoadingForm.value)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(VColors.primary),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      );
    }
  );
}

Future<dynamic> editPasswordBottomSheet(
  BuildContext context,
  ProfileController profileController, {
    required String title
  }
) {
  return modalBottomSheet(context, (builder) {
    return WillPopScope(
      onWillPop: () async {
        profileController.resetForm();
        return true;
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
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 20),
                _inputField(
                  label: 'Password',
                  placeholder: 'Masukkan Password Kamu',
                  controller: profileController.passwordController,
                  error: profileController.passwordError,
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                _inputField(
                  label: 'Password Baru',
                  placeholder: 'Masukkan Password Baru',
                  controller: profileController.newPasswordController,
                  minLength: 8,
                  error: profileController.newPasswordError,
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                _inputField(
                  label: 'Konfirmasi Password',
                  placeholder: 'Masukkan Ulang Password Baru',
                  controller: profileController.confirmPasswordController,
                  error: profileController.confirmPasswordError,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (profileController.formKey.currentState?.validate() ?? false) {
                      profileController.updatePassword(context);
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
                    return profileController.isLoadingForm.value
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
  });
}

Future<dynamic> editProfileBottomSheet(
  BuildContext context, 
  ProfileController profileController, {
    required String title
  }
) {
  profileController.nameController.text = profileController.user.value?.name ?? '';
  profileController.usernameController.text = profileController.user.value?.username ?? '';

  return modalBottomSheet(context, (builder) {
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
                  title,
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
                    return profileController.isLoadingForm.value
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
  }).whenComplete(() {
    profileController.resetForm(); // Reset saat modal ditutup
  });
}

Widget _inputField({
  required String label,
  required TextEditingController controller,
  String? placeholder,
  int maxLines = 1,
  int? minLength,
  RxString? error,
  bool obscureText = false,
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
          obscureText: obscureText,
          cursorColor: VColors.primary,
          decoration: _inputDecoration(label, placeholder: placeholder).copyWith(
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


InputDecoration _inputDecoration(label, {String? placeholder}) {
  return InputDecoration(
    filled: true,
    fillColor: VColors.border50,
    hintStyle: TextStyle(
      color: VColors.gray,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    hintText: placeholder ?? 'Masukkan $label',
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
