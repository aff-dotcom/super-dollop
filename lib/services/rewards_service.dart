// lib/services/rewards_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/badge_model.dart';

class RewardsService {
  Future<void> addPoints(int points) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'points': FieldValue.increment(points),
    });
    await _checkBadges(userId);
  }

  Future<void> _checkBadges(String userId) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final currentPoints = userDoc['points'] ?? 0;
    final currentBadges = Map<String, int>.from(userDoc['badges'] ?? {});

    // Logique pour les badges "fripes"
    if (currentPoints >= 10 && (currentBadges['fripes'] ?? 0) < 2) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'badges.fripes': 2,
      });
    }
    // Ajoute d'autres conditions pour d'autres types de badges
  }

  Stream<Map<String, dynamic>> getUserRewards() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => {
      'points': snapshot['points'] ?? 0,
      'badges': Map<String, int>.from(snapshot['badges'] ?? {}),
    });
  }
}
