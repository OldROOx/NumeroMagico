
import '../../domain/entities/game_state.dart';

const int _minNumber = 1;
const int _maxNumber = 100;
const int _maxAttempts = 7;

class GameLocalDataSource {
  GameState initGame() {
    final firstGuess = _midpoint(_minNumber, _maxNumber);
    return GameState(
      low: _minNumber,
      high: _maxNumber,
      currentGuess: firstGuess,
      attempts: 0,
      maxAttempts: _maxAttempts,
      status: GameStatus.playing,
      history: const [],
    );
  }

  GameState respondHigher(GameState current) {
    final newHistory = [
      ...current.history,
      GuessAttempt(
        attemptNumber: current.attempts + 1,
        guess: current.currentGuess,
        feedback: 'mayor',
      ),
    ];
    final newLow = current.currentGuess + 1;
    final newAttempts = current.attempts + 1;
    final newStatus =
    newAttempts >= _maxAttempts ? GameStatus.lost : GameStatus.playing;
    final newGuess = newStatus == GameStatus.playing
        ? _midpoint(newLow, current.high)
        : current.currentGuess;

    return current.copyWith(
      low: newLow,
      currentGuess: newGuess,
      attempts: newAttempts,
      status: newStatus,
      history: newHistory,
    );
  }

  GameState respondLower(GameState current) {
    final newHistory = [
      ...current.history,
      GuessAttempt(
        attemptNumber: current.attempts + 1,
        guess: current.currentGuess,
        feedback: 'menor',
      ),
    ];
    final newHigh = current.currentGuess - 1;
    final newAttempts = current.attempts + 1;
    final newStatus =
    newAttempts >= _maxAttempts ? GameStatus.lost : GameStatus.playing;
    final newGuess = newStatus == GameStatus.playing
        ? _midpoint(current.low, newHigh)
        : current.currentGuess;

    return current.copyWith(
      high: newHigh,
      currentGuess: newGuess,
      attempts: newAttempts,
      status: newStatus,
      history: newHistory,
    );
  }

  GameState respondCorrect(GameState current) {
    final newHistory = [
      ...current.history,
      GuessAttempt(
        attemptNumber: current.attempts + 1,
        guess: current.currentGuess,
        feedback: '¡correcto!',
      ),
    ];
    return current.copyWith(
      attempts: current.attempts + 1,
      status: GameStatus.won,
      history: newHistory,
    );
  }

  int _midpoint(int low, int high) => ((low + high) / 2).round();
}