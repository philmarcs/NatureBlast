import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final boardSize = size ?? AppTheme.maxBoardSide;

    return Container(
      width: boardSize,
      height: boardSize,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.woodlandSurface,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(
          color: AppTheme.woodlandAccentDark.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.woodlandAccentDark.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 64,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (_, _) {
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.woodlandCell,
              borderRadius: BorderRadius.circular(AppTheme.tileRadius),
              border: Border.all(
                color: AppTheme.woodlandCellBorder.withValues(alpha: 0.8),
                width: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
