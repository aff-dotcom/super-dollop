import 'package:flutter/material.dart';

// Couleurs
const primaryColor = Color(0xFFaf83b6);
const secondaryColor = Color(0xFFecbdae);
const accentColor = Colors.blue;

// Styles de texte
const titleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);
const subtitleStyle = TextStyle(
  fontSize: 16,
  color: secondaryColor,
);

// Seuil de points pour les récompenses
const List<int> pointsThresholds = [10, 50, 100, 200, 400, 800];

// Points de récompense par action
class RewardPoints {
  static const double addPlace = 5.0;
  static const double addReview = 2.5;
  static const double addOutfit = 2.5;
}

// Seuil, noms, descriptions et icônes des badges
const Map<String, List<int>> badgeThresholds = {
  'fripes': [1, 5, 10, 20, 30],
  'outfits': [1, 3, 8, 12, 20],
  'avis': [1, 5, 10, 20, 30],
};

const Map<String, List<String>> badgeNames = {
  'fripes': [
    'Explorateur Novice',
    'Explorateur Intermédiaire',
    'Grand Explorateur',
    'Explorateur Pro',
    'Explorateur de Légende',
  ],
  'outfits': [
    'Icône Débutante',
    'Icône Intermédiaire',
    'Pro des Tenues',
    'Collectionneur de Tenues',
    'Star des Tenues',
  ],
  'avis': [
    'Petit Écrivain',
    'Journaliste',
    'Pro des Avis',
    'Star des Avis',
    'Légende des Avis',
  ],
};

const Map<String, List<String>> badgeDescriptions = {
  'fripes': [
    'Ajouter 1 friperie',
    'Ajouter 5 friperies',
    'Ajouter 10 friperies',
    'Ajouter 20 friperies',
    'Ajouter 30 friperies',
  ],
  'outfits': [
    'Poster 1 tenue',
    'Poster 3 tenues',
    'Poster 8 tenues',
    'Poster 12 tenues',
    'Poster 20 tenues',
  ],
  'avis': [
    'Laisser 1 avis',
    'Laisser 5 avis',
    'Laisser 10 avis',
    'Laisser 20 avis',
    'Laisser 30 avis',
  ],
};

const Map<String, String> badgeIcons = {
  'fripes': '🏷️',
  'outfits': '👗',
  'avis': '⭐',
};

// Chemins des images de fond
const List<String> backgroundImages = [
  'lib/assets/autumn_flower.png',
  'lib/assets/black_corset.PNG',
  'lib/assets/black_yellows_diamonds.PNG',
  'lib/assets/blue_ceramic.PNG',
  'lib/assets/blue_strips.PNG',
  'lib/assets/blue_tartan.PNG',
  'lib/assets/crimson_petals.PNG',
  'lib/assets/cute_birds.PNG',
  'lib/assets/feline_spot.PNG',
  'lib/assets/green_tiles.PNG',
  'lib/assets/pink_blue_flowers.PNG',
  'lib/assets/pink_lace.PNG',
  'lib/assets/shining_dress.PNG',
  'lib/assets/starlit_jeans.PNG',
  'lib/assets/sunrise.PNG',
  'lib/assets/zebra.PNG',
];
