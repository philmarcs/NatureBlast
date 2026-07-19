import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/game_board.dart';
import '../widgets/piece_tray.dart';
import '../widgets/pip_companion.dart';
import '../widgets/status_chip.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth - 32;
            final availableHeight = constraints.maxHeight - 24;
            final boardMaxWidth = maxWidth.clamp(220.0, AppTheme.maxBoardSide);
            final trayHeight = availableHeight < 640 ? 82.0 : 94.0;
            final pipHeight = availableHeight < 640 ? 62.0 : 72.0;
            final contentGap = 8.0;
            final verticalBudget = availableHeight - 70 - trayHeight - pipHeight - (contentGap * 3);
            final boardSize = verticalBudget > 0
                ? (verticalBudget < boardMaxWidth ? verticalBudget : boardMaxWidth)
                : boardMaxWidth;
            final responsiveBoardSize = boardSize.clamp(
              AppTheme.minBoardSide,
              AppTheme.maxBoardSide,
            );

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: boardMaxWidth),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GameBoard(size: responsiveBoardSize),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: trayHeight,
                              child: const PieceTray(),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: pipHeight,
                              child: const PipCompanion(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
            child: Text(
              'Nature Blast',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(width: 8),
          const StatusChip(label: 'Score', value: '0'),
          const SizedBox(width: 6),
          const StatusChip(label: 'Best', value: '0'),
          const SizedBox(width: 6),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: AppTheme.woodlandAccentDark),
            tooltip: 'Settings',
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 32, height: 32),
          ),
        ],
      ),
    );
  }
}
