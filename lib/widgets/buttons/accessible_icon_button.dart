import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/accessibility/accessibility_provider.dart';

class AccessibleIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final double size;

  const AccessibleIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: IconButton(
        onPressed: () {
          final a11y = context.read<AccessibilityProvider>();
          a11y.triggerHaptic();
          a11y.speak(label);
          onPressed();
        },
        icon: Icon(icon, size: size, color: color),
        tooltip: label,
      ),
    );
  }
}
