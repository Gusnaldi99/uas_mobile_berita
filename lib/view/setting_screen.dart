import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tema_provider.dart';
// import 'package:flutter/services.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
            return ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text("Dark Mode"),
              trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  }),
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // navigator push berfungsi ketika klik listtile akan mengarah ke halaman about
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
