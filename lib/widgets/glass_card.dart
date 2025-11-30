import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final String gradient;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const GlassCard({
    Key? key,
    required this.child,
    this.gradient = 'white',
    this.onTap,
    this.padding,
  }) : super(key: key);

  List<Color> getGradientColors(bool isDark) {
    if (isDark) {
      // Dark mode colors - more subtle, darker versions
      switch (gradient) {
        case 'orange':
          return [
            const Color(0xFF2A1F14).withOpacity(0.9),
            const Color(0xFF1E1A14).withOpacity(0.9),
          ];
        case 'blue':
          return [
            const Color(0xFF141E2A).withOpacity(0.9),
            const Color(0xFF14222A).withOpacity(0.9),
          ];
        case 'turquoise':
          return [
            const Color(0xFF142226).withOpacity(0.9),
            const Color(0xFF141F22).withOpacity(0.9),
          ];
        case 'green':
          return [
            const Color(0xFF141F1A).withOpacity(0.9),
            const Color(0xFF141E1A).withOpacity(0.9),
          ];
        case 'beige':
          return [
            const Color(0xFF1E1C14).withOpacity(0.9),
            const Color(0xFF1E1D14).withOpacity(0.9),
          ];
        case 'sunset':
          return [
            const Color(0xFF2A1F14).withOpacity(0.9),
            const Color(0xFF261A1C).withOpacity(0.9),
          ];
        case 'nile':
          return [
            const Color(0xFF141E2A).withOpacity(0.9),
            const Color(0xFF14222A).withOpacity(0.9),
          ];
        case 'rose':
          return [
            const Color(0xFF261A1C).withOpacity(0.9),
            const Color(0xFF241620).withOpacity(0.9),
          ];
        default:
          return [
            const Color(0xFF1E1E1E).withOpacity(0.9),
            const Color(0xFF1E1E1E).withOpacity(0.9),
          ];
      }
    } else {
      // Light mode colors
      switch (gradient) {
        case 'orange':
          return [
            const Color(0xFFFFF7ED).withOpacity(0.8),
            const Color(0xFFFFFBEB).withOpacity(0.8),
          ];
        case 'blue':
          return [
            const Color(0xFFEFF6FF).withOpacity(0.8),
            const Color(0xFFECFEFF).withOpacity(0.8),
          ];
        case 'turquoise':
          return [
            const Color(0xFFECFEFF).withOpacity(0.8),
            const Color(0xFFF0FDFA).withOpacity(0.8),
          ];
        case 'green':
          return [
            const Color(0xFFECFDF5).withOpacity(0.8),
            const Color(0xFFF0FDF4).withOpacity(0.8),
          ];
        case 'beige':
          return [
            const Color(0xFFFFFBEB).withOpacity(0.8),
            const Color(0xFFFEFCE8).withOpacity(0.8),
          ];
        case 'sunset':
          return [
            const Color(0xFFFFF7ED).withOpacity(0.8),
            const Color(0xFFFFF1F2).withOpacity(0.8),
          ];
        case 'nile':
          return [
            const Color(0xFFEFF6FF).withOpacity(0.8),
            const Color(0xFFECFEFF).withOpacity(0.8),
          ];
        case 'rose':
          return [
            const Color(0xFFFFF1F2).withOpacity(0.8),
            const Color(0xFFFCE7F3).withOpacity(0.8),
          ];
        default:
          return [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.8)];
      }
    }
  }

  Color getBorderColor(bool isDark) {
    if (isDark) {
      switch (gradient) {
        case 'orange':
          return const Color(0xFF4A3520).withOpacity(0.5);
        case 'blue':
          return const Color(0xFF204060).withOpacity(0.5);
        case 'turquoise':
          return const Color(0xFF205050).withOpacity(0.5);
        case 'green':
          return const Color(0xFF204030).withOpacity(0.5);
        case 'beige':
          return const Color(0xFF403820).withOpacity(0.5);
        case 'sunset':
          return const Color(0xFF4A3020).withOpacity(0.5);
        case 'nile':
          return const Color(0xFF203850).withOpacity(0.5);
        default:
          return Colors.grey.shade800.withOpacity(0.5);
      }
    } else {
      switch (gradient) {
        case 'orange':
          return const Color(0xFFFFEDD5).withOpacity(0.5);
        case 'blue':
          return const Color(0xFFBFDBFE).withOpacity(0.5);
        case 'turquoise':
          return const Color(0xFFA5F3FC).withOpacity(0.5);
        case 'green':
          return const Color(0xFFA7F3D0).withOpacity(0.5);
        case 'beige':
          return const Color(0xFFFDE68A).withOpacity(0.5);
        case 'sunset':
          return const Color(0xFFFED7AA).withOpacity(0.5);
        case 'nile':
          return const Color(0xFF93C5FD).withOpacity(0.5);
        default:
          return Colors.grey.withOpacity(0.2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: getGradientColors(isDark),
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: getBorderColor(isDark)),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
