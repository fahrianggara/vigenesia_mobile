import 'package:get/get.dart';
import 'package:vigenesia/screen/home_screen.dart';

class MobileRoute {
  static final pages = [
    GetPage(name: '/', page: () => HomeScreen())
  ];
}