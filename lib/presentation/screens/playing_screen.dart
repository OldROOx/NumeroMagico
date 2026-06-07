
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/game_widgets.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({super.key});

  Color _attemptsColor(int left) {
    if (left >= 5) return const Color(0xFF4ECDC4);
    if (left >= 3) return const Color(0xFFFFD93D);
    return const Color(0xFFFF6B6B);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameProvider>().state;

    return Column(
      children: [

        Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '🧠 Adivina tu\nnúmero',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: _attemptsColor(state.attemptsLeft)
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: _attemptsColor(state.attemptsLeft)
                              .withOpacity(0.4)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${state.attemptsLeft}',
                          style: TextStyle(
                              color: _attemptsColor(state.attemptsLeft),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'intentos\nrestantes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _attemptsColor(state.attemptsLeft)
                                  .withOpacity(0.8),
                              fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.search,
                        color: Color(0xFF6C63FF), size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Rango actual: ${state.low} — ${state.high}',
                      style: const TextStyle(
                          color: Color(0xFFB0B0CC), fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              AttemptsBar(
                  attempts: state.attempts,
                  maxAttempts: state.maxAttempts),
            ],
          ),
        ),


        Expanded(
          child: state.history.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('💭', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text(
                  'Piensa un número\nentre 1 y 100',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 16),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.history.length,
            reverse: true,
            itemBuilder: (_, i) {
              final item =
              state.history[state.history.length - 1 - i];
              return HistoryItem(attempt: item);
            },
          ),
        ),


        const CurrentGuessCard(),
        const SizedBox(height: 16),
      ],
    );
  }
}