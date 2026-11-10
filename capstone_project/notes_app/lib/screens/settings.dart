import 'package:flutter/material.dart';
import 'package:notes_app/providers/theme_provider.dart';
import 'package:notes_app/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ThemeProvider>(context, listen: false).loadThemeMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

          return ListView(
            children: [
              const SizedBox(height: 10),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                subtitle: const Text('Switch between Light and Dark theme'),
                value: isDarkMode,
                activeColor: Colors.amber,
                onChanged: (bool value) async {
                  await themeProvider.toggleTheme(value);
                },
              ),

              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete_sweep, color: Colors.red),
                title: const Text(
                  'Delete All Notes',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Permanently clear all saved notes'),
                onTap: () {
                  DeleteDialog().showDeleteConfirmationDialog(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
