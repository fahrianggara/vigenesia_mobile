import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vigenesia/components/widget.dart';
import 'package:vigenesia/model/post.dart';

@RoutePage()
class PostshowScreen extends StatelessWidget {
  final int? id;
  const PostshowScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Post Detail'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Post ID: $id'),
            ElevatedButton(
              onPressed: () {
                context.maybePop(true);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}