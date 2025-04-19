import 'package:flutter/material.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  final List<Map<String, dynamic>> dummyFriends = const [
    {"name": "Egemen Ülker", "streak": 12},
    {"name": "Elif G.", "streak": 9},
    {"name": "Can T.", "streak": 7},
    {"name": "Merve K.", "streak": 5},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyFriends.length,
      itemBuilder: (context, index) {
        final friend = dummyFriends[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(friend["name"][0]),
          ),
          title: Text(friend["name"]),
          subtitle: Text("🔥 ${friend["streak"]} günlük görev serisi"),
          trailing: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${friend["name"]} kişisine görev gönderme özelliği yakında!")),
              );
            },
          ),
        );
      },
    );
  }
}