import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';

class DraggablePiece extends StatelessWidget {
  const DraggablePiece({super.key, required this.piece, required this.onDragStarted});

  final PieceModel piece;
  final VoidCallback onDragStarted;

  @override
  Widget build(BuildContext context) {
    return Draggable<PieceModel>(
      data: piece,
      feedback: Material(
        color: Colors.transparent,
        child: _PiecePreview(piece: piece),
      ),
      childWhenDragging: const SizedBox.shrink(),
      onDragStarted: onDragStarted,
      child: _PiecePreview(piece: piece),
    );
  }
}

class _PiecePreview extends StatelessWidget {
  const _PiecePreview({required this.piece});

  final PieceModel piece;

  @override
  Widget build(BuildContext context) {
    final columns = piece.blocks
        .map((block) => block.col)
        .reduce((value, element) => value > element ? value : element);

    final rows = piece.blocks
        .map((block) => block.row)
        .reduce((value, element) => value > element ? value : element);

    final width = columns + 1;
    final height = rows + 1;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: AppTheme.woodlandBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(piece.label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 2),
          SizedBox(
            width: 14.0 * width,
            child: Wrap(
              runSpacing: 1,
              spacing: 1,
              children: List.generate(
                width * height,
                (index) {
                  final row = index ~/ width;
                  final col = index % width;
                  final isBlock = piece.blocks.any(
                    (block) => block.row == row && block.col == col,
                  );
                  return Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isBlock ? AppTheme.woodlandAccent : AppTheme.woodlandBackground,
                      borderRadius: BorderRadius.circular(2.5),
                      border: Border.all(
                        color: AppTheme.woodlandAccentDark.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
