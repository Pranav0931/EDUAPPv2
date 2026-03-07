import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';

/// Wraps a child widget to speak a label via TTS when tapped.
class SpeakOnTap extends StatelessWidget {
  final Widget child;
  final String label;
  final VoidCallback? onTap;

  const SpeakOnTap({
    super.key,
    required this.child,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: onTap != null,
      child: GestureDetector(
        onTap: () {
          final a11y = context.read<AccessibilityProvider>();
          a11y.triggerHaptic();
          a11y.speak(label);
          onTap?.call();
        },
        child: child,
      ),
    );
  }
}
