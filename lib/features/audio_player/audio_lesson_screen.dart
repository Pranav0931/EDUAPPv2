import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/theme/app_colors.dart';

class AudioLessonScreen extends StatefulWidget {
  const AudioLessonScreen({super.key});

  @override
  State<AudioLessonScreen> createState() => _AudioLessonScreenState();
}

class _AudioLessonScreenState extends State<AudioLessonScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  double _progress = 0.32; // 04:12 of ~13 min
  double _speed = 1.0;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
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
            const SizedBox(height: 32),
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
                  'UNIT 3: SCIENCE',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Plants Around Us',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  semanticsLabel: 'Lesson: Plants Around Us',
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
      label: _isPlaying ? 'Pause lesson Plants Around Us' : 'Play lesson Plants Around Us',
      button: true,
      child: GestureDetector(
        onTap: () {
          a11y.triggerHaptic();
          setState(() => _isPlaying = !_isPlaying);
          a11y.speak(_isPlaying ? 'Playing' : 'Paused');
          if (_isPlaying) {
            _pulseController.repeat(reverse: true);
          } else {
            _pulseController.stop();
          }
        },
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
                onChanged: (v) => setState(() => _progress = v),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '04:12',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                  semanticsLabel: '4 minutes 12 seconds',
                ),
                Text(
                  'Remaining: 08:45',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                  semanticsLabel: 'Remaining 8 minutes 45 seconds',
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
                onPressed: () {
                  a11y.triggerHaptic();
                  a11y.speak('Skip backward 10 seconds');
                },
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
                onPressed: () {
                  a11y.triggerHaptic();
                  a11y.speak('Skip forward 10 seconds');
                },
                icon: const Icon(Icons.forward_10, size: 36, color: AppColors.textPrimary),
              ),
              const Text('+10s', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
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
                  onTap: () {
                    final a11y = context.read<AccessibilityProvider>();
                    a11y.triggerHaptic();
                    setState(() => _speed = s);
                    a11y.speak('Speed ${s}x');
                  },
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


