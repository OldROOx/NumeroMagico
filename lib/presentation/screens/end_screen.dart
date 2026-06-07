
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/game_state.dart';
import '../providers/game_provider.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final state = provider.state;
    final won = state.status == GameStatus.won;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(won ? '🎉' : '😤',
                style: const TextStyle(fontSize: 80)),
            const SizedBox(height: 24),
            Text(
              won ? '¡Lo adiviné!' : 'Me ganaste...',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              won
                  ? 'Tu número era ${state.currentGuess}\nLo logré en ${state.attempts} intento${state.attempts == 1 ? '' : 's'}'
                  : 'No pude adivinar tu número\nen ${state.maxAttempts} intentos 🤔',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 16,
                  height: 1.5),
            ),
            const SizedBox(height: 40),
            // Historial resumido
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mis intentos:',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                        letterSpacing: 1),
                  ),
                  const SizedBox(height: 10),
                  ...state.history.map((a) {
                    final emoji = a.feedback == '¡correcto!'
                        ? '✅'
                        : a.feedback == 'mayor'
                        ? '⬆️'
                        : '⬇️';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Text(
                        '$emoji  Intento ${a.attemptNumber}: ${a.guess}  →  ${a.feedback}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.read<GameProvider>().onReset(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Jugar de nuevo',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}