import 'package:flutter/material.dart';
import 'package:yayy/screens/main_page.dart';
import 'package:yayy/screens/profile_page.dart';
import 'package:yayy/screens/social_page.dart';
import 'package:yayy/screens/task_pool_page.dart';
import 'package:yayy/screens/todo_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; // MainPage ortada

  final List<Widget> _pages = const [
    TaskPoolPage(),     // index 0
    SocialPage(),       // index 1
    MainPage(),         // index 2 (ortadaki sekme)
    ToDoPage(),         // index 3
    ProfilePage(),      // index 4
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Görev Havuzu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Sosyal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'To-Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}