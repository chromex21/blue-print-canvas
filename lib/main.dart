import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'managers/settings_state_manager.dart';
import 'theme_manager.dart';
import 'settings_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blueprint Editor',
      home: MultiProvider(
        providers: [
          Provider(
            create: (context) => ThemeManager(),
            dispose: (context, themeManager) => themeManager.dispose(),
          ),
          ChangeNotifierProxyProvider<ThemeManager, SettingsStateManager>(
            create: (context) =>
                SettingsStateManager(context.read<ThemeManager>()),
            update: (context, themeManager, previous) =>
                previous ?? SettingsStateManager(themeManager),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsManager = context.watch<SettingsStateManager>();

    return Scaffold(
      backgroundColor: settingsManager.currentTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Blueprint Editor'),
        backgroundColor: settingsManager.currentTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SettingsDialog(
                  settingsManager: context.read<SettingsStateManager>(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to Blueprint Editor',
          style: TextStyle(
            color: settingsManager.currentTheme.textColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
