import 'package:flutter/material.dart';
import '../../utils/constants.dart' as AppColors;
import '../../utils/constants.dart' as AppTextStyles;

class RewardProgressBar extends StatelessWidget {
  final int currentPoints;
  final int maxPoints;

  const RewardProgressBar({super.key, required this.currentPoints, required this.maxPoints});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: currentPoints / maxPoints,
          backgroundColor: AppColors.secondaryColor,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('$currentPoints / $maxPoints points', style: AppTextStyles.subtitleStyle),
        ),
      ]
    );
  }
}
