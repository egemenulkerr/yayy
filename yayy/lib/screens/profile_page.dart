import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yayy/providers/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/profile_dummy.jpg"),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Egemen Ülker",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text("Ünvan • 128 görev tamamlandı"),
                ),
                const Divider(height: 32),
                const Text(
                  "İstatistikler",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                const ListTile(
                  leading: Icon(Icons.stars),
                  title: Text("Streak"),
                  trailing: Text("7 gün üst üste"),
                ),
                const ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text("Toplam Görev"),
                  trailing: Text("128"),
                ),
                const ListTile(
                  leading: Icon(Icons.group),
                  title: Text("Gruplar"),
                  trailing: Text("3"),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Uygulama Ayarları",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SwitchListTile(
                  title: const Text("Koyu Mod"),
                  value: isDark,
                  onChanged: (val) {
                    themeProvider.toggleTheme(val);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
