import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vigenesia/controller/home_controller.dart';
import 'package:vigenesia/routes/app_route.gr.dart';
import 'package:vigenesia/screen/postshow_screen.dart';
import 'package:vigenesia/utils/utilities.dart';

class Carousels extends StatelessWidget {
  Carousels({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // Fetch carousel posts on build
    homeController.getCarouselPosts();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Obx(() {
        // Check if loading
        if (homeController.isLoading.value) {
          return _buildLoadingCarousel();
        }

        // Check if data is empty
        if (homeController.carouselPosts.isEmpty) {
          return _buildEmptyState();
        }

        // Display the carousel with posts
        return _buildCarouselWithPosts(context);
      }),
    );
  }

  // Build loading state with skeletons
  Widget _buildLoadingCarousel() {
    return CarouselSlider(
      items: List.generate(4, (index) => Skeletonizer(
          child: Image.asset(
            Images.background, // Replace with your network image URL
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
        ),
      ),
      options: CarouselOptions(
        height: 200,
        autoPlay: false,
        viewportFraction: 0.93,
      ),
    );
  }

  // Build empty state
  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No posts available',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  // Build carousel with posts
  Widget _buildCarouselWithPosts(BuildContext context) {
    return CarouselSlider(
      items: homeController.carouselPosts.toList().map((post) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                AutoRouter.of(context);
                context.pushRoute(PostshowRoute(id: post.id));
              },
              child: _buildCarouselItem(context, post),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        aspectRatio: 16 / 9,
        viewportFraction: 0.93,
      ),
    );
  }

  // Build each carousel item
  Widget _buildCarouselItem(BuildContext context, var post) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
          // Image as background
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              post.thumbnailUrl ?? '',
              width: double.infinity,
              height: double.maxFinite,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                return progress == null
                  ? child
                  : Skeletonizer(
                      child: Container(
                        width: double.infinity,
                        height: double.maxFinite,
                        color: Colors.grey[300],
                      ),
                    );
              },
            ),
          ),
          // Overlay with title and description
          Container(
            width: double.infinity,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildCarouselText(post),
            ),
          ),
        ],
      ),
    );
  }

  // Build title, description, and other post details
  Widget _buildCarouselText(var post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title ?? 'No title',
          style: TextStyle(
            color: VColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Text(
          post.description ?? 'No description',
          style: TextStyle(
            color: VColors.white,
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              post.category?.name ?? 'No category',
              style: TextStyle(
                fontSize: 12,
                color: VColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(' • ', style: TextStyle(fontSize: 12, color: HexColor('#FFFFFF'))),
            Text(
              post.createdAtDiff ?? '',
              style: TextStyle(
                fontSize: 12,
                color: VColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

