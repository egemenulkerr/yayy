import 'package:flutter/material.dart';

class GroupChatPage extends StatelessWidget {
  final String groupName;
  final List<Map<String, dynamic>> members;

  const GroupChatPage({
    super.key,
    required this.groupName,
    required this.members,
  });

  void _showMembersDialog(BuildContext context) {
    final sortedMembers = [...members]..sort((a, b) => b['streak'].compareTo(a['streak']));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Grup Üyeleri - Streak Sıralaması"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: sortedMembers.length,
            itemBuilder: (context, index) {
              final member = sortedMembers[index];
              return ListTile(
                leading: Text("${index + 1}.", style: const TextStyle(fontWeight: FontWeight.bold)),
                title: Text(member['name']),
                trailing: Text("🔥 ${member['streak']}", style: const TextStyle(color: Colors.deepOrange)),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Kapat"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _showMembersDialog(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(groupName, style: const TextStyle(fontSize: 18)),
              const Text("Üstüne tıklayarak üyeleri gör", style: TextStyle(fontSize: 12, color: Colors.white70))
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text("Sohbet ekranı burada yer alacak", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}