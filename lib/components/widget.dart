import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/utils/utilities.dart';

Widget postItem({
  required int index,
  required int id,
  required String imageUrl,
  required String title,
  required String description,
  required String category,
  required String createdAt
}) {

  // Declare the image variable here
  Widget image;

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
    onTap: () {},
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
                    fontFamily: '',
                    letterSpacing: 0.1,
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
                        category,
                        style: TextStyle(
                          fontSize: 12,
                          color: VColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow:
                            TextOverflow.ellipsis, // Overflow dengan elipsis
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
                        createdAt,
                        style: TextStyle(
                          fontSize: 12,
                          color: VColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow:
                            TextOverflow.ellipsis, // Overflow dengan elipsis
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