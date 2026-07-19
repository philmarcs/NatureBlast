import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PieceTray extends StatelessWidget {
  const PieceTray({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.woodlandSurface,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(
          color: AppTheme.woodlandAccentDark.withValues(alpha: 0.12),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ShapeCard(
              label: 'L',
              cells: const [
                [1, 0],
                [1, 0],
                [1, 1],
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _ShapeCard(
              label: 'T',
              cells: const [
                [1, 1, 1],
                [0, 1, 0],
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _ShapeCard(
              label: 'Z',
              cells: const [
                [1, 1, 0],
                [0, 1, 1],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShapeCard extends StatelessWidget {
  const _ShapeCard({required this.label, required this.cells});

  final String label;
  final List<List<int>> cells;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: AppTheme.woodlandBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 4),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final row in cells)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final cell in row)
                        Padding(
                          padding: const EdgeInsets.all(1.5),
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: cell == 1
                                  ? AppTheme.woodlandAccent
                                  : AppTheme.woodlandBackground,
                              borderRadius: BorderRadius.circular(2.5),
                              border: Border.all(
                                color: AppTheme.woodlandAccentDark.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
