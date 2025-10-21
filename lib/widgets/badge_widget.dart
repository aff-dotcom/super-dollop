// lib/widgets/badge_widget.dart
import 'package:flutter/material.dart' hide Badge;
import '../models/badge_model.dart';
import '../utils/constants.dart' as AppTextStyles;
import '../utils/constants.dart' as RewardThresholds;
import '../utils/constants.dart' as AppColors;

class BadgeWidget extends StatelessWidget {
  final Badge badge;
  const BadgeWidget({
    super.key,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              _getIconForBadgeType(badge.type),
              color: _getColorForBadgeType(badge.type),
              size: 32,
            ),
            const SizedBox(height: 4),
            Text(
              badge.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Niveau ${badge.level}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: badge.level / 5,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(_getColorForBadgeType(badge.type)),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForBadgeType(String type) {
    switch (type) {
      case 'fripes':
        return Icons.shopping_bag;
      case 'outfits':
        return Icons.checkroom;
      case 'avis':
        return Icons.star;
      default:
        return Icons.help;
    }
  }

  Color _getColorForBadgeType(String type) {
    switch (type) {
      case 'fripes':
        return Colors.blue;
      case 'outfits':
        return Colors.purple;
      case 'avis':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}
