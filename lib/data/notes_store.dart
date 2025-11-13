import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final String date; // ISO8601 string

  Note({required this.id, required this.title, required this.content, required this.date});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date,
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'] as String,
        title: json['title'] as String,
        content: json['content'] as String,
        date: json['date'] as String,
      );
}

class NotesStore {
  NotesStore._internal();
  static final NotesStore instance = NotesStore._internal();

  static const _prefsKey = 'notes_json';

  final ValueNotifier<List<Note>> notes = ValueNotifier<List<Note>>(<Note>[]);
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
        notes.value = decoded.map((e) => Note.fromJson(Map<String, dynamic>.from(e as Map))).toList();
      } catch (_) {
        notes.value = <Note>[];
      }
    }
    _initialized = true;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(notes.value.map((n) => n.toJson()).toList());
    await prefs.setString(_prefsKey, encoded);
  }

  Future<Note> addNote({required String title, required String content}) async {
    await init();
    final now = DateTime.now();
    final note = Note(
      id: now.millisecondsSinceEpoch.toString(),
      title: title.trim(),
      content: content.trim(),
      date: now.toIso8601String(),
    );
    final next = List<Note>.from(notes.value)..insert(0, note);
    notes.value = next;
    await _persist();
    return note;
  }

  Note? getById(String id) {
    final list = notes.value;
    for (final n in list) {
      if (n.id == id) return n;
    }
    return null;
  }

  Future<void> deleteById(String id) async {
    await init();
    notes.value = notes.value.where((n) => n.id != id).toList();
    await _persist();
  }

  Future<void> updateNote(Note updated) async {
    await init();
    final idx = notes.value.indexWhere((n) => n.id == updated.id);
    if (idx != -1) {
      final list = List<Note>.from(notes.value);
      list[idx] = updated;
      notes.value = list;
      await _persist();
    }
  }
}
