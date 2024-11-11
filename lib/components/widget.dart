import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/controller/auth_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';

// Screen for users who are not logged in
Widget profileNoAuth(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20.0),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Images.vectorAuth,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 30),
        Text(
          'Hmm.. belum login?',
          style: TextStyle(fontSize: 18, color: VColors.primary, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Sepertinya kamu belum login nih.. Silahkan login terlebih dahulu ya.',
          style: TextStyle(fontSize: 16, color: VColors.gray),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context.pushRoute(LoginRoute()); // Navigate to login
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            backgroundColor: VColors.primary,
            foregroundColor: VColors.primary50,
          ),
          child: Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ],
    ),
  );
}

Widget loadingIcon({
  double? width,
  double? heigth,
  Color? color,
  double? stroke
}) {
  return SizedBox(
    width: width ?? 20,
    height: heigth ?? 20,
    child: CircularProgressIndicator(
      color: color ?? Colors.white,
      strokeWidth: stroke ?? 3,
    ),
  );
}

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  required String errorMessage,
  bool obscureText = false,
  String? Function(String?)? validator,
  TextInputType? keyboardType
}) {
  return TextFormField(
    controller: controller,
    validator: validator ?? (val) => val!.isEmpty ? errorMessage : null,
    keyboardType: keyboardType,
    decoration: authInputDecoration(
      hintText,
      prefixIcon: Icon(icon, color: VColors.primary),
    ),
    obscureText: obscureText,
    cursorColor: VColors.primary,
  );
}

/// custom input decoration
InputDecoration authInputDecoration(String label,{
    String? errorText, 
    Icon? prefixIcon
  }) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    labelText: label,
    floatingLabelStyle: TextStyle(
      color: errorText == null ? VColors.primary : VColors.danger
    ),
    labelStyle: TextStyle(
      color: errorText == null ? VColors.primary : VColors.danger,
      letterSpacing: 0.2
    ),
    errorText: errorText,
    errorStyle: TextStyle(
      color: VColors.danger,
      fontSize: 13.5,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w500
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: VColors.border),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: VColors.primary, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: VColors.danger, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: VColors.danger, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

Widget postItem({
  required int index,
  required int id,
  required String imageUrl,
  required String title,
  required String description,
  required String category,
  required String createdAt
}) {

  // Declare the image variable here
  Widget image;

  // Assign the appropriate image based on the imageUrl
  if (imageUrl.isEmpty) {
    image = Image.asset(
      Images.background,
      fit: BoxFit.cover,
      width: double.infinity,
    );
  } else {
    image = Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }

  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: index == 0 ? 10 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: image,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: '',
                    letterSpacing: 0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: HexColor('#000000').withOpacity(0.5),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 12,
                          color: VColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow:
                            TextOverflow.ellipsis, // Overflow dengan elipsis
                        maxLines: 1, // Membatasi teks menjadi satu baris
                      ),
                    ),
                    Text(
                      ' • ',
                      style: TextStyle(
                        fontSize: 12,
                        color: HexColor('#000000').withOpacity(0.5),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        createdAt,
                        style: TextStyle(
                          fontSize: 12,
                          color: VColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow:
                            TextOverflow.ellipsis, // Overflow dengan elipsis
                        maxLines: 1, // Membatasi teks menjadi satu baris
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}