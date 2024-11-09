import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/models/category.dart';
import 'package:vigenesia/utils/colors.dart';
import 'package:vigenesia/controller/post_controller.dart';

class PostCreate extends StatelessWidget {
  final _contentController = TextEditingController();
  final _titleController = TextEditingController();
  final postController = Get.put(PostController());

  PostCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            'Buat Postingan',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildThumbnail(),
                  _buildCategoryDropdown(),
                  _buildInputField('Judul Postingan', _titleController),
                  _buildInputField('Tulis Postingan', _contentController, maxLines: 6),
                  _buildPostButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return InkWell(
            onTap: postController.pickAndCropImage,
            child: Container(
              
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary50,
              ),
              clipBehavior: Clip.hardEdge, // Ensures image doesn't overflow
              child: postController.imageFile.value != null
                  ? Image.file(
                      postController.imageFile.value!,
                      fit: BoxFit.contain, // Ensures image fits within the container without overflow
                    )
                  : Icon(
                      Icons.add_a_photo,
                      color: AppColors.primary,
                      size: 50,
                    ),
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  // Builds the category dropdown widget
  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Kategori',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 10),
        Obx(() {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<Category>(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.primary,
              ),
              isExpanded: true,
              value: postController.selectedCategory.value,
              dropdownColor: AppColors.white,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              hint: Text('Pilih kategori'),
              items: postController.categories.map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(
                    category.name ?? 'Unknown',
                    style: TextStyle(color: AppColors.primary),
                  ),
                );
              }).toList(),
              onChanged: (Category? newValue) {
                postController.setSelectedCategory(newValue);
              },
            ),
          );
        }),
      ],
    );
  }

  // Builds the input field for title or content
  Widget _buildInputField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          label,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: label == 'Judul Postingan'
                ? 'Judul dari postingan?'
                : 'Apa yang ingin Anda bagikan?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // Builds the Post button
  Widget _buildPostButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            // Add logic to save the post here
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.primary,
          ),
          child: Text('Posting', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
