import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final String variant;
  final bool fullWidth;
  final bool disabled;

  const GradientButton({
    Key? key,
    required this.child,
    this. onPressed,
    this.variant = 'orange',
    this.fullWidth = false,
    this.disabled = false,
  }) : super(key: key);

  List<Color> get gradientColors {
    switch (variant) {
      case 'orange':
        return [const Color(0xFFFF9E57), const Color(0xFFFF7D40)];
      case 'blue':
        return [const Color(0xFF0A6DD9), const Color(0xFF63C7FF)];
      case 'turquoise':
        return [const Color(0xFF2BB9A9), const Color(0xFF3BAA5C)];
      case 'green':
        return [const Color(0xFF3BAA5C), const Color(0xFF2BB9A9)];
      case 'sunset':
        return [const Color(0xFFFF9E57), const Color(0xFFF43F5E)];
      case 'nile':
        return [const Color(0xFF0A6DD9), const Color(0xFF2BB9A9)];
      default:
        return [const Color(0xFFFF9E57), const Color(0xFFFF7D40)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: disabled ? [Colors.grey, Colors.grey] : gradientColors),
          borderRadius: BorderRadius.circular(16),
          boxShadow: disabled
              ? []
              : [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          child: child,
        ),
      ),
    );
  }
}