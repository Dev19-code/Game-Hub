import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../providers/score_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Appearance & Sounds",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),

          // Dark Mode Toggle
          SwitchListTile(
            title: const Text("Dark Mode"),
            subtitle: const Text("Easier on the eyes in low light"),
            secondary: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),

          const Divider(),

          // Inside the ListView in SettingsScreen
          Consumer<AudioProvider>(
            builder: (context, audio, child) {
              return SwitchListTile(
                title: const Text("Sound Effects"),
                secondary: Icon(
                  audio.isSoundEnabled ? Icons.volume_up : Icons.volume_off,
                ),
                value: audio.isSoundEnabled,
                onChanged: (value) => audio.toggleSound(),
              );
            },
          ),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Game Data",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),

          // Clear Progress Button
          ListTile(
            title: const Text("Reset All High Scores"),
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            onTap: () => _showResetDialog(context),
          ),

          const Divider(),

          const AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationName: "Game Hub",
            applicationVersion: "version 1.0.0",
            applicationLegalese: "© 2026 developed by:\nOmar Al-tigani",
            applicationIcon: Icon(
              Icons.videogame_asset,
              size: 50,
              color: Colors.blueGrey,
            ),
            child: Text("About this App"),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure?"),
        content: const Text(
          "This will permanently delete all your records and high scores.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
          TextButton(
            onPressed: () {
              // Add logic to clear scores here
              Provider.of<ScoreProvider>(
                context,
                listen: false,
              ).clearAllScores();
              Navigator.pop(context);
            },
            child: const Text("RESET", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
