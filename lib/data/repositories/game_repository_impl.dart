

import '../../domain/entities/game_state.dart';
import '../../domain/repositories/game_repository.dart';
import '../datasources/game_local_datasource.dart';

class GameRepositoryImpl implements GameRepository {
  final GameLocalDataSource dataSource;

  GameRepositoryImpl({required this.dataSource});

  @override
  GameState initGame() => dataSource.initGame();

  @override
  GameState respondHigher(GameState current) => dataSource.respondHigher(current);

  @override
  GameState respondLower(GameState current) => dataSource.respondLower(current);

  @override
  GameState respondCorrect(GameState current) => dataSource.respondCorrect(current);
}