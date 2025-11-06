import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note/components/app_bar_main.dart';
import 'package:note/utils/constants.dart';
import 'package:note/components/note_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(username: "Username", avatarUrl: defaultAvatarUrl),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          itemCount: 10,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemBuilder: (context, index) {
            return const NoteItem(
              date: "2022-01-01",
              title: "Note 1",
              content: "Content 1",
              id: "1",
            );
          },
        ),
      ),
    );
  }
}
