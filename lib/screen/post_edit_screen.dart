import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:vigenesia/controller/post_controller.dart';
import 'package:get/get.dart';
import 'package:vigenesia/model/category.dart';
import 'package:vigenesia/model/post.dart';
import 'package:vigenesia/utils/utilities.dart';

@RoutePage()
class PostEditScreen extends StatefulWidget {
  final Post post;

  const PostEditScreen({
    required this.post,
    super.key,
  });

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final PostController postController = Get.put(PostController());

  @override
  void initState() {
    super.initState();
    // Validasi nilai awal category
    final initialCategory = postController.categories.firstWhere(
      (cat) => cat.id == widget.post.category?.id, // Cocokkan dengan ID atau atribut unik
      orElse: () => Category(id: -1, name: 'Pilih Kategori'), // Jika tidak ditemukan
    );
    postController.selectCategory.value = initialCategory;

    titleController.text = widget.post.title ?? '';
    contentController.text = widget.post.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      appBar: appBar(context, title: 'Edit Postingan'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Form(
          key: postController.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _inputThumbnail(context, post),
                const SizedBox(height: 20),
                _selectCategory(context, post.category),
                const SizedBox(height: 20),
                _inputField(context, post, 
                  label: 'Judul Postingan', 
                  controller: titleController, 
                  minLength: 3
                ),
                const SizedBox(height: 20),
                _inputField(context, post, 
                  label: 'Tulis Postingan', 
                  controller: contentController, 
                  maxLines: 6, 
                  minLength: 10
                ),
                const SizedBox(height: 20),
                _inputButton(context, post),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputThumbnail(BuildContext context, Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: postController.pickAndCropImage,
          child: Obx(() {
            final thumbnail = postController.thumbnail.value;
            final thumbnailUrl = post.thumbnailUrl;

            return Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              clipBehavior: Clip.hardEdge,
              child: thumbnail != null
                  ? Image.file(
                      thumbnail,
                      fit: BoxFit.cover,
                    )
                  : (thumbnailUrl != null && !thumbnailUrl.contains('thumbnail.png'))
                      ? Image.network(
                          thumbnailUrl,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.add_a_photo, color: VColors.primary, size: 50),
            );
          }),
        ),
      ],
    );
  }

  Widget _selectCategory(BuildContext context, Category? category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kategori Postingan', style: TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.bold, 
          color: VColors.primary
        )),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Obx(() {
            return DropdownButtonFormField<Category>(
              isExpanded: true,
              value: postController.selectCategory.value,
              dropdownColor: Theme.of(context).colorScheme.primaryContainer,
              style: TextStyle(
                color: VColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              onChanged: (Category? selected) {
                postController.setSelectedCategory(selected);
              },
              items: postController.categories.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name ?? ''),
                );
              }).toList(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _inputField(BuildContext context, Post post, {
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    int? minLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          decoration: _inputDecoration(context, label),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Input ini tidak boleh kosong';
            }
            if (minLength != null && value.length < minLength) {
              return 'Minimal $minLength karakter';
            }
            return null;
          },
        ),
        SizedBox(height: 5),
        if (minLength != null)
          Text(
            '* Minimal $minLength karakter',
            style: TextStyle(
              color: VColors.gray,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  InputDecoration _inputDecoration(BuildContext context, label) {
    return InputDecoration(
      filled: true,
      fillColor: Theme.of(context).colorScheme.primaryContainer,
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
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder:  OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorStyle: TextStyle(
        color: Theme.of(context).colorScheme.error,
        fontSize: 13.5,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w500
      ),
    );
  }

  Widget _inputButton(BuildContext context, Post post) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (postController.formKey.currentState?.validate() ?? false) {
            postController.edit(
              context,
              titleController: titleController,
              contentController: contentController,
              postId: post.id,
            );
          } else {
            Get.snackbar('Error', 'Form tidak valid. Silakan periksa kembali.');
          }
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
                  'Edit Postingan',
                  style: TextStyle(
                    color: VColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
        }),
      ),
    );
  }
}
