import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _selectedOption = -1;
  int _currentQuestion = 3;
  final int _totalQuestions = 10;
  int _timerSeconds = 45;

  static const _options = [
    'Roots',
    'Leaves',
    'Stem',
    'Flower',
  ];
  static const _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Quiz content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Progress
                    _buildProgress(context),
                    const SizedBox(height: 20),
                    // Question card with image
                    _buildQuestionCard(context),
                    const SizedBox(height: 20),
                    // Options
                    ..._buildOptions(context, accessibility),
                    const SizedBox(height: 24),
                    // Next button
                    _buildNextButton(context, accessibility),
                    const SizedBox(height: 16),
                    // Bottom actions
                    _buildBottomActions(context, accessibility),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Semantics(
                label: 'Close quiz',
                button: true,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ),
              const Spacer(),
              Semantics(
                label: 'More options',
                button: true,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: Colors.white),
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
                  'Science Quiz',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  semanticsLabel: 'Science Quiz',
                ),
                const SizedBox(height: 4),
                Text(
                  'Unit 3: Plants Around Us',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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

  Widget _buildProgress(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Question number
            Text(
              'Question $_currentQuestion of $_totalQuestions',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              semanticsLabel: 'Question $_currentQuestion of $_totalQuestions',
            ),
            const Spacer(),
            // Timer
            Semantics(
              label: '$_timerSeconds seconds remaining',
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
                      '00:${_timerSeconds.toString().padLeft(2, '0')}',
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
        Semantics(
          label: 'Quiz progress, $_currentQuestion of $_totalQuestions questions',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _currentQuestion / _totalQuestions,
              minHeight: 4,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // Image placeholder
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Semantics(
              label: 'A healthy green plant with leaves, stem and roots visible',
              image: true,
              child: const Center(
                child: Icon(Icons.eco, size: 64, color: Color(0xFF4CAF50)),
              ),
            ),
          ),
          // Question text
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Which part of the plant makes food using sunlight?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
              semanticsLabel: 'Which part of the plant makes food using sunlight?',
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOptions(BuildContext context, AccessibilityProvider a11y) {
    return List.generate(_options.length, (index) {
      final isSelected = _selectedOption == index;
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Semantics(
          label: '${_optionLabels[index]}: ${_options[index]}${isSelected ? ', selected' : ''}',
          button: true,
          selected: isSelected,
          child: InkWell(
            onTap: () {
              a11y.triggerHaptic();
              setState(() => _selectedOption = index);
              a11y.speak('${_optionLabels[index]} ${_options[index]}');
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.primary.withValues(alpha: 0.2),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 2))]
                    : null,
              ),
              child: Row(
                children: [
                  // Letter badge
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : AppColors.optionDefault,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _optionLabels[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      _options[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle, color: Colors.white, size: 24),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNextButton(BuildContext context, AccessibilityProvider a11y) {
    return Semantics(
      label: 'Next question',
      button: true,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _selectedOption >= 0
              ? () {
                  a11y.triggerHaptic();
                  a11y.speak('Next question');
                  setState(() {
                    if (_currentQuestion < _totalQuestions) {
                      _currentQuestion++;
                      _selectedOption = -1;
                      _timerSeconds = 45;
                    }
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Text('Next Question', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          label: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, AccessibilityProvider a11y) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Semantics(
          label: 'Report issue',
          button: true,
          child: TextButton.icon(
            onPressed: () {
              a11y.triggerHaptic();
              a11y.speak('Report issue');
            },
            icon: const Icon(Icons.flag, size: 18, color: AppColors.textSecondary),
            label: const Text('Report issue', style: TextStyle(color: AppColors.textSecondary)),
          ),
        ),
        const SizedBox(width: 24),
        Semantics(
          label: 'Review later',
          button: true,
          child: TextButton.icon(
            onPressed: () {
              a11y.triggerHaptic();
              a11y.speak('Review later');
            },
            icon: const Icon(Icons.visibility, size: 18, color: AppColors.textSecondary),
            label: const Text('Review later', style: TextStyle(color: AppColors.textSecondary)),
          ),
        ),
      ],
    );
  }
}
