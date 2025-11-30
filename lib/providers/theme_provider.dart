import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Singleton pattern for global access
  static final ThemeProvider _instance = ThemeProvider._internal();
  factory ThemeProvider() => _instance;
  ThemeProvider._internal();

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void setDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Light Theme
  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF0A6DD9),
      secondary: Color(0xFF2BB9A9),
      surface: Colors.white,
      background: Color(0xFFF5F5F5),
      error: Color(0xFFF43F5E),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF333333),
      onBackground: Color(0xFF333333),
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    cardColor: Colors.white,
    dividerColor: Colors.grey.shade200,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF333333),
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF0A6DD9),
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0A6DD9), width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0A6DD9),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF0A6DD9)),
    ),
  );

  // Dark Theme
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4DA8FF),
      secondary: Color(0xFF4ECDC4),
      surface: Color(0xFF1E1E1E),
      background: Color(0xFF121212),
      error: Color(0xFFFF6B6B),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFFE0E0E0),
      onBackground: Color(0xFFE0E0E0),
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    dividerColor: Colors.grey.shade800,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Color(0xFFE0E0E0),
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xFF4DA8FF),
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4DA8FF), width: 2),
      ),
      hintStyle: TextStyle(color: Colors.grey.shade500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4DA8FF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF4DA8FF)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      titleTextStyle: const TextStyle(
        color: Color(0xFFE0E0E0),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E1E1E),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}

// Global instance for easy access
final themeProvider = ThemeProvider();

// Helper class for dark mode aware colors
class AppColors {
  static Color background(BuildContext context) {
    return themeProvider.isDarkMode
        ? const Color(0xFF121212)
        : const Color(0xFFF5F5F5);
  }

  static Color surface(BuildContext context) {
    return themeProvider.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
  }

  static Color cardBackground(BuildContext context) {
    return themeProvider.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
  }

  static Color textPrimary(BuildContext context) {
    return themeProvider.isDarkMode
        ? const Color(0xFFE0E0E0)
        : const Color(0xFF333333);
  }

  static Color textSecondary(BuildContext context) {
    return themeProvider.isDarkMode
        ? const Color(0xFF9E9E9E)
        : const Color(0xFF666666);
  }

  static Color divider(BuildContext context) {
    return themeProvider.isDarkMode
        ? Colors.grey.shade800
        : Colors.grey.shade200;
  }

  static Color inputBackground(BuildContext context) {
    return themeProvider.isDarkMode
        ? const Color(0xFF2A2A2A)
        : Colors.grey.shade100;
  }

  static Color glassOverlay(BuildContext context) {
    return themeProvider.isDarkMode
        ? Colors.white.withOpacity(0.05)
        : Colors.white.withOpacity(0.6);
  }

  // Gradient backgrounds for different screens (dark mode versions)
  static Color screenBackground(BuildContext context, String type) {
    if (themeProvider.isDarkMode) {
      return const Color(0xFF121212);
    }
    switch (type) {
      case 'orange':
        return const Color(0xFFFFF7ED);
      case 'pink':
        return const Color(0xFFFCE7F3);
      case 'blue':
        return const Color(0xFFE0F4FF);
      case 'green':
        return const Color(0xFFE8FDF5);
      case 'yellow':
        return const Color(0xFFFFFBEB);
      default:
        return const Color(0xFFF5F5F5);
    }
  }
}
