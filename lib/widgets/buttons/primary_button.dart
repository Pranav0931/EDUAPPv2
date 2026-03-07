import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;
  final String? semanticLabel;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final button = icon != null
        ? ElevatedButton.icon(
            onPressed: onPressed,
            style: _buttonStyle(),
            icon: Icon(icon, size: 20),
            label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: _buttonStyle(),
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          );

    final wrapped = fullWidth ? SizedBox(width: double.infinity, child: button) : button;

    return Semantics(
      label: semanticLabel ?? label,
      button: true,
      child: wrapped,
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
