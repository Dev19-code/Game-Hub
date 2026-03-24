import 'package:flutter/material.dart';
import 'package:mini_apps/screens/game_launcher_screen.dart';
import '../models/game.dart';
import '../utils/constants.dart';

class GameCard extends StatelessWidget {
  final MiniGame game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      margin: const EdgeInsets.only(bottom: AppConstants.listSpacing),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        // --- THE POSTER IMAGE ---
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            game.imagePath,
            width: 60,
            height: 60,
            fit: BoxFit
                .cover, // Ensures the squared image fills the space perfectly
            // Fallback if image fails to load
            errorBuilder: (context, error, stackTrace) =>
                Icon(game.icon, size: 40),
          ),
        ),
        title: Text(
          game.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(game.description, maxLines: 2),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GameLauncher(game: game)),
        ),
      ),
    );
  }
}
