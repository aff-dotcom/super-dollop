// lib/services/mock_data.dart
import '../models/place.dart';
import '../models/user_profile.dart';
import '../models/outfit.dart';
import '../models/review.dart';

class MockData {
  static final List<Place> places = [
    Place(
      id: '1',
      name: 'Friperie Vintage',
      address: '123 Rue de Paris',
      description: 'La meilleure friperie de Paris',
      latitude: 48.8566,
      longitude: 2.3522,
      userId: 'user123',
      photos: ['https://via.placeholder.com/150'],
      tags: ['vintage', 'pas cher'],
      rating: 4.5,
      likes: 10, // Ajout du paramètre likes
      reviews: [
        Review(userId: 'user1', comment: 'Super endroit !', rating: 5.0),
        Review(userId: 'user2', comment: 'J\'adore cet endroit !', rating: 4.5),
      ],
    ),
    Place(
      id: '2',
      name: 'Ressourcerie Solidaire',
      address: '456 Rue de Lyon',
      description: 'Une ressourcerie avec des articles uniques',
      latitude: 48.8467,
      longitude: 2.3376,
      userId: 'user456',
      photos: ['https://via.placeholder.com/150'],
      tags: ['recyclage', 'solidaire'],
      rating: 4.2,
      likes: 8, // Ajout du paramètre likes
      reviews: [
        Review(userId: 'user3', comment: 'Très bon choix de produits', rating: 4.0),
      ],
    ),
  ];

  static final List<Outfit> outfits = [
    Outfit(
      id: 'outfit1',
      description: 'Tenue décontractée pour l\'été',
      photos: ['https://via.placeholder.com/300x400?text=Tenue+1'],
      hashtags: ['été', 'décontracté', '2023'],
      createdAt: DateTime.now(),
      userId: 'user123', // Ajout du paramètre userId
      likes: 15, // Ajout du paramètre likes
    ),
    Outfit(
      id: 'outfit2',
      description: 'Tenue élégante pour une soirée',
      photos: ['https://via.placeholder.com/300x400?text=Tenue+2'],
      hashtags: ['soirée', 'élégant', 'noir'],
      createdAt: DateTime.now(),
      userId: 'user123', // Ajout du paramètre userId
      likes: 20, // Ajout du paramètre likes
    ),
  ];

  static UserProfile _userProfile = UserProfile(
    uid: 'user123',
    name: 'Antonin',
    surname: 'TERRASSON',
    photoUrl: 'https://via.placeholder.com/150',
    points: 42.5,
    badges: {'fripes': 2, 'outfits': 1, 'avis': 3},
    stats: {'placesAdded': 5, 'outfitsAdded': 3},
    favoriteOutfits: ['outfit1', 'outfit2'],
    favoritePlaces: ['1'],
    publishedOutfits: ['outfit1'],
    draftOutfits: [],
    selectedTitle: 'Explorateur',
    unlockedTitles: ['Explorateur', 'Pro'],
    selectedTheme: 'light',
    bannerPath: 'assets/banners/banner1.png',
  );

  static UserProfile get userProfile => _userProfile;

  static void updateUserProfile(UserProfile newProfile) {
    _userProfile = newProfile;
  }
}
