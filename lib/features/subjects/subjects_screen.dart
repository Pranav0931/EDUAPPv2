import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/constants/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  static const _subjects = [
    _SubjectData('English', Icons.menu_book, 0.80, Color(0xFF667EEA)),
    _SubjectData('Mathematics', Icons.calculate, 0.45, Color(0xFFFF6B6B)),
    _SubjectData('Science', Icons.science, 0.20, Color(0xFF4ECDC4)),
    _SubjectData('Balbharti', Icons.auto_stories, 0.95, Color(0xFFFFA726)),
  ];

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Semantics(
          label: 'Go back',
          button: true,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          ),
        ),
        title: Text(
          'Select Subject',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _subjects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final subject = _subjects[index];
          return _SubjectCard(
            data: subject,
            onTap: () {
              accessibility.triggerHaptic();
              accessibility.speak(subject.name);
              if (accessibility.isVideoMode) {
                Navigator.pushNamed(context, AppRoutes.lessonVideo);
              } else {
                Navigator.pushNamed(context, AppRoutes.lessonAudio);
              }
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

class _SubjectData {
  final String name;
  final IconData icon;
  final double progress;
  final Color color;

  const _SubjectData(this.name, this.icon, this.progress, this.color);
}

class _SubjectCard extends StatelessWidget {
  final _SubjectData data;
  final VoidCallback onTap;

  const _SubjectCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final percentage = (data.progress * 100).toInt();

    return Semantics(
      label: '${data.name}, $percentage percent complete',
      button: true,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Subject icon
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: data.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(data.icon, color: data.color, size: 28),
                ),
                const SizedBox(width: 16),
                // Name and progress
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: data.progress,
                          minHeight: 6,
                          backgroundColor: data.color.withValues(alpha: 0.15),
                          valueColor: AlwaysStoppedAnimation(data.color),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$percentage% Complete',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
