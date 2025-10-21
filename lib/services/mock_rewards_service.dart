import 'package:flutter/material.dart' hide Badge;
import '../models/badge_model.dart';
import '../models/user_profile.dart';
import '../utils/constants.dart';
import '../utils/constants.dart' as RewardThresholds;
import 'mock_data .dart';

class MockRewardsService {
  double get points => MockData.userProfile.points;

  Map<String, int> get badgesCount => MockData.userProfile.badges;

  List<Badge> getBadges() {
    return [
      Badge(
        id: 'badge_fripes',
        type: 'fripes',
        name: _getBadgeName('fripes', MockData.userProfile.badges['fripes'] ?? 0),
        level: MockData.userProfile.badges['fripes'] ?? 0,
        threshold: RewardThresholds.badgeThresholds['fripes']![
        (MockData.userProfile.badges['fripes'] ?? 0).clamp(0, 4)],
        icon: Icons.local_offer,
      ),
      Badge(
        id: 'badge_outfits',
        type: 'outfits',
        name: _getBadgeName('outfits', MockData.userProfile.badges['outfits'] ?? 0),
        level: MockData.userProfile.badges['outfits'] ?? 0,
        threshold: RewardThresholds.badgeThresholds['outfits']![
        (MockData.userProfile.badges['outfits'] ?? 0).clamp(0, 4)],
        icon: Icons.checkroom,
      ),
      Badge(
        id: 'badge_avis',
        type: 'avis',
        name: _getBadgeName('avis', MockData.userProfile.badges['avis'] ?? 0),
        level: MockData.userProfile.badges['avis'] ?? 0,
        threshold: RewardThresholds.badgeThresholds['avis']![
        (MockData.userProfile.badges['avis'] ?? 0).clamp(0, 4)],
        icon: Icons.star,
      ),
    ];
  }

  void addPoints(double points) {
    MockData.updateUserProfile(
      MockData.userProfile.copyWith(
        points: MockData.userProfile.points + points,
      ),
    );
  }

  void incrementBadgeCount(String type) {
    final badges = Map<String, int>.from(MockData.userProfile.badges);
    badges[type] = (badges[type] ?? 0) + 1;
    MockData.updateUserProfile(
      MockData.userProfile.copyWith(
        badges: badges,
      ),
    );
    // Vérifie si un nouveau badge est débloqué
    _checkBadgeUnlock(type);
  }

  String _getBadgeName(String type, int level) {
    switch (type) {
      case 'fripes':
        return level >= 4 ? 'Légende des Fripes' : 'Explorateur de Fripes';
      case 'outfits':
        return level >= 4 ? 'Star des Tenues' : 'Créateur de Tenues';
      case 'avis':
        return level >= 4 ? 'Critique Expert' : 'Avis Apprecié';
      default:
        return 'Badge';
    }
  }

  void _checkBadgeUnlock(String type) {
    // Logique pour vérifier si un nouveau niveau de badge est atteint
    // (Optionnel : ajouter des récompenses ou notifications ici)
  }
}
