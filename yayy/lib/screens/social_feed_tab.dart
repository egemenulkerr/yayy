import 'package:flutter/material.dart';

class SocialFeedTab extends StatefulWidget {
  const SocialFeedTab({super.key});

  @override
  State<SocialFeedTab> createState() => _SocialFeedTabState();
}

class _SocialFeedTabState extends State<SocialFeedTab> {
  final List<Map<String, dynamic>> posts = [
    {
      "user": "Egemen Ülker",
      "content": "Bugünkü 5 km koşu görevimi başarıyla tamamladım!",
      "time": "2 saat önce",
      "likes": 5,
      "comments": ["Harikasın!", "Devam! 💪"]
    },
    {
      "user": "Elif G.",
      "content": "30 gün su içme hedefimde 15. güne ulaştım!",
      "time": "4 saat önce",
      "likes": 8,
      "comments": ["Vay be!", "Süpersin"]
    },
  ];

  void _addLike(int index) {
    setState(() {
      posts[index]["likes"]++;
    });
  }

  void _addComment(int index, String comment) {
    setState(() {
      posts[index]["comments"].add(comment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post["user"], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(post["time"], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(post["content"]),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () => _addLike(index),
                    ),
                    Text("${post["likes"]} beğeni"),
                  ],
                ),
                const Divider(),
                ...List.generate(post["comments"].length, (i) => Text("💬 ${post["comments"][i]}")),
                TextField(
                  decoration: const InputDecoration(hintText: "Yorum ekle..."),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      _addComment(index, value.trim());
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}