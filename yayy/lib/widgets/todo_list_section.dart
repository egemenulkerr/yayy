import 'dart:convert'; // JSON encode/decode işlemleri için
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Kalıcılık için

// Ana bileşen: yapılacaklar listesini yöneten widget
class ToDoListSection extends StatefulWidget {
  final bool editable; // true ise yeni görev ekleme ve silme yapılabilir

  const ToDoListSection({super.key, this.editable = true});

  @override
  State<ToDoListSection> createState() => _ToDoListSectionState();
}

// Stateful widget’ın state sınıfı
class _ToDoListSectionState extends State<ToDoListSection> {
  final List<Map<String, dynamic>> _todoList = []; // Görev listesi
  final TextEditingController _controller = TextEditingController(); // Kullanıcıdan giriş almak için

  @override
  void initState() {
    super.initState();
    _loadTodos(); // Sayfa açıldığında görevleri SharedPreferences’tan yükle
  }

  // SharedPreferences’tan görev listesini yükler
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedData = prefs.getString("todo_list");

    if (storedData != null) {
      final List<dynamic> decoded = jsonDecode(storedData);
      setState(() {
        _todoList.clear();
        _todoList.addAll(decoded.map((e) => Map<String, dynamic>.from(e)));
      });
    }
  }

  // Görev listesini SharedPreferences’a kaydeder
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_todoList);
    await prefs.setString("todo_list", encoded);
  }

  // Yeni görev ekleme işlevi
  void _addTodo() {
    final text = _controller.text.trim(); // boşlukları temizle
    if (text.isNotEmpty) {
      setState(() {
        _todoList.add({"text": text, "done": false}); // yeni görev eklenir
        _controller.clear(); // metin kutusu temizlenir
      });
      _saveTodos(); // kalıcı olarak kaydet
    }
  }

  // Görev işaretlenmişse üstünü çizmek veya geri almak için
  void _toggleTodo(int index) {
    setState(() {
      _todoList[index]["done"] = !_todoList[index]["done"];
    });
    _saveTodos();
  }

  // Görev silme işlevi
  void _removeTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
    _saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eğer düzenlenebilir modda ise, yeni görev ekleme alanını göster
        if (widget.editable) ...[
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Yeni görev ekle...",
                  ),
                  onSubmitted: (_) => _addTodo(),
                ),
              ),
              IconButton(
                onPressed: _addTodo,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        // Liste boşsa mesaj, doluysa görev listesi gösterilir
        _todoList.isEmpty
            ? const Text("Henüz yapılacak bir görev yok.")
            : ListView.builder(
                shrinkWrap: true, // Liste içeriye sığsın diye
                physics: const NeverScrollableScrollPhysics(), // Ana scroll view ile çakışmasın
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  final todo = _todoList[index];
                  return ListTile(
                    leading: Checkbox(
                      value: todo["done"],
                      onChanged: (_) => _toggleTodo(index),
                    ),
                    title: Text(
                      todo["text"],
                      style: TextStyle(
                        decoration: todo["done"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: widget.editable
                        ? IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeTodo(index),
                          )
                        : null,
                  );
                },
              ),
      ],
    );
  }
}
