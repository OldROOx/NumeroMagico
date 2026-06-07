

import '../entities/game_state.dart';

abstract class GameRepository {

  GameState initGame();

  GameState respondHigher(GameState current);

  GameState respondLower(GameState current);

  GameState respondCorrect(GameState current);
}