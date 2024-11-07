import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vigenesia/controller/category_controller.dart';
import 'package:vigenesia/models/category.dart';
import 'package:vigenesia/utils/colors.dart';

class FetchCategories extends StatefulWidget {
  const FetchCategories({super.key});

  @override
  State<FetchCategories> createState() => _FetchCategoriesState();
}

class _FetchCategoriesState extends State<FetchCategories> {
  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetch().then((res) => {
      setState(() {
        categories = res.data as List<Category>;
        isLoading = false;
      })
    }).catchError((err) => {
      setState(() {
        isLoading = false;
      }),
      print(err)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 37,
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : getCategories(categories),
              )
            ],
          ),
        )
      ],
    );
  }
}

Widget getCategories(List<Category> categories) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (context, index) {
      bool isLastItem = index == (categories.length - 1);
      return Container(
        margin: EdgeInsets.only(
            left: index == 0 ? 20 : 10, right: isLastItem ? 20 : 0),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: HexColor('#000000').withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            '${categories[index].name} (${categories[index].postsCount})',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    },
  );
}

