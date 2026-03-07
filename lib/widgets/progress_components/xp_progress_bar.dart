import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class XpProgressBar extends StatelessWidget {
  final int currentXp;
  final int targetXp;
  final int currentLevel;

  const XpProgressBar({
    super.key,
    required this.currentXp,
    required this.targetXp,
    required this.currentLevel,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentXp / targetXp;
    final remaining = targetXp - currentXp;

    return Semantics(
      label: 'Experience points: $currentXp out of $targetXp. Only $remaining XP to reach Level ${currentLevel + 1}',
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'XP Progress',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${_formatNumber(currentXp)} / ${_formatNumber(targetXp)} XP',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE8E0F0),
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Only $remaining XP to reach Level ${currentLevel + 1}!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) {
      return '${n ~/ 1000},${(n % 1000).toString().padLeft(3, '0')}';
    }
    return n.toString();
  }
}
