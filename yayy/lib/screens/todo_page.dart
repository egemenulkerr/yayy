import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yayy/widgets/todo_list_section.dart';
import 'package:yayy/providers/note_provider.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do & Notlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "To-Do Listesi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const ToDoListSection(),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            const Text(
              "Yeni Not Ekle",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _noteController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Bir not yaz...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final text = _noteController.text.trim();
                if (text.isNotEmpty) {
                  noteProvider.addNote(text);
                  _noteController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Not kaydedildi")),
                  );
                }
              },
              child: const Text("Notu Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}

