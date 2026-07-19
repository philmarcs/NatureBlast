import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';
import 'draggable_piece.dart';

class PieceTray extends StatelessWidget {
  const PieceTray({super.key, required this.pieces, required this.onPieceDragStarted});

  final List<PieceModel> pieces;
  final ValueChanged<PieceModel> onPieceDragStarted;

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
          for (int index = 0; index < pieces.length; index++)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index < pieces.length - 1 ? 6 : 0),
                child: DraggablePiece(
                  piece: pieces[index],
                  onDragStarted: () => onPieceDragStarted(pieces[index]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
