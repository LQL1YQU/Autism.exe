import 'package:flutter/material.dart';
import 'package:note/components/app_bar_navigation_back.dart';
import 'package:note/data/notes_store.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key, required this.id});

  final String id;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNavigationBack(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder<List<Note>>(
          valueListenable: NotesStore.instance.notes,
          builder: (context, list, _) {
            final note = NotesStore.instance.getById(widget.id);
            if (note == null) {
              return const Center(child: Text('Note not found'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(note.date.split('T').first, style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(note.content),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
