import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/utils/colors.dart';

Widget filter() {
  return Stack(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary,
        ),
        child: Column(
          children: [
            // create a scroll x list view for categories
            SizedBox(
              height: 37,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  bool isLastItem = index == (5 - 1);

                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? 20 : 10,
                        right: isLastItem ? 20 : 0),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: HexColor('#000000').withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Kategori',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              )
            ),
          ],
        ),
      )
    ],
  );
}