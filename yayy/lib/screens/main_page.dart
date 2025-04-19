import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yayy/providers/task_provider.dart';
import 'package:yayy/providers/note_provider.dart';
import 'package:yayy/widgets/todo_list_section.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).activeTasks;
    final notes = Provider.of<NoteProvider>(context).notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoş geldin!'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            
            const SizedBox(height: 20),

            const Text("Aktif Görevler", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (tasks.isEmpty)
              const Text("Henüz görev eklenmedi.")
            else
              ...tasks.asMap().entries.map((entry) {
                final index = entry.key;
                final task = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.task_alt),
                    title: Text(task["title"] ?? ""),
                    subtitle: Text("${task["desc"] ?? ""} (${task["type"] ?? "?"})"),
                    trailing: IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        Provider.of<TaskProvider>(context, listen: false).removeTask(index);
                        Future.delayed(Duration.zero, () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("🎉 Tebrikler!"),
                              content: Text("'${task["title"] ?? "Görev"}' görevini başarıyla tamamladın!"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Tamam"),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ),
                );
              }).toList(),

            const SizedBox(height: 30),
            const Text("Yapılacaklar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const ToDoListSection(editable: false),

            const SizedBox(height: 30),
            const Text("Notlarım", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (notes.isEmpty)
              const Text("Henüz not eklenmedi.")
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.note),
                      title: Text(notes[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<NoteProvider>(context, listen: false).removeNote(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Not silindi")),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
