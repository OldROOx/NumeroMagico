
enum GameStatus { playing, won, lost }

class GuessAttempt {
  final int attemptNumber;
  final int guess;
  final String feedback;

  const GuessAttempt({
    required this.attemptNumber,
    required this.guess,
    required this.feedback,
  });
}

class GameState {
  final int low;
  final int high;
  final int currentGuess;
  final int attempts;
  final int maxAttempts;
  final GameStatus status;
  final List<GuessAttempt> history;

  const GameState({
    required this.low,
    required this.high,
    required this.currentGuess,
    required this.attempts,
    required this.maxAttempts,
    required this.status,
    required this.history,
  });

  int get attemptsLeft => maxAttempts - attempts;

  GameState copyWith({
    int? low,
    int? high,
    int? currentGuess,
    int? attempts,
    GameStatus? status,
    List<GuessAttempt>? history,
  }) {
    return GameState(
      low: low ?? this.low,
      high: high ?? this.high,
      currentGuess: currentGuess ?? this.currentGuess,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts,
      status: status ?? this.status,
      history: history ?? this.history,
    );
  }
}