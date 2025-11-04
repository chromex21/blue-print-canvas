import 'package:flutter/material.dart';
import '../theme_manager.dart';

class SettingsStateManager extends ChangeNotifier {
  final ThemeManager _themeManager;

  SettingsStateManager(this._themeManager) {
    // Listen to theme changes
    _themeManager.addThemeListener(_onThemeChanged);
  }

  void _onThemeChanged() {
    notifyListeners();
  }

  bool _showGrid = true;
  bool _showGuidelines = true;
  bool _snapToGrid = true;
  double _gridSize = 20;

  // Theme getters
  ThemeMode get themeMode => _themeManager.themeMode;
  CustomTheme get currentTheme => _themeManager.currentTheme;

  void updateThemeMode(ThemeMode mode) {
    _themeManager.setThemeMode(mode);
    notifyListeners();
  }

  // Grid settings
  bool get showGrid => _showGrid;
  void updateShowGrid(bool value) {
    _showGrid = value;
    notifyListeners();
  }

  double get gridSize => _gridSize;
  void updateGridSize(double value) {
    _gridSize = value;
    notifyListeners();
  }

  // Guidelines settings
  bool get showGuidelines => _showGuidelines;
  void updateShowGuidelines(bool value) {
    _showGuidelines = value;
    notifyListeners();
  }

  // Snap to grid settings
  bool get snapToGrid => _snapToGrid;
  void updateSnapToGrid(bool value) {
    _snapToGrid = value;
    notifyListeners();
  }

  // Theme color getters
  Color get dialogBackgroundColor => currentTheme.dialogBackgroundColor;
  Color get headerBackgroundColor => currentTheme.headerBackgroundColor;
  Color get footerBackgroundColor => currentTheme.footerBackgroundColor;
  Color get textColor => currentTheme.textColor;
  Color get borderColor => currentTheme.borderColor;
  Color get iconColor => currentTheme.iconColor;
  Color get selectedBackgroundColor => currentTheme.selectedBackgroundColor;
  Color get unselectedBackgroundColor => currentTheme.unselectedBackgroundColor;
  Color get selectedTextColor => currentTheme.selectedTextColor;
  Color get primaryButtonBackgroundColor =>
      currentTheme.primaryButtonBackgroundColor;
  Color get primaryButtonTextColor => currentTheme.primaryButtonTextColor;
  Color get secondaryButtonTextColor => currentTheme.secondaryButtonTextColor;

  // Save settings (in a real app, this would persist to storage)
  void saveSettings() {
    // Implement persistence logic here
    notifyListeners();
  }

  @override
  void dispose() {
    _themeManager.removeThemeListener(_onThemeChanged);
    super.dispose();
  }
}
