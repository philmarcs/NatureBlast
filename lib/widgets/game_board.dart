import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';
import 'board_cell.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key, this.size, required this.boardState, required this.activePiece, required this.ghostOrigin, required this.isValidPlacement});

  final double? size;
  final GameBoardState boardState;
  final PieceModel? activePiece;
  final BoardCoordinate? ghostOrigin;
  final bool isValidPlacement;

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
        itemBuilder: (context, index) {
          final row = index ~/ 8;
          final col = index % 8;
          final coordinate = BoardCoordinate(row, col);
          final isOccupied = boardState.isCellOccupied(coordinate);
          final isGhost = activePiece != null &&
              ghostOrigin != null &&
              activePiece!.blocks.any((block) => coordinate == ghostOrigin!.translated(block.row, block.col));

          return BoardCell(
            isOccupied: isOccupied,
            isGhost: isGhost,
            isValid: isValidPlacement,
          );
        },
      ),
    );
  }
}
