import 'package:flutter/material.dart' hide Badge;
import '../models/user_profile.dart';

class AuthService with ChangeNotifier {
  UserProfile? _currentUserProfile;

  UserProfile? get currentUserProfile => _currentUserProfile;

  AuthService() {
    _currentUserProfile = UserProfile(
      uid: '123',
      name: 'Antonin',
      surname: 'TERRASSON',
      photoUrl: null,
      points: 42, // Ajout du paramètre points
      badges: {
        'fripes': 3,
        'outfits': 1,
        'avis': 5,
      }, // badges doit être une Map<String, int>
      stats: {
        'Points': 42,
        'Lieux ajoutés': 3,
      },
      favoriteOutfits: [], // Liste des IDs des tenues favorites
      favoritePlaces: [],  // Liste des IDs des lieux favoris
      publishedOutfits: [], // Liste des IDs des tenues publiées
      draftOutfits: [], selectedTitle: '', unlockedTitles: [], selectedTheme: '',    // Liste des IDs des brouillons de tenues
    );
  }
}
