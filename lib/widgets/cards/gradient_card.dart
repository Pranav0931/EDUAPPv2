import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final LinearGradient gradient;
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final String? semanticLabel;

  const GradientCard({
    super.key,
    required this.gradient,
    required this.child,
    this.onTap,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(16),
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final card = Material(
      borderRadius: BorderRadius.circular(borderRadius),
      elevation: 4,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          child: child,
        ),
      ),
    );

    if (semanticLabel != null) {
      return Semantics(
        label: semanticLabel,
        button: onTap != null,
        child: card,
      );
    }
    return card;
  }
}
