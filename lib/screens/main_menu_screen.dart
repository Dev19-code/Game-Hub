import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_registry_provider.dart';
import '../providers/score_provider.dart';
import '../widgets/game_card.dart';
import '../utils/constants.dart';
import 'settings_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access our providers
    final registry = Provider.of<GameRegistryProvider>(context);
    final scoreProvider = Provider.of<ScoreProvider>(context);

    // Calculate Quick Stats
    final int totalPoints = scoreProvider.highScores.values.fold(
      0,
      (sum, item) => sum + item.toInt(),
    );
    final int gamesUnlocked = registry.availableGames.length;
    final int gamesPlayed = scoreProvider.highScores.length;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. The Large "Hero" Header
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Game Hub",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.videogame_asset,
                  size: 80,
                  color: Colors.white54,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
              ),
            ],
          ),

          // 2. The Quick Stats Dashboard
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Progress",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildStatCard(
                        context,
                        "Total Points",
                        totalPoints.toString(),
                        Icons.emoji_events,
                        iconColor: Colors.amber,
                      ),
                      const SizedBox(width: 12),
                      _buildStatCard(
                        context,
                        "Played",
                        "$gamesPlayed/$gamesUnlocked",
                        Icons.sports_esports,
                        iconColor: Colors.pinkAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Choose Your Challenge",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // 3. The Game List
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.paddingMedium,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return GameCard(game: registry.availableGames[index]);
              }, childCount: registry.availableGames.length),
            ),
          ),

          // A bit of padding at the very bottom
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // Helper widget to build the stat cards
  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? iconColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: iconColor!.withAlpha(30),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
