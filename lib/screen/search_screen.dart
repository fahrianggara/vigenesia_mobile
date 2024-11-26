import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:vigenesia/controller/search_controller.dart' as search_controllers;
import 'package:vigenesia/utils/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static final searchController = Get.put(search_controllers.SearchController());
  static final TextEditingController searchInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: searchInput,
                    onFieldSubmitted: (query) {
                      searchController.search(query);
                    },
                    textInputAction: TextInputAction.search,
                    cursorColor: VColors.primary,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                      hintText: 'Cari postingan...',
                      prefixIconColor: VColors.primary,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: _searchContent(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _searchContent(BuildContext context) {
    return Obx(() {
      if (searchController.isLoading.value) {
        return Skeletonizer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Ada 1 postingan yang ditemukan',
                  style: TextStyle(
                    color: VColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5, // Menampilkan 5 item dummy saat loading
                itemBuilder: (context, index) {
                  return postItem(
                    context,
                    index: index,
                    id: 0, // Placeholder untuk id
                    imageUrl: '', // Placeholder untuk gambar
                    title: 'Loading...', // Placeholder untuk judul
                    description: 'Loading...', // Placeholder untuk deskripsi
                    category: 'Loading...', // Placeholder untuk kategori
                    createdAt: 'Loading...', // Placeholder untuk waktu dibuat
                  );
                },
              ),
            ],
          ),
        );
      }

      // Show search not found message
      if (searchController.notFound.value) {
        return _searchNotFound(context);
      }

      // Show search placeholder when no query has been made yet
      else if (!searchController.hasQuery.value && searchInput.text.isEmpty) {
        return _search(context);
      } 
      
      // Show search results
      else {
        final data = searchController.searchResults;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ada ${data.length} postingan yang ditemukan',
                style: TextStyle(
                  color: VColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return postItem(
                  context,
                  index: index,
                  id: data[index].id!,
                  imageUrl: data[index].thumbnailUrl!,
                  title: data[index].title!,
                  description: data[index].description!,
                  category: data[index].category!.name!,
                  createdAt: data[index].createdAtDiff!,
                );
              },
            ),
          ],
        );
      }
    });
  }

  Widget _searchNotFound(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.vectorSearchNotFound, width: 400),
          SizedBox(height: 25),
          Text(
            'Postingan Tidak Ditemukan',
            style: TextStyle(
              fontSize: 18,
              color: VColors.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Maaf, postingan yang kamu cari tidak ditemukan! Silakan coba kata kunci lain.',
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _search(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.vectorSearch, width: 300),
          SizedBox(height: 20),
          Text(
            'Apa yang kamu cari hari ini?',
            style: TextStyle(
              fontSize: 18,
              color: VColors.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Silakan cari postingan yang kamu inginkan dengan mengetik kata kunci di kolom pencarian di atas.',
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.onPrimaryContainer
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

