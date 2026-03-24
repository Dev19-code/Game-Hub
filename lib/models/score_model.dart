class GameScore {
  final String gameId;
  final int score;
  final DateTime date;

  GameScore({required this.gameId, required this.score, required this.date});

  // Convert to Map for saving to local storage (JSON)
  Map<String, dynamic> toJson() => {
    'gameId': gameId,
    'score': score,
    'date': date.toIso8601String(),
  };

  // Create from Map when loading from local storage
  factory GameScore.fromJson(Map<String, dynamic> json) => GameScore(
    gameId: json['gameId'],
    score: json['score'],
    date: DateTime.parse(json['date']),
  );
}
