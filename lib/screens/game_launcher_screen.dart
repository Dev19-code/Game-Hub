import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/score_provider.dart';
import '../utils/constants.dart';

class GameLauncher extends StatelessWidget {
  final MiniGame game;

  const GameLauncher({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    // Inside the build method:
    final scoreProvider = Provider.of<ScoreProvider>(context);
    final highScore = scoreProvider.getHighScore(game.id);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Big Icon with a "Hero" animation
              Hero(
                tag: 'game_icon_${game.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    game.imagePath,
                    width: 300,
                    height: 300,
                    fit: BoxFit
                        .cover, // Ensures the squared image fills the space perfectly
                    // Fallback if image fails to load
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(game.icon, size: 40),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                game.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                game.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const Spacer(),

              // High Score Placeholder (We can connect this to a database later!)
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Personal Best",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "$highScore",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  // Navigate to the actual game screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => game.createScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "START GAME",
                  style: TextStyle(fontSize: 20, letterSpacing: 2),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
