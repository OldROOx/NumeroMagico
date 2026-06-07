
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/game_state.dart';
import '../providers/game_provider.dart';

class AttemptsBar extends StatelessWidget {
  final int attempts;
  final int maxAttempts;
  const AttemptsBar({super.key, required this.attempts, required this.maxAttempts});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(maxAttempts, (i) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: i < attempts
                  ? const Color(0xFF6C63FF)
                  : Colors.white.withOpacity(0.1),
            ),
          ),
        );
      }),
    );
  }
}


class HistoryItem extends StatelessWidget {
  final GuessAttempt attempt;
  const HistoryItem({super.key, required this.attempt});

  @override
  Widget build(BuildContext context) {
    final isCorrect = attempt.feedback == '¡correcto!';
    final isHigher = attempt.feedback == 'mayor';

    final Color color;
    final IconData icon;
    final String label;

    if (isCorrect) {
      color = const Color(0xFF4ECDC4);
      icon = Icons.check_circle_outline;
      label = '¡Correcto!';
    } else if (isHigher) {
      color = const Color(0xFFFFD93D);
      icon = Icons.arrow_upward;
      label = 'Mayor';
    } else {
      color = const Color(0xFFFF6B6B);
      icon = Icons.arrow_downward;
      label = 'Menor';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          _CircleNumber(number: attempt.attemptNumber),
          const SizedBox(width: 12),
          Text('Intenté: ',
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
          Text(
            '${attempt.guess}',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  color: color, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _CircleNumber extends StatelessWidget {
  final int number;
  const _CircleNumber({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Text(
        '$number',
        style: const TextStyle(
            color: Color(0xFF6C63FF), fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}


class FeedbackButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isHighlight;

  const FeedbackButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isHighlight ? color : color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isHighlight ? Colors.transparent : color.withOpacity(0.4)),
        ),
        child: Column(
          children: [
            Icon(icon, color: isHighlight ? Colors.black : color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                  color: isHighlight ? Colors.black : color,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}


class CurrentGuessCard extends StatelessWidget {
  const CurrentGuessCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final state = provider.state;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A35), Color(0xFF252545)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.2),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Intento #${state.attempts + 1}',
            style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 13,
                letterSpacing: 1.5),
          ),
          const SizedBox(height: 8),
          const Text('¿Tu número es...?',
              style: TextStyle(color: Colors.white70, fontSize: 15)),
          const SizedBox(height: 12),
          Text(
            '${state.currentGuess}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 72,
                fontWeight: FontWeight.bold,
                letterSpacing: -2),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FeedbackButton(
                  label: 'Mayor',
                  icon: Icons.arrow_upward_rounded,
                  color: const Color(0xFFFFD93D),
                  onTap: () => context.read<GameProvider>().onHigher(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FeedbackButton(
                  label: '¡Sí!',
                  icon: Icons.check_rounded,
                  color: const Color(0xFF4ECDC4),
                  onTap: () => context.read<GameProvider>().onCorrect(),
                  isHighlight: true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FeedbackButton(
                  label: 'Menor',
                  icon: Icons.arrow_downward_rounded,
                  color: const Color(0xFFFF6B6B),
                  onTap: () => context.read<GameProvider>().onLower(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}