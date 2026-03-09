import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/theme/app_colors.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _sosActivated = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    // Auto-announce screen for blind users
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final a11y = context.read<AccessibilityProvider>();
      a11y.speakAlways(
        'Emergency screen. Tap the large SOS button if you need help. '
        'Tap "I am safe" to dismiss.',
      );
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _activateSOS(AccessibilityProvider a11y) {
    setState(() => _sosActivated = true);
    // Strong haptic pattern for both deaf and blind users
    a11y.triggerStrongHaptic();
    Future.delayed(const Duration(milliseconds: 200), () => a11y.triggerStrongHaptic());
    Future.delayed(const Duration(milliseconds: 400), () => a11y.triggerStrongHaptic());

    a11y.speakAlways('SOS activated! Help alert sent. Tap I am safe to cancel.');
  }

  void _deactivateSOS(AccessibilityProvider a11y) {
    setState(() => _sosActivated = false);
    a11y.triggerHaptic();
    a11y.speakAlways('SOS cancelled. You are safe.');
  }

  @override
  Widget build(BuildContext context) {
    final a11y = context.watch<AccessibilityProvider>();

    return Scaffold(
      backgroundColor: _sosActivated ? const Color(0xFFFFEBEE) : AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            const Spacer(flex: 1),
            // SOS Button
            _buildSOSButton(context, a11y),
            const SizedBox(height: 24),
            // Status text
            _buildStatusText(context),
            const SizedBox(height: 32),
            // Quick actions
            _buildQuickActions(context, a11y),
            const Spacer(flex: 2),
            // Safety button
            if (_sosActivated) _buildSafeButton(context, a11y),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
          const Spacer(),
          Text(
            'Emergency',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: _sosActivated ? AppColors.error : AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSOSButton(BuildContext context, AccessibilityProvider a11y) {
    return Semantics(
      label: _sosActivated
          ? 'SOS is active. Help alert has been sent.'
          : 'Tap for SOS. This will send a help alert.',
      button: true,
      child: GestureDetector(
        onTap: () {
          if (!_sosActivated) {
            _activateSOS(a11y);
          }
        },
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, _) {
            final scale = _sosActivated ? 1.0 + _pulseController.value * 0.08 : 1.0;
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _sosActivated ? AppColors.error : AppColors.error.withValues(alpha: 0.9),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.error.withValues(alpha: _sosActivated ? 0.5 : 0.3),
                      blurRadius: _sosActivated ? 40 : 20,
                      spreadRadius: _sosActivated ? 10 : 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _sosActivated ? Icons.warning : Icons.sos,
                      color: Colors.white,
                      size: 56,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _sosActivated ? 'ACTIVE' : 'SOS',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        _sosActivated
            ? 'Help alert has been sent!\nYour teacher/guardian will be notified.'
            : 'Tap the SOS button if you need help.\nYour teacher or guardian will be alerted.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: _sosActivated ? AppColors.error : AppColors.textSecondary,
          fontWeight: _sosActivated ? FontWeight.w600 : FontWeight.w400,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, AccessibilityProvider a11y) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _QuickActionButton(
            icon: Icons.vibration,
            label: 'Vibrate',
            semanticLabel: 'Send vibration alert pattern',
            onTap: () async {
              a11y.triggerStrongHaptic();
              await Future.delayed(const Duration(milliseconds: 150));
              a11y.triggerStrongHaptic();
              await Future.delayed(const Duration(milliseconds: 150));
              a11y.triggerStrongHaptic();
              a11y.speak('Vibration alert sent');
            },
          ),
          _QuickActionButton(
            icon: Icons.volume_up,
            label: 'Speak Alert',
            semanticLabel: 'Speak emergency alert aloud',
            onTap: () {
              a11y.triggerHaptic();
              a11y.speakAlways('Attention! A student needs help. Please check on them immediately.');
            },
          ),
          _QuickActionButton(
            icon: Icons.flashlight_on,
            label: 'Flash Screen',
            semanticLabel: 'Flash the screen white to get attention',
            onTap: () {
              a11y.triggerHaptic();
              // Visual flash for deaf users to attract attention
              HapticFeedback.heavyImpact();
              a11y.speak('Screen flash activated');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSafeButton(BuildContext context, AccessibilityProvider a11y) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Semantics(
        label: 'I am safe. Tap to cancel the emergency alert.',
        button: true,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _deactivateSOS(a11y),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.check_circle, size: 28),
            label: const Text(
              'I Am Safe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String semanticLabel;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.semanticLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
