import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'data/notes_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesStore.instance.init();
  runApp(MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}
