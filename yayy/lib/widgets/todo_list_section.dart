import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoListSection extends StatefulWidget {
  final bool editable;

  const ToDoListSection({super.key, this.editable = true});

  @override
  State<ToDoListSection> createState() => _ToDoListSectionState();
}

class _ToDoListSectionState extends State<ToDoListSection> {
  final List<Map<String, dynamic>> _todoList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

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

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_todoList);
    await prefs.setString("todo_list", encoded);
  }

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _todoList.add({"text": text, "done": false});
        _controller.clear();
      });
      _saveTodos();
    }
  }

  void _toggleTodo(int index) {
    setState(() {
      _todoList[index]["done"] = !_todoList[index]["done"];
    });
    _saveTodos();
  }

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
        _todoList.isEmpty
            ? const Text("Henüz yapılacak bir görev yok.")
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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


