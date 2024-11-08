import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:get/get.dart';

class Posts extends StatelessWidget {
  Posts({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.getPosts();

    return Container(
      child: Obx(() {
        if (homeController.posts.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeController.posts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Tambahkan aksi yang diinginkan di sini.
                print("Item ${homeController.posts[index].title} di klik");
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
                        child: Image.network(
                          homeController.posts[index].thumbnailUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeController.posts[index].title!,
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
                            homeController.posts[index].description!,
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
                                  homeController.posts[index].category!.name!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
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
                                  color: HexColor('#000000').withOpacity(0.5),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  homeController.posts[index].createdAtDiff!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
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
          },
        );
      }),
    );
  }
}
