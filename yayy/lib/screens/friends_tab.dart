import 'package:flutter/material.dart';
import 'friend_chat_page.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  final List<Map<String, dynamic>> friends = const [
    {"name": "Ayşe", "lastMessage": "Nasılsın?"},
    {"name": "Mehmet", "lastMessage": "Bugün spora gittim."},
    {"name": "Zeynep", "lastMessage": "Harika bir gün!"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: friends.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final friend = friends[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(friend["name"][0]),
          ),
          title: Text(friend["name"]),
          subtitle: Text(friend["lastMessage"]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FriendChatPage(friendName: friend["name"]),
              ),
            );
          },
        );
      },
    );
  }
}
