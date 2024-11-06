import 'package:flutter/material.dart';
import 'package:vigenesia/utils/colors.dart';

// custom text widget
Widget customText({required String text, required TextStyle style}) {
  return Text(
    text,
    style: style,
  );
}

/// custom input decoration
InputDecoration authInputDecoration(String label, {String? errorText, Icon? prefixIcon}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    labelText: label,
    floatingLabelStyle: TextStyle(color: errorText == null ? AppColors.primary : AppColors.danger),
    labelStyle: TextStyle(color: errorText == null ? AppColors.primary : AppColors.danger),
    errorText: errorText,
    errorStyle: TextStyle(color: AppColors.danger),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.border),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.danger, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.danger, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

