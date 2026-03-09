import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/constants/app_routes.dart';
import '../../core/data/lesson_data.dart';
import '../../core/theme/app_colors.dart';

class VideoLessonScreen extends StatefulWidget {
  const VideoLessonScreen({super.key});

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen> {
  bool _isPlaying = false;
  bool _captionsEnabled = true;
  double _progress = 0.0;
  double _volume = 0.8;
  bool _isFullscreen = false;
  int _currentCaptionIndex = 0;
  double _playbackSpeed = 1.0;

  LessonContent? _lesson;
  String _unitLabel = 'UNIT: LESSON';
  String _lessonTitle = 'Lesson';

  Timer? _playbackTimer;
  int _elapsedSeconds = 0;
  int get _totalDuration => _lesson?.durationSeconds ?? 300;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && _lesson == null) {
      _lesson = args['lesson'] as LessonContent?;
      _unitLabel = args['unitLabel'] as String? ?? _unitLabel;
      _lessonTitle = _lesson?.title ?? _lessonTitle;
    }
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    super.dispose();
  }

  void _togglePlayback(AccessibilityProvider a11y) {
    a11y.triggerHaptic();
    setState(() => _isPlaying = !_isPlaying);
    a11y.speakAlways(_isPlaying ? 'Playing' : 'Paused');

    if (_isPlaying) {
      _startPlaybackTimer();
    } else {
      _playbackTimer?.cancel();
    }
  }

  void _startPlaybackTimer() {
    _playbackTimer?.cancel();
    final intervalMs = (1000 / _playbackSpeed).round();
    _playbackTimer = Timer.periodic(Duration(milliseconds: intervalMs), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _elapsedSeconds++;
        _progress = (_elapsedSeconds / _totalDuration).clamp(0.0, 1.0);

        // Auto-advance captions based on progress
        final captions = _lesson?.captions ?? [];
        if (captions.isNotEmpty) {
          final newIndex = (_progress * captions.length).floor().clamp(0, captions.length - 1);
          if (newIndex != _currentCaptionIndex) {
            _currentCaptionIndex = newIndex;
          }
        }

        if (_elapsedSeconds >= _totalDuration) {
          _isPlaying = false;
          timer.cancel();
        }
      });
    });
  }

  void _seekTo(double value) {
    setState(() {
      _progress = value.clamp(0.0, 1.0);
      _elapsedSeconds = (_progress * _totalDuration).round();

      final captions = _lesson?.captions ?? [];
      if (captions.isNotEmpty) {
        _currentCaptionIndex = (_progress * captions.length).floor().clamp(0, captions.length - 1);
      }
    });
    if (_isPlaying) _startPlaybackTimer();
  }

  void _skip(int seconds, AccessibilityProvider a11y) {
    a11y.triggerHaptic();
    a11y.speakAlways(seconds > 0 ? 'Skip forward $seconds seconds' : 'Skip backward ${-seconds} seconds');
    _seekTo((_elapsedSeconds + seconds) / _totalDuration);
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();
    final lesson = _lesson;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with gradient
              _buildHeader(context),
              // Video player area
              _buildVideoPlayer(context, accessibility),
              // Captions section
              if (_captionsEnabled) _buildCaptionsSection(context, lesson),
              // Key visual points
              _buildKeyVisualPoints(context, lesson),
              // Transcript + Quiz buttons
              _buildActionButtons(context, accessibility, lesson),
              const SizedBox(height: 16),
              // Gesture guide
              _buildGestureGuide(context),
              const SizedBox(height: 24),
            ],
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
                label: 'Go back',
                button: true,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.sign_language, size: 16, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'Deaf Mode Active',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
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
                  semanticsLabel: _lessonTitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(BuildContext context, AccessibilityProvider a11y) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Video placeholder
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Simulated video content area
                  if (_isPlaying)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_circle_filled, size: 40, color: Colors.white.withValues(alpha: 0.3)),
                        const SizedBox(height: 8),
                        Text(
                          _lessonTitle,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Playing...',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
                        ),
                      ],
                    )
                  else
                    Icon(Icons.play_circle_outline, size: 64, color: Colors.white.withValues(alpha: 0.7)),
                  // Captions badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Semantics(
                      label: _captionsEnabled ? 'Captions enabled' : 'Captions disabled',
                      button: true,
                      child: GestureDetector(
                        onTap: () => setState(() => _captionsEnabled = !_captionsEnabled),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _captionsEnabled ? AppColors.primary : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.closed_caption, size: 16, color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                _captionsEnabled ? 'CAPTIONS ENABLED' : 'CAPTIONS OFF',
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                // Progress bar
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor: Colors.white24,
                    thumbColor: AppColors.primary,
                  ),
                  child: Semantics(
                    label: 'Video progress, ${(_progress * 100).toInt()} percent',
                    slider: true,
                    child: Slider(
                      value: _progress,
                      onChanged: (v) => _seekTo(v),
                    ),
                  ),
                ),
                // Time labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatTime(_elapsedSeconds), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      Text(_formatTime(_totalDuration), style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Playback controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Semantics(
                      label: 'Volume',
                      button: true,
                      child: IconButton(
                        onPressed: () {
                          a11y.triggerHaptic();
                          setState(() => _volume = _volume > 0 ? 0.0 : 0.8);
                          a11y.speakAlways(_volume > 0 ? 'Volume on' : 'Volume muted');
                        },
                        icon: Icon(
                          _volume > 0 ? Icons.volume_up : Icons.volume_off,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Semantics(
                      label: 'Skip backward 10 seconds',
                      button: true,
                      child: IconButton(
                        onPressed: () => _skip(-10, a11y),
                        icon: const Icon(Icons.replay_10, color: Colors.white, size: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Semantics(
                      label: _isPlaying ? 'Pause' : 'Play lesson $_lessonTitle',
                      button: true,
                      child: GestureDetector(
                        onTap: () => _togglePlayback(a11y),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Semantics(
                      label: 'Skip forward 10 seconds',
                      button: true,
                      child: IconButton(
                        onPressed: () => _skip(10, a11y),
                        icon: const Icon(Icons.forward_10, color: Colors.white, size: 32),
                      ),
                    ),
                    Semantics(
                      label: 'Playback speed ${_playbackSpeed}x',
                      button: true,
                      child: GestureDetector(
                        onTap: () {
                          a11y.triggerHaptic();
                          setState(() {
                            const speeds = [0.5, 1.0, 1.5, 2.0];
                            final idx = speeds.indexOf(_playbackSpeed);
                            _playbackSpeed = speeds[(idx + 1) % speeds.length];
                          });
                          if (_isPlaying) _startPlaybackTimer();
                          a11y.speakAlways('Speed ${_playbackSpeed}x');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_playbackSpeed}x',
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    Semantics(
                      label: 'Fullscreen',
                      button: true,
                      child: IconButton(
                        onPressed: () {
                          a11y.triggerHaptic();
                          setState(() => _isFullscreen = !_isFullscreen);
                          a11y.speakAlways(_isFullscreen ? 'Fullscreen on' : 'Fullscreen off');
                        },
                        icon: Icon(
                          _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                // Volume slider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.volume_down, color: Colors.white54, size: 16),
                      Expanded(
                        child: Semantics(
                          label: 'Volume level, ${(_volume * 100).toInt()} percent',
                          slider: true,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                              activeTrackColor: Colors.white70,
                              inactiveTrackColor: Colors.white24,
                              thumbColor: Colors.white,
                            ),
                            child: Slider(
                              value: _volume,
                              onChanged: (v) => setState(() => _volume = v),
                            ),
                          ),
                        ),
                      ),
                      const Icon(Icons.volume_up, color: Colors.white54, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptionsSection(BuildContext context, LessonContent? lesson) {
    final captions = lesson?.captions ?? ['Captions will appear here when the lesson plays.'];
    final currentCaption = captions[_currentCaptionIndex % captions.length];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.subtitles, size: 20, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Live Captions',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  if (captions.length > 1)
                    Text(
                      '${_currentCaptionIndex + 1}/${captions.length}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (captions.length <= 1) return;
                  if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
                    setState(() => _currentCaptionIndex = (_currentCaptionIndex + 1) % captions.length);
                  } else if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
                    setState(() => _currentCaptionIndex = (_currentCaptionIndex - 1 + captions.length) % captions.length);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    currentCaption,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    semanticsLabel: 'Caption: $currentCaption',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyVisualPoints(BuildContext context, LessonContent? lesson) {
    final points = lesson?.keyVisualPoints ?? [];
    if (points.isEmpty) return const SizedBox.shrink();

    // Map icon names to IconData
    IconData getIcon(String name) {
      const iconMap = {
        'eco': Icons.eco,
        'water_drop': Icons.water_drop,
        'vertical_align_top': Icons.vertical_align_top,
        'air': Icons.air,
        'abc': Icons.abc,
        'record_voice_over': Icons.record_voice_over,
        'pets': Icons.pets,
        'music_note': Icons.music_note,
        'calculate': Icons.calculate,
        'science': Icons.science,
        'menu_book': Icons.menu_book,
        'auto_stories': Icons.auto_stories,
        'numbers': Icons.numbers,
        'lightbulb': Icons.lightbulb,
        'thermostat': Icons.thermostat,
        'height': Icons.height,
        'school': Icons.school,
      };
      return iconMap[name] ?? Icons.star;
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Visual Points',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: points.map((p) {
              final color = Color(p.colorValue);
              return Semantics(
                label: '${p.title}: ${p.subtitle}',
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(getIcon(p.iconName), color: color, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          p.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          p.subtitle,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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

  Widget _buildActionButtons(BuildContext context, AccessibilityProvider a11y, LessonContent? lesson) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    'lesson': lesson,
                    'lessonTitle': _lessonTitle,
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(14),
                ),
                icon: const Icon(Icons.description, color: AppColors.primary),
                label: const Text('Transcript', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
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
                onPressed: (lesson?.quizQuestions.isNotEmpty ?? false)
                    ? () {
                        a11y.triggerHaptic();
                        a11y.speak('Starting quiz');
                        Navigator.pushNamed(context, AppRoutes.quiz, arguments: {
                          'questions': lesson!.quizQuestions,
                          'lessonTitle': _lessonTitle,
                          'unitLabel': _unitLabel,
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(14),
                ),
                icon: const Icon(Icons.quiz),
                label: Text('Quiz (${lesson?.quizQuestions.length ?? 0})', style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGestureGuide(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.gesture, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Quick Gesture Guide',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _gestureRow('Swipe Left/Right', 'Change Concept'),
              _gestureRow('Double Tap', 'Bookmark'),
              _gestureRow('Two Finger Tap', 'Toggle Captions'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gestureRow(String gesture, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Semantics(
        label: '$gesture: $action',
        child: Row(
          children: [
            Expanded(
              child: Text(
                gesture,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
            Text(
              action,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
