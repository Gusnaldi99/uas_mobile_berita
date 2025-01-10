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

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const AboutScreen(),
              //   ),
              // );
            },
          ),
          const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.lock),
          //   title: const Text('Change Password'),
          //   trailing: const Icon(Icons.chevron_right),
          //   onTap: () {
          //     // Navigate to Change Password Screen
          //   },
          // ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.info),
          //   title: const Text('About Us'),
          //   trailing: const Icon(Icons.chevron_right),
          //   onTap: () {
          //     // Navigate to About Us Screen
          //   },
          // ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.logout),
          //   title: const Text('Logout'),
          //   onTap: () {
          //     // Handle Logout
          //     showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //         title: const Text('Logout'),
          //         content: const Text('Are you sure you want to logout?'),
          //         actions: [
          //           TextButton(
          //             onPressed: () => Navigator.of(context).pop(),
          //             child: const Text('Cancel'),
          //           ),
          //           TextButton(
          //             onPressed: () {
          //               //jika textbutton diklik otomatis apk tertutup
          //               SystemNavigator.pop();

          //               // Navigator.push(
          //               //   context,
          //               //   MaterialPageRoute(
          //               //       builder: (context) => const SplashScreen()),
          //               // );
          //             },
          //             child: const Text('Logout'),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
