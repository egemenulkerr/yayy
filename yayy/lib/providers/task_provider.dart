import 'dart:convert'; // Görev listesini JSON formatına çevirmek için
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Görev yönetimi sağlayan provider sınıfı
class TaskProvider with ChangeNotifier {
  // Aktif görevleri tutan liste (her görev bir Map)
  final List<Map<String, dynamic>> _activeTasks = [];

  // Görevleri dışarıdan sadece okunabilir şekilde sunar
  List<Map<String, dynamic>> get activeTasks => _activeTasks;

  // Constructor: oluşturulurken kayıtlı görevleri yükler
  TaskProvider() {
    _loadTasks();
  }

  // Cihazdan görevleri SharedPreferences ile yükler
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('active_tasks');

    // Eğer veri varsa, decode edip listeye aktarır
    if (data != null) {
      final List decoded = jsonDecode(data);
      _activeTasks.clear();
      _activeTasks.addAll(decoded.map((e) => Map<String, dynamic>.from(e)));
      notifyListeners(); // UI’ye haber verir
    }
  }

  // Görev listesini SharedPreferences'a JSON formatında kaydeder
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_activeTasks);
    await prefs.setString('active_tasks', encoded);
  }

  // Yeni bir görev ekler ve günceller
  void addTask(String title, String desc, {String type = "Belirtilmedi"}) {
    _activeTasks.add({
      "title": title,
      "desc": desc,
      "type": type,
    });
    _saveTasks(); // Kalıcı olarak kaydet
    notifyListeners(); // UI'yi güncelle
  }

  // Belirtilen index’teki görevi siler
  void removeTask(int index) {
    _activeTasks.removeAt(index);
    _saveTasks();
    notifyListeners();
  }

  // Tüm görevleri temizler
  void clearTasks() {
    _activeTasks.clear();
    _saveTasks();
    notifyListeners();
  }
}

