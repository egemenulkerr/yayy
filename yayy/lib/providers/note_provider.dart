import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteProvider with ChangeNotifier {
  final List<String> _notes = [];

  List<String> get notes => _notes;

  NoteProvider() {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final storedNotes = prefs.getStringList('notes');
    if (storedNotes != null) {
      _notes.clear();
      _notes.addAll(storedNotes);
      notifyListeners();
    }
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', _notes);
  }

  void addNote(String note) {
    _notes.add(note);
    _saveNotes();
    notifyListeners();
  }

  void removeNote(int index) {
    _notes.removeAt(index);
    _saveNotes();
    notifyListeners();
  }

  void clearNotes() {
    _notes.clear();
    _saveNotes();
    notifyListeners();
  }
}
