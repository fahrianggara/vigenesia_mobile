part of 'utilities.dart';

void dd(dynamic data) {
  debugPrint(data.toString());
}

void notify({
  context,
  required Widget message,
  String? type
}) {

  var background = VColors.blue;

  if (type == 'warning') {
    background = VColors.warning;
  } else if (type == 'danger') {
    background = VColors.danger;
  } else if (type == 'success') {
    background = VColors.primary;
  } else if (type == 'secondary') {
    background = VColors.gray;
  }

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: message,
    backgroundColor: background,
    duration: Duration(seconds: 4),
  ));
}

void showNotification(BuildContext context, String message, String type) {
  notify(
    context: context,
    message: Text(message),
    type: type,
  );
}