import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PipCompanion extends StatelessWidget {
  const PipCompanion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppTheme.woodlandHighlight,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.park, color: AppTheme.woodlandAccentDark),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Pip is ready to keep the woodland calm.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
