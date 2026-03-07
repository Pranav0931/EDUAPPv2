import 'package:flutter/material.dart';

/// Provides a consistent semantic wrapper with label, hint, and role.
class SemanticWrapper extends StatelessWidget {
  final Widget child;
  final String label;
  final String? hint;
  final bool isButton;
  final bool isHeader;
  final bool isImage;

  const SemanticWrapper({
    super.key,
    required this.child,
    required this.label,
    this.hint,
    this.isButton = false,
    this.isHeader = false,
    this.isImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint,
      button: isButton,
      header: isHeader,
      image: isImage,
      child: child,
    );
  }
}
