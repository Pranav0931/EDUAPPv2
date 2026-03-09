import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/constants/app_routes.dart';
import '../../core/data/lesson_data.dart';
import '../../core/theme/app_colors.dart';

class AudioLessonScreen extends StatefulWidget {
  const AudioLessonScreen({super.key});

  @override
  State<AudioLessonScreen> createState() => _AudioLessonScreenState();
}

class _AudioLessonScreenState extends State<AudioLessonScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  double _progress = 0.0;
  double _speed = 1.0;
  late AnimationController _pulseController;

  LessonContent? _lesson;
  String _unitLabel = 'UNIT: LESSON';
  String _lessonTitle = 'Lesson';

  // TTS playback
  final FlutterTts _tts = FlutterTts();
  List<String> _sentences = [];
  int _currentSentenceIndex = 0;
  Timer? _progressTimer;
  int _elapsedSeconds = 0;
  int get _totalDuration => _lesson?.durationSeconds ?? 300;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setVolume(1.0);
    await _tts.setSpeechRate(_speed * 0.5); // Scale TTS rate
    await _tts.setPitch(1.0);

    _tts.setCompletionHandler(() {
      if (!mounted) return;
      if (_currentSentenceIndex < _sentences.length - 1) {
        _currentSentenceIndex++;
        _speakCurrentSentence();
      } else {
        // Finished all sentences
        setState(() {
          _isPlaying = false;
          _progress = 1.0;
          _elapsedSeconds = _totalDuration;
        });
        _progressTimer?.cancel();
        _pulseController.stop();
      }
    });

    _tts.setCancelHandler(() {
      if (!mounted) return;
    });
  }

  void _prepareSentences() {
    if (_lesson == null) return;
    final text = _lesson!.transcript;
    _sentences = text.split(RegExp(r'(?<=[.!?])\s+'))
        .where((s) => s.trim().isNotEmpty)
        .toList();
    if (_sentences.isEmpty) {
      _sentences = [_lesson!.description];
    }
  }

  Future<void> _speakCurrentSentence() async {
    if (_currentSentenceIndex >= _sentences.length || !_isPlaying) return;
    final sentence = _sentences[_currentSentenceIndex].trim();
    if (sentence.isNotEmpty) {
      await _tts.speak(sentence);
    }
  }

  void _togglePlayback() {
    final a11y = context.read<AccessibilityProvider>();
    a11y.triggerHaptic();

    if (_isPlaying) {
      // Pause
      _tts.stop();
      _progressTimer?.cancel();
      _pulseController.stop();
      setState(() => _isPlaying = false);
      a11y.speakAlways('Paused');
    } else {
      // Play
      if (_sentences.isEmpty) _prepareSentences();
      if (_progress >= 1.0) {
        // Reset if finished
        _currentSentenceIndex = 0;
        _elapsedSeconds = 0;
        _progress = 0.0;
      }
      setState(() => _isPlaying = true);
      _pulseController.repeat(reverse: true);
      _startProgressTimer();
      _speakCurrentSentence();
    }
  }

  void _startProgressTimer() {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || !_isPlaying) {
        timer.cancel();
        return;
      }
      setState(() {
        _elapsedSeconds++;
        _progress = (_elapsedSeconds / _totalDuration).clamp(0.0, 1.0);
      });
    });
  }

  void _skipForward() {
    final a11y = context.read<AccessibilityProvider>();
    a11y.triggerHaptic();
    a11y.speakAlways('Skip forward');
    if (_sentences.isNotEmpty && _currentSentenceIndex < _sentences.length - 1) {
      _tts.stop();
      _currentSentenceIndex = (_currentSentenceIndex + 2).clamp(0, _sentences.length - 1);
      _elapsedSeconds = (_elapsedSeconds + 10).clamp(0, _totalDuration);
      _progress = (_elapsedSeconds / _totalDuration).clamp(0.0, 1.0);
      if (_isPlaying) _speakCurrentSentence();
    }
  }

  void _skipBackward() {
    final a11y = context.read<AccessibilityProvider>();
    a11y.triggerHaptic();
    a11y.speakAlways('Skip backward');
    if (_sentences.isNotEmpty) {
      _tts.stop();
      _currentSentenceIndex = (_currentSentenceIndex - 2).clamp(0, _sentences.length - 1);
      _elapsedSeconds = (_elapsedSeconds - 10).clamp(0, _totalDuration);
      _progress = (_elapsedSeconds / _totalDuration).clamp(0.0, 1.0);
      if (_isPlaying) _speakCurrentSentence();
    }
  }

  Future<void> _changeSpeed(double newSpeed) async {
    setState(() => _speed = newSpeed);
    await _tts.setSpeechRate(newSpeed * 0.5);
    if (!mounted) return;
    final a11y = context.read<AccessibilityProvider>();
    a11y.triggerHaptic();
    if (_isPlaying) {
      _tts.stop();
      _speakCurrentSentence();
    }
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && _lesson == null) {
      _lesson = args['lesson'] as LessonContent?;
      _unitLabel = args['unitLabel'] as String? ?? _unitLabel;
      _lessonTitle = _lesson?.title ?? _lessonTitle;
      _prepareSentences();

      // Auto-read lesson description for blind users
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final a11y = context.read<AccessibilityProvider>();
        if (a11y.autoReadEnabled && _lesson != null) {
          a11y.speakAlways('Now playing: $_lessonTitle. ${_lesson!.description}. Tap the play button to start listening.');
        }
      });
    }
  }

  @override
  void dispose() {
    _tts.stop();
    _progressTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

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
            const Spacer(flex: 1),
            // Large play button
            _buildPlayButton(context, accessibility),
            const SizedBox(height: 32),
            // Audio visualizer
            _buildVisualizer(),
            const SizedBox(height: 32),
            // Progress bar
            _buildProgressBar(context),
            const SizedBox(height: 24),
            // Playback controls
            _buildControls(context, accessibility),
            const SizedBox(height: 24),
            // Transcript + Quiz buttons
            _buildActionButtons(context, accessibility),
            const SizedBox(height: 16),
            // Speed slider
            _buildSpeedSlider(context),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            label: 'Go back',
            button: true,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _unitLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _lessonTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  semanticsLabel: 'Lesson: $_lessonTitle',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayButton(BuildContext context, AccessibilityProvider a11y) {
    return Semantics(
      label: _isPlaying ? 'Pause lesson $_lessonTitle' : 'Play lesson $_lessonTitle',
      button: true,
      child: GestureDetector(
        onTap: _togglePlayback,
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, _) {
            final scale = _isPlaying ? 1.0 + _pulseController.value * 0.05 : 1.0;
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.splashGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: _isPlaying ? 8 : 4,
                    ),
                  ],
                ),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 56,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVisualizer() {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(20, (index) {
          return AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              final height = _isPlaying
                  ? 12.0 + (sin(index * 0.5 + _pulseController.value * 6.28) + 1) * 18
                  : 12.0;
              return Container(
                width: 4,
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.3 + (index / 20) * 0.7),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Semantics(
            label: 'Audio progress, ${(_progress * 100).toInt()} percent',
            slider: true,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: AppColors.primary.withValues(alpha: 0.2),
                thumbColor: AppColors.primary,
              ),
              child: Slider(
                value: _progress,
                onChanged: (v) {
                  setState(() {
                    _progress = v;
                    _elapsedSeconds = (v * _totalDuration).round();
                    // Update sentence index proportionally
                    if (_sentences.isNotEmpty) {
                      _currentSentenceIndex = (v * _sentences.length).floor().clamp(0, _sentences.length - 1);
                    }
                  });
                  if (_isPlaying) {
                    _tts.stop();
                    _speakCurrentSentence();
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTime(_elapsedSeconds),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                  semanticsLabel: _formatTime(_elapsedSeconds),
                ),
                Text(
                  'Remaining: ${_formatTime(_totalDuration - _elapsedSeconds)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                  semanticsLabel: 'Remaining ${_formatTime(_totalDuration - _elapsedSeconds)}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context, AccessibilityProvider a11y) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Semantics(
          label: 'Skip backward 10 seconds',
          button: true,
          child: Column(
            children: [
              IconButton(
                onPressed: _skipBackward,
                icon: const Icon(Icons.replay_10, size: 36, color: AppColors.textPrimary),
              ),
              const Text('-10s', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Semantics(
          label: 'Playback speed ${_speed}x',
          button: true,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_speed}x',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text('Speed', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Semantics(
          label: 'Skip forward 10 seconds',
          button: true,
          child: Column(
            children: [
              IconButton(
                onPressed: _skipForward,
                icon: const Icon(Icons.forward_10, size: 36, color: AppColors.textPrimary),
              ),
              const Text('+10s', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, AccessibilityProvider a11y) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          // Transcript button
          Expanded(
            child: Semantics(
              label: 'View transcript',
              button: true,
              child: OutlinedButton.icon(
                onPressed: () {
                  a11y.triggerHaptic();
                  a11y.speak('Opening transcript');
                  Navigator.pushNamed(context, AppRoutes.transcript, arguments: {
                    'lesson': _lesson,
                    'lessonTitle': _lessonTitle,
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(12),
                ),
                icon: const Icon(Icons.description, color: AppColors.primary, size: 18),
                label: const Text('Transcript', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Quiz button
          Expanded(
            child: Semantics(
              label: 'Take quiz',
              button: true,
              child: ElevatedButton.icon(
                onPressed: (_lesson?.quizQuestions.isNotEmpty ?? false)
                    ? () {
                        a11y.triggerHaptic();
                        a11y.speak('Starting quiz');
                        Navigator.pushNamed(context, AppRoutes.quiz, arguments: {
                          'questions': _lesson!.quizQuestions,
                          'lessonTitle': _lessonTitle,
                          'unitLabel': _unitLabel,
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(12),
                ),
                icon: const Icon(Icons.quiz, size: 18),
                label: Text('Quiz (${_lesson?.quizQuestions.length ?? 0})', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedSlider(BuildContext context) {
    const speeds = [0.5, 1.0, 1.5, 2.0];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Text(
            'Playback Speed Slider',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: speeds.map((s) {
              final isSelected = s == _speed;
              return Semantics(
                label: 'Set playback speed to ${s}x',
                button: true,
                selected: isSelected,
                child: GestureDetector(
                  onTap: () => _changeSpeed(s),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${s}x',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}


