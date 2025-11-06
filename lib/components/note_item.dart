import 'package:flutter/material.dart';
import 'package:note/screens/note_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({
    super.key,
    required this.date,
    required this.title,
    required this.content,
    required this.id,
  });

  final String date;
  final String title;
  final String content;
  final String id;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pref = await SharedPreferences.getInstance();
        await pref.setString("note_id", widget.id);
        print("note_id: ${widget.id}");
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoteScreen(id: widget.id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
              child: Text(
                widget.date,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(widget.content),
          ],
        ),
      ),
    );
  }
}
