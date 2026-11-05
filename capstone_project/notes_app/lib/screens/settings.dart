import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/models/model_class.dart';
import 'package:notes_app/services/storage_services.dart';
import 'package:notes_app/widgets/delete_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          // SwitchListTile(
          //   secondary: const Icon(Icons.dark_mode),
          //   title: const Text('Dark Mode'),
          //   subtitle: const Text('Switch between Light and Dark theme'),
          //   // value: isDarkMode,
          //   activeColor: Colors.amber,
          //   onChanged: (bool value) async {
          //     setState(() {
          //       // themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
          //     });
          //     await StorageService().saveThemeMode(value);
          //   },
          // ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_sweep, color: Colors.red),
            title: const Text(
              'Delete All Notes',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Permanently clear all saved notes'),
            onTap: () {
              DeleteDialog().showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
