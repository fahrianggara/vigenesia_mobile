import 'package:flutter/material.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:vigenesia/controller/user_controller.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'bottom_sheet.dart';
import 'package:vigenesia/screen/profile_photo_screen.dart';

Future<dynamic> userShowBottomSheet(
  BuildContext context,
  Post post,
  UserController userController
) {
  return modalBottomSheet(context, (builder) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: appBar(context, title: "Detail Pengguna", titleColor: Theme.of(context).colorScheme.onSurface),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePhotoScreen(user: post.user!),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 20),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(post.user!.photoUrl ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 27),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              post.user!.name ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              post.user!.username ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  });
}