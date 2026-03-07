import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/settings_provider.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityProvider>();
    final settings = context.watch<SettingsProvider>();

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
          'Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Accessibility section header
          _SectionHeader(
            icon: Icons.accessibility_new,
            title: 'Accessibility',
          ),
          const SizedBox(height: 12),
          // TalkBack
          _SettingsTile(
            icon: Icons.record_voice_over,
            title: 'TalkBack Support',
            subtitle: 'Screen reader optimization',
            trailing: Switch(
              value: accessibility.talkBackEnabled,
              onChanged: (v) {
                accessibility.triggerHaptic();
                accessibility.toggleTalkBack(v);
                accessibility.speak(v ? 'TalkBack enabled' : 'TalkBack disabled');
              },
              activeThumbColor: AppColors.primary,
            ),
            semanticLabel: 'TalkBack Support, ${accessibility.talkBackEnabled ? "enabled" : "disabled"}',
          ),
          // High contrast
          _SettingsTile(
            icon: Icons.contrast,
            title: 'High Contrast Mode',
            subtitle: 'Increase visual clarity',
            trailing: Switch(
              value: accessibility.highContrastEnabled,
              onChanged: (v) {
                accessibility.triggerHaptic();
                accessibility.toggleHighContrast(v);
                accessibility.speak(v ? 'High contrast enabled' : 'High contrast disabled');
              },
              activeThumbColor: AppColors.primary,
            ),
            semanticLabel: 'High Contrast Mode, ${accessibility.highContrastEnabled ? "enabled" : "disabled"}',
          ),
          // Large text
          _SettingsTile(
            icon: Icons.text_fields,
            title: 'Large Text Mode',
            subtitle: 'Scalable interface fonts',
            trailing: Switch(
              value: accessibility.largeTextEnabled,
              onChanged: (v) {
                accessibility.triggerHaptic();
                accessibility.toggleLargeText(v);
                accessibility.speak(v ? 'Large text enabled' : 'Large text disabled');
              },
              activeThumbColor: AppColors.primary,
            ),
            semanticLabel: 'Large Text Mode, ${accessibility.largeTextEnabled ? "enabled" : "disabled"}',
          ),
          // Haptic feedback
          _SettingsTile(
            icon: Icons.vibration,
            title: 'Haptic Feedback',
            subtitle: 'Vibration on interactions',
            trailing: Switch(
              value: accessibility.hapticFeedbackEnabled,
              onChanged: (v) {
                accessibility.toggleHapticFeedback(v);
                accessibility.speak(v ? 'Haptic feedback enabled' : 'Haptic feedback disabled');
              },
              activeThumbColor: AppColors.primary,
            ),
            semanticLabel: 'Haptic Feedback, ${accessibility.hapticFeedbackEnabled ? "enabled" : "disabled"}',
          ),
          const SizedBox(height: 24),
          // General section
          _SectionHeader(icon: Icons.settings, title: 'General'),
          const SizedBox(height: 12),
          // Language
          _SettingsTile(
            icon: Icons.language,
            title: 'Language Selector',
            subtitle: settings.language,
            trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            onTap: () {
              accessibility.triggerHaptic();
              accessibility.speak('Language selector');
            },
            semanticLabel: 'Language: ${settings.language}',
          ),
          // Notifications
          _SettingsTile(
            icon: Icons.notifications_active,
            title: 'Notifications',
            subtitle: 'Daily reminders and updates',
            trailing: Switch(
              value: settings.notifications,
              onChanged: (v) {
                accessibility.triggerHaptic();
                settings.toggleNotifications(v);
                accessibility.speak(v ? 'Notifications enabled' : 'Notifications disabled');
              },
              activeThumbColor: AppColors.primary,
            ),
            semanticLabel: 'Notifications, ${settings.notifications ? "enabled" : "disabled"}',
          ),
          // Dark mode
          _SettingsTile(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Optimize for low light',
            trailing: Switch(
              value: settings.darkMode,
              onChanged: (v) {
                accessibility.triggerHaptic();
                settings.toggleDarkMode(v);
                accessibility.speak(v ? 'Dark mode enabled' : 'Dark mode disabled');
              },
              activeThumbColor: AppColors.primary,
            ),
            semanticLabel: 'Dark Mode, ${settings.darkMode ? "enabled" : "disabled"}',
          ),
          const SizedBox(height: 32),
          // Sign out
          Semantics(
            label: 'Sign out',
            button: true,
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  accessibility.triggerHaptic();
                  accessibility.speak('Sign out');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Version
          Center(
            child: Text(
              'EduApp v${AppConstants.appVersion}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;
  final String semanticLabel;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          onTap: onTap,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          trailing: trailing,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
      ),
    );
  }
}
