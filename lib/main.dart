
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

// Data
import 'data/datasources/game_local_datasource.dart';
import 'data/repositories/game_repository_impl.dart';

// Domain
import 'domain/usecases/game_usecases.dart';

// Presentation
import 'presentation/providers/game_provider.dart';
import 'presentation/screens/playing_screen.dart';
import 'presentation/screens/end_screen.dart';
import 'domain/entities/game_state.dart';

void main() {
  // --- Composition Root ---
  final dataSource = GameLocalDataSource();
  final repository = GameRepositoryImpl(dataSource: dataSource);

  final initGame = InitGameUseCase(repository);
  final respondHigher = RespondHigherUseCase(repository);
  final respondLower = RespondLowerUseCase(repository);
  final respondCorrect = RespondCorrectUseCase(repository);

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => ChangeNotifierProvider(
        create: (_) => GameProvider(
          initGame: initGame,
          respondHigher: respondHigher,
          respondLower: respondLower,
          respondCorrect: respondCorrect,
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivina tu número',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'monospace',
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: Consumer<GameProvider>(
          builder: (context, provider, _) {
            return provider.state.status == GameStatus.playing
                ? const PlayingScreen()
                : const EndScreen();
          },
        ),
      ),
    );
  }
}