import 'package:flutter/material.dart';

class ColorfulHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final bool showNotifications;
  final bool showSearch;
  final String gradient;
  final VoidCallback? onNotificationTap;
  final int notificationCount;

  const ColorfulHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.onBack,
    this.showNotifications = false,
    this.showSearch = false,
    this.gradient = 'sunset',
    this.onNotificationTap,
    this.notificationCount = 3,
  }) : super(key: key);

  List<Color> get gradientColors {
    switch (gradient) {
      case 'orange':
        return [const Color(0xFFFF9E57), const Color(0xFFFF7D40)];
      case 'blue':
        return [const Color(0xFF0A6DD9), const Color(0xFF63C7FF)];
      case 'turquoise':
        return [const Color(0xFF2BB9A9), const Color(0xFF3BAA5C)];
      case 'green':
        return [const Color(0xFF3BAA5C), const Color(0xFF2BB9A9)];
      case 'nile':
        return [
          const Color(0xFF0A6DD9),
          const Color(0xFF2BB9A9),
          const Color(0xFF63C7FF),
        ];
      case 'sunset':
      default:
        return [
          const Color(0xFFFF9E57),
          const Color(0xFFFF7D40),
          const Color(0xFFD9AE73),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (onBack != null)
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: onBack,
                    )
                  else
                    const SizedBox(width: 48),
                  Row(
                    children: [
                      if (showSearch)
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {},
                        ),
                      if (showNotifications)
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                              ),
                              onPressed: onNotificationTap,
                            ),
                            if (notificationCount > 0)
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    notificationCount > 9
                                        ? '9+'
                                        : '$notificationCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
