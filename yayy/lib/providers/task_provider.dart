import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _activeTasks = [];

  List<Map<String, dynamic>> get activeTasks => _activeTasks;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('active_tasks');
    if (data != null) {
      final List decoded = jsonDecode(data);
      _activeTasks.clear();
      _activeTasks.addAll(decoded.map((e) => Map<String, dynamic>.from(e)));
      notifyListeners();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_activeTasks);
    await prefs.setString('active_tasks', encoded);
  }

  void addTask(String title, String desc, {String type = "Belirtilmedi"}) {
    _activeTasks.add({
      "title": title,
      "desc": desc,
      "type": type,
    });
    _saveTasks();
    notifyListeners();
  }

  void removeTask(int index) {
    _activeTasks.removeAt(index);
    _saveTasks();
    notifyListeners();
  }

  void clearTasks() {
    _activeTasks.clear();
    _saveTasks();
    notifyListeners();
  }
}

