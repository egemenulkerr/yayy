import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// NoteProvider sınıfı, uygulama genelinde notları yönetmek için bir provider'dır.
class NoteProvider with ChangeNotifier {
  // Uygulama içindeki notları tutan özel bir liste
  final List<String> _notes = [];

  // Notların dışarıdan sadece okunabilmesi için getter tanımlanmış
  List<String> get notes => _notes;

  // Constructor: Nesne oluşturulurken cihazdaki kayıtlı notları yükler
  NoteProvider() {
    _loadNotes();
  }

  // SharedPreferences'tan notları asenkron şekilde yükler
  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final storedNotes = prefs.getStringList('notes');

    // Eğer kayıtlı notlar varsa, listeyi günceller ve dinleyicilere haber verir
    if (storedNotes != null) {
      _notes.clear();
      _notes.addAll(storedNotes);
      notifyListeners(); // UI’yi güncellemek için
    }
  }

  // Notları SharedPreferences’a kaydeder
  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notes', _notes);
  }

  // Yeni bir not ekler, kaydeder ve dinleyicilere haber verir
  void addNote(String note) {
    _notes.add(note);
    _saveNotes();
    notifyListeners();
  }

  // Belirtilen index’teki notu siler, kaydeder ve dinleyicilere haber verir
  void removeNote(int index) {
    _notes.removeAt(index);
    _saveNotes();
    notifyListeners();
  }

  // Tüm notları siler, kaydeder ve UI’yi günceller
  void clearNotes() {
    _notes.clear();
    _saveNotes();
    notifyListeners();
  }
}
