
import '../entities/game_state.dart';
import '../repositories/game_repository.dart';

class InitGameUseCase {
  final GameRepository repository;
  InitGameUseCase(this.repository);

  GameState call() => repository.initGame();
}

class RespondHigherUseCase {
  final GameRepository repository;
  RespondHigherUseCase(this.repository);

  GameState call(GameState current) => repository.respondHigher(current);
}

class RespondLowerUseCase {
  final GameRepository repository;
  RespondLowerUseCase(this.repository);

  GameState call(GameState current) => repository.respondLower(current);
}

class RespondCorrectUseCase {
  final GameRepository repository;
  RespondCorrectUseCase(this.repository);

  GameState call(GameState current) => repository.respondCorrect(current);
}