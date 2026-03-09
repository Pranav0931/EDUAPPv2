import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/constants/app_routes.dart';
import '../../core/data/lesson_data.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class LessonsListScreen extends StatelessWidget {
  const LessonsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int classNumber = args?['classNumber'] ?? 1;
    final String subjectName = args?['subjectName'] ?? 'English';
    final int subjectIndex = args?['subjectIndex'] ?? 0;

    final classData = LessonDatabase.getClass(classNumber);
    final subject = classData.subjects.length > subjectIndex
        ? classData.subjects[subjectIndex]
        : classData.subjects.first;

    final accessibility = context.watch<AccessibilityProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, classNumber, subject, accessibility),
            Expanded(
              child: subject.chapters.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: subject.chapters.length,
                      itemBuilder: (context, chapterIndex) {
                        final chapter = subject.chapters[chapterIndex];
                        return _ChapterSection(
                          chapter: chapter,
                          chapterIndex: chapterIndex,
                          classNumber: classNumber,
                          subjectName: subjectName,
                          subjectColor: Color(subject.colorValue),
                          accessibility: accessibility,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader(BuildContext context, int classNumber, SubjectData subject, AccessibilityProvider a11y) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Semantics(
                label: 'Go back',
                button: true,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              const Spacer(),
              // Mode badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      a11y.isVideoMode ? Icons.sign_language : Icons.headphones,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      a11y.isVideoMode ? 'Deaf Mode' : 'Blind Mode',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CLASS $classNumber',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subject.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  semanticsLabel: 'Class $classNumber ${subject.name}',
                ),
                const SizedBox(height: 8),
                Text(
                  '${subject.chapters.length} chapter${subject.chapters.length != 1 ? 's' : ''} • ${subject.chapters.fold<int>(0, (sum, ch) => sum + ch.lessons.length)} lessons',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.upcoming, size: 64, color: AppColors.primary.withValues(alpha: 0.4)),
            const SizedBox(height: 16),
            Text(
              'Lessons Coming Soon!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'We are preparing amazing content for this subject.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChapterSection extends StatelessWidget {
  final ChapterData chapter;
  final int chapterIndex;
  final int classNumber;
  final String subjectName;
  final Color subjectColor;
  final AccessibilityProvider accessibility;

  const _ChapterSection({
    required this.chapter,
    required this.chapterIndex,
    required this.classNumber,
    required this.subjectName,
    required this.subjectColor,
    required this.accessibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (chapterIndex > 0) const SizedBox(height: 24),
        // Chapter header
        Semantics(
          label: 'Chapter ${chapterIndex + 1}: ${chapter.title}',
          header: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: subjectColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${chapterIndex + 1}',
                      style: TextStyle(fontWeight: FontWeight.w700, color: subjectColor, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    chapter.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  '${chapter.lessons.length} lesson${chapter.lessons.length != 1 ? 's' : ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Lesson cards
        ...chapter.lessons.asMap().entries.map((entry) {
          final lessonIndex = entry.key;
          final lesson = entry.value;
          return _LessonCard(
            lesson: lesson,
            lessonIndex: lessonIndex,
            chapter: chapter,
            classNumber: classNumber,
            subjectName: subjectName,
            subjectColor: subjectColor,
            accessibility: accessibility,
          );
        }),
      ],
    );
  }
}

class _LessonCard extends StatelessWidget {
  final LessonContent lesson;
  final int lessonIndex;
  final ChapterData chapter;
  final int classNumber;
  final String subjectName;
  final Color subjectColor;
  final AccessibilityProvider accessibility;

  const _LessonCard({
    required this.lesson,
    required this.lessonIndex,
    required this.chapter,
    required this.classNumber,
    required this.subjectName,
    required this.subjectColor,
    required this.accessibility,
  });

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        label: 'Lesson ${lessonIndex + 1}: ${lesson.title}. Duration ${_formatDuration(lesson.durationSeconds)}. ${lesson.description}',
        button: true,
        child: Card(
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () {
              accessibility.triggerHaptic();
              accessibility.speak(lesson.title);
              final route = accessibility.isVideoMode
                  ? AppRoutes.lessonVideo
                  : AppRoutes.lessonAudio;
              Navigator.pushNamed(context, route, arguments: {
                'lesson': lesson,
                'unitLabel': chapter.unitLabel,
                'chapter': chapter,
                'classNumber': classNumber,
                'subjectName': subjectName,
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Lesson number circle
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: subjectColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        accessibility.isVideoMode ? Icons.videocam : Icons.headphones,
                        color: subjectColor,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Lesson info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lesson.description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              _formatDuration(lesson.durationSeconds),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.quiz_outlined, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              '${lesson.quizQuestions.length} quiz${lesson.quizQuestions.length != 1 ? 'zes' : ''}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.play_circle_outline, color: subjectColor, size: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
