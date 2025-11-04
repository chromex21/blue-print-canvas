import 'package:flutter/material.dart';
import 'managers/settings_state_manager.dart';

class SettingsDialog extends StatefulWidget {
  final SettingsStateManager settingsManager;

  const SettingsDialog({
    Key? key,
    required this.settingsManager,
  }) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Dialog(
            backgroundColor:
                widget.settingsManager.currentTheme.dialogBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: widget.settingsManager.currentTheme.borderColor,
                width: 1,
              ),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
                minWidth: 400,
                maxHeight: 800,
                minHeight: 300,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  _buildContent(),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.settingsManager.currentTheme.headerBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Settings',
            style: TextStyle(
              color: widget.settingsManager.currentTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.close,
              color: widget.settingsManager.currentTheme.iconColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThemeSelector(),
            const SizedBox(height: 24),
            _buildGridSettings(),
            const SizedBox(height: 24),
            _buildCanvasSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme',
          style: TextStyle(
            color: widget.settingsManager.currentTheme.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildThemeOption('Light', ThemeMode.light),
            _buildThemeOption('Dark', ThemeMode.dark),
            _buildThemeOption('System', ThemeMode.system),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption(String label, ThemeMode mode) {
    final isSelected = widget.settingsManager.themeMode == mode;
    return InkWell(
      onTap: () => widget.settingsManager.updateThemeMode(mode),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? widget.settingsManager.currentTheme.selectedBackgroundColor
              : widget.settingsManager.currentTheme.unselectedBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.settingsManager.currentTheme.borderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? widget.settingsManager.currentTheme.selectedTextColor
                : widget.settingsManager.currentTheme.textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildGridSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grid Settings',
          style: TextStyle(
            color: widget.settingsManager.currentTheme.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildSettingsRow(
          'Show Grid',
          Switch.adaptive(
            value: widget.settingsManager.showGrid,
            onChanged: (value) => setState(() {
              widget.settingsManager.updateShowGrid(value);
            }),
          ),
        ),
        _buildSettingsRow(
          'Grid Size',
          Slider.adaptive(
            value: widget.settingsManager.gridSize,
            min: 10,
            max: 50,
            divisions: 8,
            label: '${widget.settingsManager.gridSize.round()}',
            onChanged: (value) => setState(() {
              widget.settingsManager.updateGridSize(value);
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCanvasSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Canvas Settings',
          style: TextStyle(
            color: widget.settingsManager.currentTheme.textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildSettingsRow(
          'Show Guidelines',
          Switch.adaptive(
            value: widget.settingsManager.showGuidelines,
            onChanged: (value) => setState(() {
              widget.settingsManager.updateShowGuidelines(value);
            }),
          ),
        ),
        _buildSettingsRow(
          'Snap to Grid',
          Switch.adaptive(
            value: widget.settingsManager.snapToGrid,
            onChanged: (value) => setState(() {
              widget.settingsManager.updateSnapToGrid(value);
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsRow(String label, Widget control) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: widget.settingsManager.currentTheme.textColor,
            ),
          ),
          const Spacer(),
          control,
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.settingsManager.currentTheme.footerBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor:
                  widget.settingsManager.currentTheme.secondaryButtonTextColor,
            ),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              widget.settingsManager.saveSettings();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget
                  .settingsManager.currentTheme.primaryButtonBackgroundColor,
              foregroundColor:
                  widget.settingsManager.currentTheme.primaryButtonTextColor,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
