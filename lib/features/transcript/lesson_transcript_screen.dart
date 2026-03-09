import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/data/lesson_data.dart';
import '../../core/theme/app_colors.dart';

class LessonTranscriptScreen extends StatefulWidget {
  const LessonTranscriptScreen({super.key});

  @override
  State<LessonTranscriptScreen> createState() => _LessonTranscriptScreenState();
}

class _LessonTranscriptScreenState extends State<LessonTranscriptScreen> {
  int _currentParagraph = 0;
  bool _isAutoReading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
    final lesson = args['lesson'] as LessonContent?;
    final lessonTitle = args['lessonTitle'] as String? ?? 'Lesson';

    if (lesson == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Transcript')),
        body: const Center(child: Text('No transcript available for this lesson.')),
      );
    }

    final paragraphs = _splitIntoParagraphs(lesson.transcript);
    final a11y = context.watch<AccessibilityProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, lessonTitle),
            // Key visual points for deaf users
            if (lesson.keyVisualPoints.isNotEmpty)
              _buildKeyPointsBar(context, lesson.keyVisualPoints),
            // Transcript body
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                itemCount: paragraphs.length,
                itemBuilder: (context, index) {
                  return _ParagraphCard(
                    text: paragraphs[index],
                    index: index,
                    isActive: _currentParagraph == index,
                    onTap: () => _readParagraph(index, paragraphs, a11y),
                  );
                },
              ),
            ),
            // Bottom controls
            _buildBottomControls(context, paragraphs, a11y),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Semantics(
            label: 'Go back',
            button: true,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transcript',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyPointsBar(BuildContext context, List<KeyVisualPoint> points) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.visibility, size: 16, color: AppColors.info),
              const SizedBox(width: 6),
              Text(
                'Key Visual Points',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: AppColors.info, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                      '${p.title}: ${p.subtitle}',
                      style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(
    BuildContext context,
    List<String> paragraphs,
    AccessibilityProvider a11y,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Previous paragraph
          Semantics(
            label: 'Previous paragraph',
            button: true,
            child: IconButton(
              onPressed: _currentParagraph > 0
                  ? () => _readParagraph(_currentParagraph - 1, paragraphs, a11y)
                  : null,
              icon: const Icon(Icons.skip_previous, size: 32),
              color: AppColors.primary,
            ),
          ),
          // Read all / Stop
          Semantics(
            label: _isAutoReading ? 'Stop reading' : 'Read all paragraphs',
            button: true,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_isAutoReading) {
                  _stopAutoRead(a11y);
                } else {
                  _startAutoRead(paragraphs, a11y);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isAutoReading ? AppColors.error : AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              icon: Icon(_isAutoReading ? Icons.stop : Icons.play_arrow),
              label: Text(_isAutoReading ? 'Stop' : 'Read All'),
            ),
          ),
          // Next paragraph
          Semantics(
            label: 'Next paragraph',
            button: true,
            child: IconButton(
              onPressed: _currentParagraph < paragraphs.length - 1
                  ? () => _readParagraph(_currentParagraph + 1, paragraphs, a11y)
                  : null,
              icon: const Icon(Icons.skip_next, size: 32),
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _splitIntoParagraphs(String transcript) {
    // Split by double newlines or by sentences (period + space).
    // Prefer sentence groups of 2-3 for comfortable reading.
    final sentences = transcript
        .split(RegExp(r'(?<=[.!?])\s+'))
        .where((s) => s.trim().isNotEmpty)
        .toList();

    if (sentences.length <= 3) return sentences;

    final paragraphs = <String>[];
    for (var i = 0; i < sentences.length; i += 2) {
      final end = (i + 2 <= sentences.length) ? i + 2 : sentences.length;
      paragraphs.add(sentences.sublist(i, end).join(' '));
    }
    return paragraphs;
  }

  void _readParagraph(int index, List<String> paragraphs, AccessibilityProvider a11y) {
    setState(() => _currentParagraph = index);
    a11y.triggerHaptic();
    a11y.speakAlways('Paragraph ${index + 1} of ${paragraphs.length}. ${paragraphs[index]}');
  }

  void _startAutoRead(List<String> paragraphs, AccessibilityProvider a11y) {
    setState(() => _isAutoReading = true);
    // Read all remaining paragraphs as one long content
    final remaining = paragraphs.sublist(_currentParagraph).join('. ');
    a11y.speakLongContent(remaining);
  }

  void _stopAutoRead(AccessibilityProvider a11y) {
    setState(() => _isAutoReading = false);
    a11y.stopSpeaking();
  }
}

class _ParagraphCard extends StatelessWidget {
  final String text;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const _ParagraphCard({
    required this.text,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Paragraph ${index + 1}. $text. Tap to read aloud.',
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary.withValues(alpha: 0.08) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: isActive ? 2 : 0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Paragraph number
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.6,
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
              if (isActive)
                const Icon(Icons.volume_up, size: 20, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
