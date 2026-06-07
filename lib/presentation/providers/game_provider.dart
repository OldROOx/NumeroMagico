// CAPA DE PRESENTACIÓN — Provider
// Solo conoce los casos de uso. No sabe nada de DataSources ni implementaciones.
// Expone el estado a la UI y delega la lógica a los use cases.

import 'package:flutter/foundation.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/usecases/game_usecases.dart';

class GameProvider extends ChangeNotifier {
  final InitGameUseCase _initGame;
  final RespondHigherUseCase _respondHigher;
  final RespondLowerUseCase _respondLower;
  final RespondCorrectUseCase _respondCorrect;

  late GameState _state;

  GameProvider({
    required InitGameUseCase initGame,
    required RespondHigherUseCase respondHigher,
    required RespondLowerUseCase respondLower,
    required RespondCorrectUseCase respondCorrect,
  })  : _initGame = initGame,
        _respondHigher = respondHigher,
        _respondLower = respondLower,
        _respondCorrect = respondCorrect {
    _state = _initGame();
  }

  // Exponer estado a la UI (read-only)
  GameState get state => _state;

  void onHigher() {
    if (_state.status != GameStatus.playing) return;
    _state = _respondHigher(_state);
    notifyListeners();
  }

  void onLower() {
    if (_state.status != GameStatus.playing) return;
    _state = _respondLower(_state);
    notifyListeners();
  }

  void onCorrect() {
    if (_state.status != GameStatus.playing) return;
    _state = _respondCorrect(_state);
    notifyListeners();
  }

  void onReset() {
    _state = _initGame();
    notifyListeners();
  }
}