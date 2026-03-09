import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/data/lesson_data.dart';
import '../../core/theme/app_colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _selectedOption = -1;
  int _currentQuestion = 0;
  int _correctCount = 0;
  bool _answered = false;
  bool _quizFinished = false;

  List<QuizQuestion> _questions = [];
  String _lessonTitle = 'Quiz';
  String _unitLabel = 'Quiz';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_questions.isEmpty) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _questions = (args?['questions'] as List<QuizQuestion>?) ?? _defaultQuestions;
      _lessonTitle = args?['lessonTitle'] as String? ?? 'Quiz';
      _unitLabel = args?['unitLabel'] as String? ?? 'Quiz';
    }
  }

  static const _defaultQuestions = [
    QuizQuestion(
      question: 'Which part of the plant makes food using sunlight?',
      options: ['Roots', 'Leaves', 'Stem', 'Flower'],
      correctIndex: 1,
      explanation: 'Leaves use sunlight to make food through photosynthesis.',
      imageDescription: 'A healthy green plant with leaves, stem and roots visible',
    ),
  ];

  static const _optionLabels = ['A', 'B', 'C', 'D'];

  QuizQuestion get _current => _questions[_currentQuestion];

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();

    if (_quizFinished) {
      return _buildResultsScreen(context, accessibility);
    }

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
                    // Question card
                    _buildQuestionCard(context),
                    const SizedBox(height: 20),
                    // Options
                    ..._buildOptions(context, accessibility),
                    const SizedBox(height: 16),
                    // Explanation (after answering)
                    if (_answered) _buildExplanation(context),
                    const SizedBox(height: 24),
                    // Next button
                    _buildNextButton(context, accessibility),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen(BuildContext context, AccessibilityProvider a11y) {
    final percentage = (_correctCount / _questions.length * 100).round();
    final passed = percentage >= 60;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      a11y.speakAlways(
        'Quiz complete! You scored $percentage percent. $_correctCount out of ${_questions.length} correct. '
        '${passed ? "Great job!" : "Keep practicing!"}',
      );
      a11y.triggerPatternHaptic(isPositive: passed);
    });

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  passed ? Icons.emoji_events : Icons.refresh,
                  size: 80,
                  color: passed ? AppColors.success : AppColors.warning,
                ),
                const SizedBox(height: 24),
                Text(
                  passed ? 'Great Job!' : 'Keep Practicing!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$percentage% Score',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: passed ? AppColors.success : AppColors.warning,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$_correctCount of ${_questions.length} correct answers',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      a11y.triggerHaptic();
                      setState(() {
                        _currentQuestion = 0;
                        _correctCount = 0;
                        _selectedOption = -1;
                        _answered = false;
                        _quizFinished = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      a11y.triggerHaptic();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Back to Lesson', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
              // Score indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Score: $_correctCount/${_currentQuestion + (_answered ? 1 : 0)}',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
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
                  _lessonTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  semanticsLabel: _lessonTitle,
                ),
                const SizedBox(height: 4),
                Text(
                  _unitLabel,
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
            Text(
              'Question ${_currentQuestion + 1} of ${_questions.length}',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              semanticsLabel: 'Question ${_currentQuestion + 1} of ${_questions.length}',
            ),
          ],
        ),
        const SizedBox(height: 12),
        Semantics(
          label: 'Quiz progress, ${_currentQuestion + 1} of ${_questions.length} questions',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_currentQuestion + 1) / _questions.length,
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (_current.imageDescription.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Semantics(
                    label: _current.imageDescription,
                    image: true,
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Color(0xFF4CAF50)),
                    ),
                  ),
                ),
              ),
            Text(
              _current.question,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
              semanticsLabel: _current.question,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOptions(BuildContext context, AccessibilityProvider a11y) {
    return List.generate(_current.options.length, (index) {
      final isSelected = _selectedOption == index;
      final isCorrect = _answered && index == _current.correctIndex;
      final isWrong = _answered && isSelected && index != _current.correctIndex;

      Color bgColor = Colors.white;
      Color borderColor = AppColors.primary.withValues(alpha: 0.2);
      Color textColor = AppColors.textPrimary;

      if (_answered) {
        if (isCorrect) {
          bgColor = AppColors.success;
          borderColor = AppColors.success;
          textColor = Colors.white;
        } else if (isWrong) {
          bgColor = AppColors.error;
          borderColor = AppColors.error;
          textColor = Colors.white;
        }
      } else if (isSelected) {
        bgColor = AppColors.primary;
        borderColor = AppColors.primary;
        textColor = Colors.white;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Semantics(
          label: '${_optionLabels[index]}: ${_current.options[index]}${isSelected ? ', selected' : ''}${isCorrect ? ', correct answer' : ''}${isWrong ? ', wrong answer' : ''}',
          button: true,
          selected: isSelected,
          child: InkWell(
            onTap: _answered
                ? null
                : () {
                    a11y.triggerHaptic();
                    setState(() => _selectedOption = index);
                    a11y.speak('${_optionLabels[index]} ${_current.options[index]}');
                  },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderColor, width: isSelected || isCorrect ? 2 : 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: (isSelected || isCorrect || isWrong) ? Colors.white.withValues(alpha: 0.3) : AppColors.optionDefault,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: _answered
                          ? Icon(
                              isCorrect ? Icons.check : (isWrong ? Icons.close : null),
                              color: textColor,
                              size: 20,
                            )
                          : Text(
                              _optionLabels[index],
                              style: TextStyle(fontWeight: FontWeight.w700, color: textColor),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      _current.options[index],
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildExplanation(BuildContext context) {
    if (_current.explanation.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb, color: AppColors.info, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _current.explanation,
              style: const TextStyle(color: AppColors.textPrimary, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, AccessibilityProvider a11y) {
    if (!_answered) {
      // Submit answer button
      return Semantics(
        label: 'Submit answer',
        button: true,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _selectedOption >= 0
                ? () {
                    final isCorrect = _selectedOption == _current.correctIndex;
                    setState(() => _answered = true);
                    if (isCorrect) {
                      _correctCount++;
                      a11y.triggerPatternHaptic(isPositive: true);
                      a11y.speak('Correct! ${_current.explanation}');
                    } else {
                      a11y.triggerPatternHaptic(isPositive: false);
                      a11y.speak('Wrong. The correct answer is ${_current.options[_current.correctIndex]}. ${_current.explanation}');
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Text('Submit Answer', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            label: const Icon(Icons.check),
          ),
        ),
      );
    }

    // Next question or finish button
    final isLast = _currentQuestion >= _questions.length - 1;
    return Semantics(
      label: isLast ? 'See results' : 'Next question',
      button: true,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            a11y.triggerHaptic();
            if (isLast) {
              setState(() => _quizFinished = true);
            } else {
              setState(() {
                _currentQuestion++;
                _selectedOption = -1;
                _answered = false;
              });
              a11y.speak('Question ${_currentQuestion + 1} of ${_questions.length}. ${_current.question}');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isLast ? AppColors.success : AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: Text(isLast ? 'See Results' : 'Next Question', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          label: Icon(isLast ? Icons.emoji_events : Icons.arrow_forward),
        ),
      ),
    );
  }
}
