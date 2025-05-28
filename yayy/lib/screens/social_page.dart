import 'package:flutter/material.dart';
import 'social_feed_tab.dart';
import 'friends_tab.dart';
import 'group_page.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 sekme
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sosyal Alan"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Akış"),
            Tab(text: "Arkadaşlar"),
            Tab(text: "Gruplar"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SocialFeedTab(),   // Akış ekranı
          FriendsTab(),      // Arkadaşlar ekranı
          GroupPage(),       // Gruplar ekranı
        ],
      ),
    );
  }
}

