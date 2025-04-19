import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yayy/providers/task_provider.dart';

class TaskPoolPage extends StatefulWidget {
  const TaskPoolPage({super.key});

  @override
  State<TaskPoolPage> createState() => _TaskPoolPageState();
}

class _TaskPoolPageState extends State<TaskPoolPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _selectedType = "Günlük";
  final List<String> _taskTypes = ["Günlük", "Haftalık", "Aylık"];

  void _addTask(BuildContext context) {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isNotEmpty && desc.isNotEmpty) {
      Provider.of<TaskProvider>(context, listen: false)
          .addTask(title, desc, type: _selectedType);
      _titleController.clear();
      _descController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Görev eklendi")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Görev Havuzu"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text("Yeni Görev Ekle",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: "Görev Başlığı",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(
              labelText: "Açıklama",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedType,
            decoration: const InputDecoration(
              labelText: "Görev Tipi",
              border: OutlineInputBorder(),
            ),
            items: _taskTypes.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _addTask(context),
            child: const Text("Görevi Ekle"),
          ),
          const Divider(height: 32),
          const Text("📅 Günlük Görevler",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildStaticTaskList([
            "10 dk meditasyon",
            "1 bardak su iç",
            "1 görev tamamla"
          ], "Günlük"),
          const SizedBox(height: 20),
          const Text("📆 Haftalık Görevler",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildStaticTaskList([
            "3 gün spor yap",
            "1 kitap bölümü oku",
            "Arkadaşına görev ata"
          ], "Haftalık"),
          const SizedBox(height: 20),
          const Text("📅 Aylık Görevler",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildStaticTaskList([
            "1 yeni alışkanlık başlat",
            "30 gün streak yap",
            "Görev listeni gözden geçir"
          ], "Aylık"),
        ],
      ),
    );
  }

  Widget _buildStaticTaskList(List<String> tasks, String type) {
    return Column(
      children: tasks
          .map((task) => Card(
                child: ListTile(
                  leading: const Icon(Icons.bolt),
                  title: Text(task),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    Provider.of<TaskProvider>(context, listen: false).addTask(
                        task, "Görev havuzundan seçildi", type: type);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("“$task” görevine eklendi")),
                    );
                  },
                ),
              ))
          .toList(),
    );
  }
}

