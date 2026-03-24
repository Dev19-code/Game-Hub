/// Represents the current state of any game in the collection.
enum GameStatus {
  initial, // Before the game starts
  playing, // Active gameplay
  paused, // Game is on hold
  won, // Player succeeded
  lost, // Player failed
  gameOver, // General end state (e.g., time ran out)
}

/// Standard difficulty levels shared across the app.
enum Difficulty { easy, medium, hard, expert }
