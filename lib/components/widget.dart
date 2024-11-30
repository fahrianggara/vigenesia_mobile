import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/controller/profile_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:get/get.dart';

Future<void> showAlertDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmText,
  String? cancelText,
  required Function onConfirm,
  Function? onCancel,
}) {
  return showDialog(
    context: context, // Always use the provided context
    builder: (BuildContext dialogContext) { // Use dialogContext in dialog
      return AlertDialog(
        title: Text(title),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              if (onCancel != null) {
                onCancel();
              }
              Navigator.of(dialogContext).pop(); // Use dialogContext
            },
            child: Text(
              cancelText ?? 'Tidak', 
              style: TextStyle(
                fontSize: 15, 
                color: Theme.of(context).colorScheme.error
              )
            ),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(dialogContext).pop(); // Use dialogContext
            },
            child: Text(confirmText ?? 'Ya', style: TextStyle(fontSize: 15, color: VColors.primary)),
          ),
        ],
      );
    },
  );
}



Widget postIsNull() {
  return Scaffold(
    appBar: AppBar(
      title: Skeletonizer(
        enabled: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 19,
              backgroundImage: AssetImage(
                Images.background2,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,  // Ensures the Column only takes the needed space
              children: [
                Text(
                  'Nama Pengguna',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 15,
                    color: VColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '@username',
                  style: TextStyle(fontSize: 12, color: VColors.border500),
                ),
              ],
            ),
          ],
        ),
      ),
      elevation: 0,
      titleSpacing: 0,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeletonizer(
            enabled: true,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.background2),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Judul Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Deskripsi post',
                    style: TextStyle(
                      color: VColors.primary100,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Skeletonizer(
              enabled: true,
              child: Row(
                children: [
                  Text(
                    'Kategori Kategori',
                    style: TextStyle(
                      color: VColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ' • ',
                    style: TextStyle(
                      color: VColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '1 jam yang lalu',
                    style: TextStyle(
                      color: VColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Skeletonizer(
            enabled: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ini adalah Judul',
                style: TextStyle(
                  color: VColors.gray,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Skeletonizer(
            enabled: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ini adalah deskripsi post yang panjang sekali, dan akan di potong oleh sistem agar tidak terlalu panjang. Lorem ipsum dolor sit amet, consectetur adipiscing elit\n\nIni adalah deskripsi post yang panjang sekali, dan akan di potong oleh sistem agar tidak terlalu panjang. Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                style: TextStyle(
                  color: VColors.gray,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget categoryIsNull() {
  return Scaffold(
    appBar: AppBar(
      title: Skeletonizer(
        enabled: true,
        child: Text(
          'Kategori Post',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: VColors.primary,
          ),
        ),
      ),
      elevation: 0,
      titleSpacing: 0,
    ),
    body: SingleChildScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeletonizer(
            enabled: true,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.background2),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kategori',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Deskripsi kategori',
                    style: TextStyle(
                      color: VColors.primary100,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Skeletonizer(
            enabled: true,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return postItem(
                  context,
                  index: index,
                  id: 0,
                  imageUrl: '',
                  title: 'Judul Post',
                  description: 'Deskripsi post',
                  category: 'Kategori',
                  createdAt: '1 jam yang lalu',
                  stack: 0,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget loadingPostItem() {
  return Skeletonizer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Ada 1 postingan yang ditemukan',
            style: TextStyle(
              color: VColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5, // Menampilkan 5 item dummy saat loading
          itemBuilder: (context, index) {
            return postItem(
              context,
              index: index,
              id: 0, // Placeholder untuk id
              imageUrl: '', // Placeholder untuk gambar
              title: 'Loading...', // Placeholder untuk judul
              description: 'Loading...', // Placeholder untuk deskripsi
              category: 'Loading...', // Placeholder untuk kategori
              createdAt: 'Loading...', // Placeholder untuk waktu dibuat
              stack: 0, // Placeholder untuk stack
            );
          },
        ),
      ],
    ),
  );
}

AppBar appBar(BuildContext context, {
  required String title,
  List<Widget>? actions,
  Color? backgroundColor,
  Color? titleColor,
  double? fontSize,
  FontWeight? fontWeight,
  Widget? leading,
}) {
  return AppBar(
    leading: leading,
    titleSpacing: 0,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    elevation: 0,
    scrolledUnderElevation: 0,
    title: Text(
      title,
      style: TextStyle(
        color: titleColor ?? VColors.primary,
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ??FontWeight.bold,
      ),
    ),
    actions: actions,
  );
}

Widget userInfo(
  ProfileController profileController, {
  double avatarRadius = 30,
  bool isInAppBar = false,
  VoidCallback? onTapImage, // Parameter baru untuk aksi klik gambar
}) {
  return Obx(() {
    final user = profileController.user.value;
    final isLoading = user == null || profileController.isLoading.value;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Avatar Skeleton
        Skeletonizer(
          enabled: isLoading,
          child: GestureDetector(
            onTap: isInAppBar
                ? null // Tidak ada aksi jika isInAppBar true
                : onTapImage, // Gunakan parameter onTapImage
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundImage: NetworkImage(user?.photoUrl ?? 'https://via.placeholder.com/150'),
            ),
          ),
        ),
        SizedBox(width: isInAppBar ? 10 : 18),

        // User Info Skeleton
        Skeletonizer(
          enabled: isLoading,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  user?.name ?? 'User Name',
                  style: TextStyle(
                    fontSize: isInAppBar ? 15 : 18,
                    fontWeight: FontWeight.bold,
                    color: isInAppBar ? Colors.white : Colors.white,
                  ),
                ),
                if (!isInAppBar) ...[
                  const SizedBox(height: 2),
                  Text(
                    '@${user?.username ?? 'username'}',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  });
}


Widget emptyPosts({
  String title = "Postingan Kosong??",
  String sub = "Waduh.. postingan kamu kosong nih, ayo buat.. gratis kok!"
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    child: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Images.vectorEmpty,
            width: 220,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(fontSize: 18, color: VColors.primary, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            sub,
            style: TextStyle(fontSize: 16, color: VColors.gray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

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
          style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimaryContainer),
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

Widget buildTextField(BuildContext context, {
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
      context,
      hintText,
      prefixIcon: Icon(icon, color: VColors.primary),
    ),
    obscureText: obscureText,
    cursorColor: VColors.primary,
  );
}

/// custom input decoration
InputDecoration authInputDecoration(BuildContext context, label,{
    String? errorText, 
    Icon? prefixIcon
  }) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    labelText: label,
    floatingLabelStyle: TextStyle(
      color: errorText == null ? VColors.primary : Theme.of(context).colorScheme.error
    ),
    labelStyle: TextStyle(
      color: errorText == null ? VColors.primary : Theme.of(context).colorScheme.error,
      letterSpacing: 0.2
    ),
    errorText: errorText,
    errorStyle: TextStyle(
      color: Theme.of(context).colorScheme.error,
      fontSize: 13.5,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w500
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

Widget postItem(BuildContext context, {
  required int index,
  required int id,
  required String imageUrl,
  required String title,
  required String description,
  required String category,
  required String createdAt,
  required int stack, // Tambahkan parameter stack untuk navigasi
  Color? titleColor,
}) {

  // Declare the image variable here
  Widget image;
  final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
    onTap: () {
      var stacks = stack.toString();
      AutoRouter.of(context).popAndPush(PostShowRoute(id: id, stack: stacks));
    },
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
                    letterSpacing: 0.1,      
                    color: titleColor ?? colorScheme.onSurface,            
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
                    color: colorScheme.onSecondaryContainer,
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
                        overflow: TextOverflow.ellipsis, // Overflow dengan elipsis
                        maxLines: 1, // Membatasi teks menjadi satu baris
                      ),
                    ),
                    Text(
                      ' • ',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        createdAt,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSecondaryContainer,
                        ),
                        overflow: TextOverflow.ellipsis, // Overflow dengan elipsis
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