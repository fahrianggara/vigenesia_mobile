import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/utils/colors.dart';

Widget carousel() {
    final List<Map<String, String>> items = [
      {
        'image': 'https://picsum.photos/250?image=10',
        'title': 'Carousel Item 1',
        'description': 'lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'image': 'https://picsum.photos/250?image=11',
        'title': 'Carousel Item 2',
        'description': 'Description for item 2'
      },
      {
        'image': 'https://picsum.photos/250?image=12',
        'title': 'Carousel Item 3',
        'description': 'Description for item 3'
      },
      {
        'image': 'https://picsum.photos/250?image=13',
        'title': 'Carousel Item 4',
        'description': 'Description for item 4'
      },
      {
        'image': 'https://picsum.photos/250?image=14',
        'title': 'Carousel Item 5',
        'description': 'Description for item 5'
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: CarouselSlider(
        items: items.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  debugPrint('Tapped on ${item['title']}');
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
                          item['image']!,
                          width: double.infinity,
                          height: double.maxFinite, // Sesuaikan tinggi gambar
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Overlay transparan di atas gambar
                      Container(
                        width: double.infinity,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4), // Overlay warna hitam dengan transparansi
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
                                item['title']!,
                                style: TextStyle(
                                  color: AppColors.primary300,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item['description']!,
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
                                    'Kategori' ,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text (' • ', style: TextStyle(fontSize: 12, color: HexColor('#FFFFFF'))),
                                  Text(
                                    '1 jam yang lalu',
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
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 6),
          viewportFraction: 0.92,
        ),
      ),
    );
  }