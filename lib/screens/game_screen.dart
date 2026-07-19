import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';
import '../widgets/game_board.dart';
import '../widgets/piece_tray.dart';
import '../widgets/pip_companion.dart';
import '../widgets/status_chip.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameBoardState _boardState = GameBoardState();
  final List<PieceModel> _pieces = [
    const PieceModel(id: 'line', blocks: [BoardCoordinate(0, 0), BoardCoordinate(0, 1), BoardCoordinate(0, 2)], label: '—'),
    const PieceModel(id: 'l', blocks: [BoardCoordinate(0, 0), BoardCoordinate(1, 0), BoardCoordinate(2, 0), BoardCoordinate(2, 1)], label: 'L'),
    const PieceModel(id: 'square', blocks: [BoardCoordinate(0, 0), BoardCoordinate(0, 1), BoardCoordinate(1, 0), BoardCoordinate(1, 1)], label: '□'),
  ];
  PieceModel? _draggingPiece;
  BoardCoordinate? _ghostOrigin;
  bool _isValidPlacement = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const headerHeight = 64.0;
            const trayHeight = 82.0;
            const pipHeight = 48.0;
            const spacing = 10.0;
            const horizontalPadding = 16.0;
            const verticalPadding = 12.0 + 6.0;
            const maxContentWidth = 430.0;

            final contentWidth = (constraints.maxWidth - (horizontalPadding * 2)).clamp(0.0, maxContentWidth);
            final reservedHeight = headerHeight + trayHeight + pipHeight + (spacing * 2);
            final availableBoardHeight = constraints.maxHeight - verticalPadding - reservedHeight;
            final boardSize = (contentWidth < availableBoardHeight
                    ? contentWidth
                    : availableBoardHeight)
                .clamp(AppTheme.minBoardSide, maxContentWidth);

            // Reserve fixed heights for the header, tray and Pip area so the board
            // always uses the remaining vertical space instead of overflowing.
            final responsiveBoardSize = boardSize.clamp(AppTheme.minBoardSide, AppTheme.maxBoardSide);

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Column(
                children: [
                  SizedBox(
                    height: headerHeight,
                    width: double.infinity,
                    child: _buildTopBar(context),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: maxContentWidth),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DragTarget<PieceModel>(
                            onWillAcceptWithDetails: (details) {
                              final piece = details.data;
                              final origin = _currentBoardOrigin(details.offset, responsiveBoardSize);
                              setState(() {
                                _draggingPiece = piece;
                                _ghostOrigin = origin;
                                _isValidPlacement = _boardState.canPlacePiece(piece, origin);
                              });
                              return true;
                            },
                            onMove: (details) {
                              final origin = _currentBoardOrigin(details.offset, responsiveBoardSize);
                              setState(() {
                                _ghostOrigin = origin;
                                _isValidPlacement = _boardState.canPlacePiece(details.data, origin);
                              });
                            },
                            onAcceptWithDetails: (details) {
                              final piece = details.data;
                              final origin = _currentBoardOrigin(details.offset, responsiveBoardSize);
                              if (_boardState.canPlacePiece(piece, origin)) {
                                _boardState.placePiece(piece, origin);
                                setState(() {
                                  _pieces.removeWhere((current) => current.id == piece.id);
                                  if (_pieces.isEmpty) {
                                    _pieces.addAll(_buildNextPieces());
                                  }
                                  _draggingPiece = null;
                                  _ghostOrigin = null;
                                  _isValidPlacement = true;
                                });
                              } else {
                                setState(() {
                                  _draggingPiece = null;
                                  _ghostOrigin = null;
                                  _isValidPlacement = true;
                                });
                              }
                            },
                            builder: (context, candidateData, rejectedData) {
                              return GameBoard(
                                size: responsiveBoardSize,
                                boardState: _boardState,
                                activePiece: _draggingPiece,
                                ghostOrigin: _ghostOrigin,
                                isValidPlacement: _isValidPlacement,
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: trayHeight,
                            child: _buildPieceTray(),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: pipHeight,
                            child: const PipCompanion(),
                          ),
                        ],
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

  Widget _buildPieceTray() {
    return PieceTray(
      pieces: _pieces,
      onPieceDragStarted: (piece) {
        setState(() {
          _draggingPiece = piece;
        });
      },
    );
  }

  List<PieceModel> _buildNextPieces() {
    return [
      const PieceModel(id: 'line-2', blocks: [BoardCoordinate(0, 0), BoardCoordinate(0, 1), BoardCoordinate(0, 2)], label: '—'),
      const PieceModel(id: 'l-2', blocks: [BoardCoordinate(0, 0), BoardCoordinate(1, 0), BoardCoordinate(2, 0)], label: 'L'),
      const PieceModel(id: 't', blocks: [BoardCoordinate(0, 0), BoardCoordinate(0, 1), BoardCoordinate(0, 2), BoardCoordinate(1, 1)], label: 'T'),
    ];
  }

  BoardCoordinate _currentBoardOrigin(Offset offset, double boardSize) {
    final innerPadding = 10.0;
    final localOffset = Offset(
      (offset.dx - innerPadding).clamp(0.0, boardSize - 1),
      (offset.dy - innerPadding).clamp(0.0, boardSize - 1),
    );
    final cellSize = boardSize / GameBoardState.size;
    final row = (localOffset.dy / cellSize).floor();
    final col = (localOffset.dx / cellSize).floor();
    return BoardCoordinate(row.clamp(0, GameBoardState.size - 1), col.clamp(0, GameBoardState.size - 1));
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
