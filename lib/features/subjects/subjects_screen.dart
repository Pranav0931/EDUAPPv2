import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/constants/app_routes.dart';
import '../../core/data/lesson_data.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  static const _subjectIcons = {
    'English': Icons.menu_book,
    'Mathematics': Icons.calculate,
    'Science': Icons.science,
    'Balbharti': Icons.auto_stories,
  };

  static const _subjectColors = {
    'English': Color(0xFF667EEA),
    'Mathematics': Color(0xFFFF6B6B),
    'Science': Color(0xFF4ECDC4),
    'Balbharti': Color(0xFFFFA726),
  };

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final classNumber = args?['classNumber'] as int? ?? 1;
    final classData = LessonDatabase.getClass(classNumber);

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
          'Class $classNumber - Subjects',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: classData.subjects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final subject = classData.subjects[index];
          final icon = _subjectIcons[subject.name] ?? Icons.school;
          final color = _subjectColors[subject.name] ?? Color(subject.colorValue);
          final totalLessons = subject.chapters.fold<int>(0, (sum, ch) => sum + ch.lessons.length);

          return _SubjectCard(
            name: subject.name,
            icon: icon,
            color: color,
            lessonCount: totalLessons,
            chapterCount: subject.chapters.length,
            onTap: () {
              accessibility.triggerHaptic();
              accessibility.speak('${subject.name}, ${subject.chapters.length} chapters, $totalLessons lessons');
              Navigator.pushNamed(context, AppRoutes.lessons, arguments: {
                'classNumber': classNumber,
                'subjectName': subject.name,
                'subjectIndex': index,
              });
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final int lessonCount;
  final int chapterCount;
  final VoidCallback onTap;

  const _SubjectCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.lessonCount,
    required this.chapterCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$name, $chapterCount chapters, $lessonCount lessons',
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
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                // Name and info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$chapterCount chapters • $lessonCount lessons',
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
