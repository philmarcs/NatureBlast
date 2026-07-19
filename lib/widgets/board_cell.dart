import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BoardCell extends StatelessWidget {
  const BoardCell({super.key, required this.isOccupied, required this.isGhost, required this.isValid});

  final bool isOccupied;
  final bool isGhost;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    Color fillColor = AppTheme.woodlandCell;
    Color borderColor = AppTheme.woodlandCellBorder.withValues(alpha: 0.8);

    if (isOccupied) {
      fillColor = AppTheme.woodlandAccent;
      borderColor = AppTheme.woodlandAccentDark.withValues(alpha: 0.45);
    } else if (isGhost) {
      fillColor = isValid
          ? AppTheme.woodlandHighlight.withValues(alpha: 0.55)
          : AppTheme.woodlandAccentDark.withValues(alpha: 0.25);
      borderColor = isValid
          ? AppTheme.woodlandAccentDark.withValues(alpha: 0.35)
          : AppTheme.woodlandAccentDark.withValues(alpha: 0.5);
    }

    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(AppTheme.tileRadius),
        border: Border.all(color: borderColor, width: 1),
      ),
    );
  }
}
