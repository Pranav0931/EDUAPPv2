import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class QuizProgress extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final int timerSeconds;

  const QuizProgress({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.timerSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Question $currentQuestion of $totalQuestions',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              semanticsLabel: 'Question $currentQuestion of $totalQuestions',
            ),
            const Spacer(),
            Semantics(
              label: '$timerSeconds seconds remaining',
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer, size: 16, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      '00:${timerSeconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: currentQuestion / totalQuestions,
            minHeight: 4,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
