import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

// Import your games here
import 'games/colored_words/colored_words_game.dart';
import 'games/hangman/hangman_game.dart';
import 'games/hot_cold/hot_cold_game.dart';

// Providers here
import 'providers/audio_provider.dart';
import 'providers/game_registry_provider.dart';
import 'providers/score_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/main_menu_screen.dart';

// ==========================================
// MAIN APP ENTRY POINT
// ==========================================
void main() async {
  // 1. Ensure Flutter is ready to talk to the native platform
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Lock to Portrait Up only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => GameRegistryProvider()),
        ChangeNotifierProvider(
          create: (_) => ScoreProvider(),
        ), // Ensure this is here!
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Register games dynamically upon app start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registry = Provider.of<GameRegistryProvider>(
        context,
        listen: false,
      );
      registry.registerGame(HotColdGameInfo());
      registry.registerGame(HangmanGameInfo());
      registry.registerGame(ColoredWordsGameInfo());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Mini Games Collection',
          theme: themeProvider.currentTheme,
          home: const MainMenuScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
