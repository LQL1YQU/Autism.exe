import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note/components/app_bar_main.dart';
import 'package:note/utils/constants.dart';
import 'package:note/components/note_item.dart';
import 'package:note/screens/create_note_screen.dart';
import 'package:note/data/notes_store.dart';

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
        child: ValueListenableBuilder<List<Note>>(
          valueListenable: NotesStore.instance.notes,
          builder: (context, list, _) {
            if (list.isEmpty) {
              return const Center(child: Text('No notes yet. Tap + to create.'));
            }
            return MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: list.length,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemBuilder: (context, index) {
                final n = list[index];
                return NoteItem(
                  date: n.date.split('T').first,
                  title: n.title,
                  content: n.content,
                  id: n.id,
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNoteScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Create Note'),
      ),
    );
  }
}
