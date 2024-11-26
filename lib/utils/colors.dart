part of 'utilities.dart';

class VColors {
  static var border     = HexColor('#DDDDDD');
  static var border50   = HexColor('#000000').withOpacity(0.05);
  static var border500  = HexColor('#B0B0B0');
  static var white      = HexColor('#FFFFFF');
  static var text       = HexColor('#00331e');  
  static var danger     = HexColor('#C91432');
  static var warning    = HexColor('#FFCC00');
  static var blue       = HexColor('#0275DB');
  static var gray       = HexColor('#6c757d');
  static var primary    = HexColor('#05B465');
  static var primary50  = HexColor('#F1FFF8');
  static var primary100 = HexColor('#d8ffed');
  static var primary200 = HexColor('#b4fedb');
  static var primary300 = HexColor('#79fcbf');
  static var primary400 = HexColor('#38f09b');
  static var primary500 = HexColor('#0ed57a');
  static var primary700 = HexColor('#00331e');
  static var primary800 = HexColor('#0c6f43');
  static var primary900 = HexColor('#0c5b39');
  static var primary950 = HexColor('#00331e');
  static var background = HexColor('#F9F9F9');
}

var lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: VColors.primary,
  onPrimary: VColors.white,
  primaryContainer: Colors.grey[200],
  onPrimaryContainer: VColors.text,
  secondary: Colors.white,
  onSecondary: VColors.text,
  onSecondaryContainer: VColors.gray,
  error: Color(0xFFC91432),
  onError: Color(0xFFFFFFFF),
  surface: VColors.background,
  onSurface: Color(0xFF000000),
  errorContainer: Colors.red[100],
  onErrorContainer: Color(0xFFFFFFFF),
  outline: VColors.border
);  

var darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: VColors.primary,
  onPrimary: VColors.white,
  primaryContainer: Color.fromARGB(255, 31, 31, 31),
  onPrimaryContainer: Color.fromARGB(255, 187, 187, 187),
  secondary: Color.fromARGB(255, 28, 28, 28),
  onSecondary: Color(0xFFFFFFFF),
  onSecondaryContainer: Color.fromARGB(255, 193, 193, 193),
  error: Color.fromARGB(255, 236, 51, 38),
  onError: Color(0xFFFFFFFF),
  surface: Color.fromARGB(255, 24, 24, 24),
  onSurface: Color(0xFFFFFFFF),
  errorContainer: Color.fromARGB(255, 64, 29, 29),
  onErrorContainer: Color(0xFFFFFFFF),
  outline: Color.fromARGB(255, 49, 49, 49)
);