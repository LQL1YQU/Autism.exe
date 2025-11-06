import 'package:flutter/material.dart';
import 'package:note/components/app_bar_navigation_back.dart';

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
      body: Center(child: Text("Note Screen id: ${widget.id}")),
    );
  }
}
