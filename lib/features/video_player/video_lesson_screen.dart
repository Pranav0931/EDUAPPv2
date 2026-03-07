import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/theme/app_colors.dart';

class VideoLessonScreen extends StatefulWidget {
  const VideoLessonScreen({super.key});

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen> {
  bool _isPlaying = false;
  bool _captionsEnabled = true;
  double _progress = 0.28; // 2:15 of 5:30
  double _volume = 0.8;
  bool _isFullscreen = false;

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();

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
              if (_captionsEnabled) _buildCaptionsSection(context),
              // Key visual points
              _buildKeyVisualPoints(context),
              // Bookmark button
              _buildBookmarkButton(context, accessibility),
              const SizedBox(height: 16),
              // Gesture guide
              _buildGestureGuide(context),
              const SizedBox(height: 16),
              // Coming up next
              _buildComingUpNext(context),
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
                  semanticsLabel: 'Plants Around Us',
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
                      onChanged: (v) => setState(() => _progress = v),
                    ),
                  ),
                ),
                // Time labels
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('02:15', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text('05:30', style: TextStyle(color: Colors.white70, fontSize: 12)),
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
                          a11y.speak(_volume > 0 ? 'Volume on' : 'Volume muted');
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
                        onPressed: () {
                          a11y.triggerHaptic();
                          a11y.speak('Skip backward 10 seconds');
                        },
                        icon: const Icon(Icons.replay_10, color: Colors.white, size: 32),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Semantics(
                      label: _isPlaying ? 'Pause' : 'Play lesson Plants Around Us',
                      button: true,
                      child: GestureDetector(
                        onTap: () {
                          a11y.triggerHaptic();
                          setState(() => _isPlaying = !_isPlaying);
                          a11y.speak(_isPlaying ? 'Playing' : 'Paused');
                        },
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
                        onPressed: () {
                          a11y.triggerHaptic();
                          a11y.speak('Skip forward 10 seconds');
                        },
                        icon: const Icon(Icons.forward_10, color: Colors.white, size: 32),
                      ),
                    ),
                    Semantics(
                      label: 'Fullscreen',
                      button: true,
                      child: IconButton(
                        onPressed: () {
                          a11y.triggerHaptic();
                          setState(() => _isFullscreen = !_isFullscreen);
                          a11y.speak(_isFullscreen ? 'Fullscreen on' : 'Fullscreen off');
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

  Widget _buildCaptionsSection(BuildContext context) {
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
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Plants need sunlight, water, and soil to grow.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  semanticsLabel: 'Caption: Plants need sunlight, water, and soil to grow.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyVisualPoints(BuildContext context) {
    const points = [
      _VisualPoint(Icons.eco, 'Leaves Make Food', 'Leaves use sunlight to make food', Color(0xFF4CAF50)),
      _VisualPoint(Icons.water_drop, 'Roots Absorb Water', 'Roots take water from the soil', Color(0xFF2196F3)),
      _VisualPoint(Icons.vertical_align_top, 'Stem Supports', 'The stem holds the plant upright', Color(0xFF9C27B0)),
      _VisualPoint(Icons.air, 'Plants Give Oxygen', 'Plants release fresh oxygen', Color(0xFF00BCD4)),
    ];

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
                        Icon(p.icon, color: p.color, size: 28),
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

  Widget _buildBookmarkButton(BuildContext context, AccessibilityProvider a11y) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Semantics(
        label: 'Bookmark this concept',
        button: true,
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              a11y.triggerHaptic();
              a11y.speak('Concept bookmarked');
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(14),
            ),
            icon: const Icon(Icons.bookmark_border, color: AppColors.primary),
            label: const Text('Bookmark This Concept', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
        ),
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

  Widget _buildComingUpNext(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Semantics(
        label: 'Coming up next: Parts of a Plant',
        button: true,
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: const Text('Coming Up Next', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            subtitle: const Text('Parts of a Plant', style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right, color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}

class _VisualPoint {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _VisualPoint(this.icon, this.title, this.subtitle, this.color);
}
