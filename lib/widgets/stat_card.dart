import 'package:flutter/material.dart';
import 'glass_card.dart';
import '../providers/theme_provider.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? trend;
  final String gradient;

  const StatCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.trend,
    required this.gradient,
  }) : super(key: key);

  Color get iconColor {
    switch (gradient) {
      case 'orange':
        return const Color(0xFFFF7D40);
      case 'blue':
        return const Color(0xFF0A6DD9);
      case 'turquoise':
        return const Color(0xFF2BB9A9);
      case 'green':
        return const Color(0xFF3BAA5C);
      default:
        return const Color(0xFFFF7D40);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeProvider.isDarkMode;
    return GlassCard(
      gradient: gradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    if (trend != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        trend!,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF3BAA5C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
