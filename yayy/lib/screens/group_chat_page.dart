import 'package:flutter/material.dart';

class GroupChatPage extends StatefulWidget {
  final String groupName;
  final List<Map<String, dynamic>> members;

  const GroupChatPage({
    super.key,
    required this.groupName,
    required this.members,
  });

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final List<Map<String, String>> messages = [
    {
      "sender": "Grup",
      "text": "Merhaba, gruba hoş geldin!",
      "time": "12:00",
    },
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final now = TimeOfDay.now().format(context);
      setState(() {
        messages.add({
          "sender": "Sen",
          "text": text,
          "time": now,
        });
        _controller.clear();
      });
    }
  }

  void _deleteMessage(int index) {
    final message = messages[index];
    if (message["sender"] != "Sen") return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Mesajı Sil"),
        content: const Text("Bu mesajı silmek istiyor musunuz?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                messages.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Sil"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];
                final isMe = msg["sender"] == "Sen";

                return GestureDetector(
                  onLongPress: () => _deleteMessage(messages.length - 1 - index),
                  child: Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[400] : Colors.grey[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(msg["text"] ?? ""),
                          const SizedBox(height: 4),
                          Text(
                            msg["time"] ?? "",
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 8,
              left: 8,
              right: 8,
              top: 4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Mesaj yaz...",
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

