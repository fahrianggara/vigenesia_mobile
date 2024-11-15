import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:vigenesia/controller/post_controller.dart';
import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/utils/utilities.dart';
import 'package:vigenesia/components/widget.dart';

@RoutePage()
class PostAddScreen extends StatelessWidget {
  const PostAddScreen({super.key});

  static final TextEditingController titleController = TextEditingController();
  static final TextEditingController contentController = TextEditingController();
  static final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Buat Postingan'),
      body: SingleChildScrollView(
        child: Form(
          key: postController.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _inputThumbnail(),
                _selectCategory(),
                _inputField('Judul Postingan', titleController, minLength: 3),
                _inputField('Tulis Postingan', contentController, maxLines: 6, minLength: 10),
                _inputButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputThumbnail() {
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
                  color: VColors.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
                color: VColors.primary50,
              ),
              clipBehavior: Clip.hardEdge,
              child: postController.thumbnail.value != null
                ? Image.file(postController.thumbnail.value!, fit: BoxFit.contain)
                : Icon(Icons.add_a_photo, color: VColors.primary, size: 50),
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _selectCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Kategori',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: VColors.primary,
          ),
        ),
        SizedBox(height: 10),
        Obx(() {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: VColors.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField<Category>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: VColors.primary,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: VColors.primary,
              ),
              isExpanded: true,
              value: postController.selectCategory.value,
              dropdownColor: VColors.white,
              style: TextStyle(
                color: VColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              hint: Text('Pilih kategori', style: TextStyle(color: VColors.gray)),
              items: postController.categories.map((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(
                    category.name ?? 'Unknown',
                    style: TextStyle(color: VColors.primary),
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

  Widget _inputField(String label, TextEditingController controller, {
    int maxLines = 1,
    int? minLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: VColors.primary,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          cursorColor: VColors.primary,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: VColors.gray,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            hintText: label == 'Judul Postingan'
              ? 'Judul dari postingan?'
              : 'Apa yang ingin kamu bagikan?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: VColors.primary,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: VColors.primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 5),
        // add text-muted for the hint min text
        Text(
          '* Minimal $minLength karakter',
          style: TextStyle(
            color: VColors.gray,
            fontSize: 13,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }

  Widget _inputButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            postController.create(
              context,
              titleController: titleController,
              contentController: contentController,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: VColors.primary,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Obx(() {
            return postController.isLoading.value
              ? loadingIcon(color: VColors.white)
              : Text(
                  'Buat Postingan',
                  style: TextStyle(
                    color: VColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
          }),
        ),
      ),
    );
  }
}