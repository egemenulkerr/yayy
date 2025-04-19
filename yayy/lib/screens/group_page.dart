import 'package:flutter/material.dart';
import 'group_chat_page.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final List<Map<String, dynamic>> dummyGroups = [
    {
      "name": "Sağlıklı Yaşam",
      "lastMessage": "Ayşe: Görevi tamamladım!",
      "time": "12:30",
      "members": [
        {"name": "Ayşe", "streak": 7},
        {"name": "Mehmet", "streak": 3},
        {"name": "Zeynep", "streak": 10},
      ],
    },
    {
      "name": "Odaklan ve Başar",
      "lastMessage": "Can: Bugünkü hedefi bitirdim",
      "time": "11:45",
      "members": [
        {"name": "Can", "streak": 8},
        {"name": "Sena", "streak": 5},
        {"name": "Yusuf", "streak": 12},
      ],
    },
  ];

  void _showCompletionDialog(BuildContext context, String taskName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("🎉 Tebrikler!"),
        content: Text("'$taskName' görevini başarıyla tamamladın!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: dummyGroups.length,
        separatorBuilder: (context, index) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final group = dummyGroups[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(group["name"][0]),
            ),
            title: Text(group["name"]),
            subtitle: Text(group["lastMessage"]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check_circle_outline, color: Colors.green),
                  onPressed: () => _showCompletionDialog(context, group["name"]),
                ),
                Text(group["time"], style: const TextStyle(fontSize: 12)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GroupChatPage(
                    groupName: group["name"],
                    members: List<Map<String, dynamic>>.from(group["members"]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
