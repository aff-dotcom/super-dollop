// lib/screens/reward/badges_detail_screen.dart
import 'package:flutter/material.dart';
import '../../services/mock_data .dart';


class BadgesDetailScreen extends StatelessWidget {
  const BadgesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilisation des données mockées
    final userData = MockData.userProfile;
    final badges = userData.badges;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Badges'),
        backgroundColor: const Color(0xFFaf83b6),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Vos Badges',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 16),
              _buildBadgeTypeContainer(
                context: context,
                type: 'fripes',
                icon: Icons.shopping_bag,
                iconColor: const Color(0xFFaf83b6),
                name: 'Explorateur',
                thresholds: const [1, 5, 10, 20, 30],
                badgeNames: const ['Novice', 'Intermédiaire', 'Grand Explorateur', 'Pro', 'Légende'],
                userBadgeCount: badges['fripes'] ?? 0,
              ),
              const SizedBox(height: 16),
              _buildBadgeTypeContainer(
                context: context,
                type: 'outfits',
                icon: Icons.checkroom,
                iconColor: const Color(0xFFaf83b6),
                name: 'Tenues',
                thresholds: const [1, 3, 8, 15, 30],
                badgeNames: const ['Icône Débutante', 'Grande Icône', 'Pro des Tenues', 'Collectionneur', 'Star des Tenues'],
                userBadgeCount: badges['outfits'] ?? 0,
              ),
              const SizedBox(height: 16),
              _buildBadgeTypeContainer(
                context: context,
                type: 'avis',
                icon: Icons.star,
                iconColor: const Color(0xFFaf83b6),
                name: 'Avis',
                thresholds: const [1, 5, 10, 20, 40],
                badgeNames: const ['Petit Écrivain', 'Journaliste', 'Pro des Avis', 'Star des Avis', 'Légende des Avis'],
                userBadgeCount: badges['avis'] ?? 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeTypeContainer({
    required BuildContext context,
    required String type,
    required IconData icon,
    required Color iconColor,
    required String name,
    required List<int> thresholds,
    required List<String> badgeNames,
    required int userBadgeCount,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(width: 12),
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(thresholds.length, (index) {
                  final threshold = thresholds[index];
                  final isUnlocked = userBadgeCount >= threshold;
                  final isSpecialCase = (type == 'fripes' && index == 0) ||
                      (type == 'outfits' && index == 0) ||
                      (type == 'avis' && (index == 0 || index == thresholds.length - 1));
                  return _buildBadgeLevelBox(
                    threshold: threshold,
                    isUnlocked: isUnlocked,
                    badgeName: badgeNames[index],
                    isSpecialCase: isSpecialCase,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeLevelBox({
    required int threshold,
    required bool isUnlocked,
    required String badgeName,
    required bool isSpecialCase,
  }) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUnlocked ? Colors.purple.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSpecialCase
              ? const Color(0xFFecbdae)
              : (isUnlocked ? Colors.purple : Colors.grey.shade300),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isUnlocked
                  ? (isSpecialCase ? const Color(0xFFecbdae) : Colors.purple)
                  : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 16),
          ),
          const SizedBox(height: 4),
          Text(
            threshold.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isUnlocked
                  ? (isSpecialCase ? const Color(0xFFaf83b6) : Colors.purple)
                  : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            badgeName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: isUnlocked
                  ? (isSpecialCase ? const Color(0xFFaf83b6) : Colors.purple)
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
