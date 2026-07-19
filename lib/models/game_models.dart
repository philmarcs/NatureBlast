class BoardCoordinate {
  const BoardCoordinate(this.row, this.col);

  final int row;
  final int col;

  BoardCoordinate translated(int rowDelta, int colDelta) {
    return BoardCoordinate(row + rowDelta, col + colDelta);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardCoordinate && other.row == row && other.col == col;
  }

  @override
  int get hashCode => Object.hash(row, col);
}

class PieceModel {
  const PieceModel({
    required this.id,
    required this.blocks,
    required this.label,
  });

  final String id;
  final List<BoardCoordinate> blocks;
  final String label;
}

class GameBoardState {
  static const int size = 8;

  GameBoardState()
      : occupiedCells = List.generate(
          size,
          (_) => List<bool>.filled(size, false),
        );

  final List<List<bool>> occupiedCells;

  bool isCellOccupied(BoardCoordinate coordinate) {
    if (!_isWithinBounds(coordinate)) {
      return true;
    }
    return occupiedCells[coordinate.row][coordinate.col];
  }

  bool canPlacePiece(PieceModel piece, BoardCoordinate origin) {
    for (final block in piece.blocks) {
      final target = origin.translated(block.row, block.col);
      if (!_isWithinBounds(target) || isCellOccupied(target)) {
        return false;
      }
    }
    return true;
  }

  void placePiece(PieceModel piece, BoardCoordinate origin) {
    for (final block in piece.blocks) {
      final target = origin.translated(block.row, block.col);
      if (_isWithinBounds(target)) {
        occupiedCells[target.row][target.col] = true;
      }
    }
  }

  bool _isWithinBounds(BoardCoordinate coordinate) {
    return coordinate.row >= 0 &&
        coordinate.row < size &&
        coordinate.col >= 0 &&
        coordinate.col < size;
  }
}
