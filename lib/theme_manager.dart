import 'package:flutter/material.dart';

class CustomTheme {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color iconColor;
  final Color headerBackgroundColor;
  final Color footerBackgroundColor;
  final Color dialogBackgroundColor;
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Color selectedTextColor;
  final Color primaryButtonBackgroundColor;
  final Color primaryButtonTextColor;
  final Color secondaryButtonTextColor;

  const CustomTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.iconColor,
    required this.headerBackgroundColor,
    required this.footerBackgroundColor,
    required this.dialogBackgroundColor,
    required this.selectedBackgroundColor,
    required this.unselectedBackgroundColor,
    required this.selectedTextColor,
    required this.primaryButtonBackgroundColor,
    required this.primaryButtonTextColor,
    required this.secondaryButtonTextColor,
  });

  static CustomTheme light() {
    return const CustomTheme(
      primaryColor: Color(0xFF2196F3),
      secondaryColor: Color(0xFF4CAF50),
      backgroundColor: Color(0xFFFFFFFF),
      textColor: Color(0xFF000000),
      borderColor: Color(0xFFE0E0E0),
      iconColor: Color(0xFF757575),
      headerBackgroundColor: Color(0xFFF5F5F5),
      footerBackgroundColor: Color(0xFFF5F5F5),
      dialogBackgroundColor: Color(0xFFFFFFFF),
      selectedBackgroundColor: Color(0xFF2196F3),
      unselectedBackgroundColor: Color(0xFFF5F5F5),
      selectedTextColor: Color(0xFFFFFFFF),
      primaryButtonBackgroundColor: Color(0xFF2196F3),
      primaryButtonTextColor: Color(0xFFFFFFFF),
      secondaryButtonTextColor: Color(0xFF757575),
    );
  }

  static CustomTheme dark() {
    return const CustomTheme(
      primaryColor: Color(0xFF2196F3),
      secondaryColor: Color(0xFF4CAF50),
      backgroundColor: Color(0xFF121212),
      textColor: Color(0xFFFFFFFF),
      borderColor: Color(0xFF424242),
      iconColor: Color(0xFFBDBDBD),
      headerBackgroundColor: Color(0xFF1E1E1E),
      footerBackgroundColor: Color(0xFF1E1E1E),
      dialogBackgroundColor: Color(0xFF1E1E1E),
      selectedBackgroundColor: Color(0xFF2196F3),
      unselectedBackgroundColor: Color(0xFF2D2D2D),
      selectedTextColor: Color(0xFFFFFFFF),
      primaryButtonBackgroundColor: Color(0xFF2196F3),
      primaryButtonTextColor: Color(0xFFFFFFFF),
      secondaryButtonTextColor: Color(0xFFBDBDBD),
    );
  }
}

class ThemeManager {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.system);
  final ValueNotifier<CustomTheme> _currentTheme =
      ValueNotifier(CustomTheme.light());

  ThemeMode get themeMode => _themeMode.value;
  CustomTheme get currentTheme => _currentTheme.value;

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    _updateTheme();
  }

  void _updateTheme() {
    switch (_themeMode.value) {
      case ThemeMode.light:
        _currentTheme.value = CustomTheme.light();
        break;
      case ThemeMode.dark:
        _currentTheme.value = CustomTheme.dark();
        break;
      case ThemeMode.system:
        // Here you would typically check the system brightness
        // For now, defaulting to light theme
        _currentTheme.value = CustomTheme.light();
        break;
    }
  }

  void addThemeListener(VoidCallback listener) {
    _themeMode.addListener(listener);
    _currentTheme.addListener(listener);
  }

  void removeThemeListener(VoidCallback listener) {
    _themeMode.removeListener(listener);
    _currentTheme.removeListener(listener);
  }

  void dispose() {
    _themeMode.dispose();
    _currentTheme.dispose();
  }
}
