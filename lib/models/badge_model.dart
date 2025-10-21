// lib/models/badge_model.dart
import 'package:flutter/material.dart';

class Badge {
  final String id; // Identifiant unique du badge
  final String name; // Nom affiché du badge
  final String type; // Type de badge : 'fripes', 'outfits', 'avis'
  final int level; // Niveau actuel du badge (ex: 1, 2, 3...)
  final IconData icon; // Icône associée (utilisation de IconData pour Flutter)
  final int threshold; // Seuil de points pour atteindre le niveau suivant
  final String description; // Description du badge (optionnelle pour l'UI)

  Badge({
    required this.id,
    required this.name,
    required this.type,
    required this.level,
    required this.icon,
    required this.threshold,
    this.description = '', // Valeur par défaut si non fournie
  });

  // Constructeur optionnel pour créer un Badge sans id (si nécessaire)
  Badge.withoutId({
    required this.name,
    required this.type,
    required this.level,
    required this.icon,
    required this.threshold,
    this.description = '',
  }) : id = '${type}_${level}_${DateTime.now().millisecondsSinceEpoch}';
}
