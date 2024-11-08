import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/controller/home_controller.dart';

class PostsCarousel extends StatelessWidget {
  PostsCarousel({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // Memanggil getPostsCarousel() saat widget diinisialisasi
    homeController.getPostsCarousel();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Obx(() {
        return CarouselSlider(
          items: homeController.carouselPosts.map((post) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    debugPrint('Tapped on ${post.title}');
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Stack(
                      children: [
                        // Gambar sebagai latar belakang
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            post.thumbnailUrl!,
                            width: double.infinity,
                            height: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Overlay transparan di atas gambar
                        Container(
                          width: double.infinity,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        // Judul dan deskripsi
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.title!,
                                  style: TextStyle(
                                    color: AppColors.primary300,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  post.description!,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      post.category!.name!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(' • ', style: TextStyle(fontSize: 12, color: HexColor('#FFFFFF'))),
                                    Text(
                                      post.createdAtDiff!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            viewportFraction: 0.93,
          ),
        );
      }),
    );
  }
}
