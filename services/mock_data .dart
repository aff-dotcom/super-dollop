import '../models/place.dart';
import '../models/user_profile.dart';
import '../models/outfit.dart';
import '../models/review.dart';

class MockData {
  static final List<Outfit> outfits = [
    Outfit(
      id: 'outfit1',
      description: 'Tenue décontractée pour l\'été avec un t-shirt vintage des années 90 et un jean retro haute taille. Parfaite pour les journées chaudes en ville.',
      photos: [
        'lib/assets/tenue1.png',
        'lib/assets/tenue1_detail.png',
      ],
      hashtags: ['été', 'vintage', 'décontracté', 'streetwear'],
      createdAt: DateTime.now(),
      userId: 'user123',
      likes: 156,
      comments: [
        Comment(text: 'Super tenue ! Où as-tu trouvé le t-shirt ?', userName: 'Alice'),
        Comment(text: 'J\'adore le style rétro !', userName: 'Bob'),
        Comment(text: 'Le jean est trop beau !', userName: 'Charlie'),
      ],
    ),
    Outfit(
      id: 'outfit2',
      description: 'Tenue élégante pour une soirée avec une robe noire longue et des accessoires dorés. Idéale pour un dîner ou un événement chic.',
      photos: [
        'lib/assets/tenue2.png',
        'lib/assets/tenue2_detail.png',
      ],
      hashtags: ['soirée', 'élégant', 'noir', 'chic'],
      createdAt: DateTime.now(),
      userId: 'user456',
      likes: 324,
      comments: [
        Comment(text: 'Très chic ! Où l\'as-tu achetée ?', userName: 'Dana'),
        Comment(text: 'Parfait pour une soirée !', userName: 'Eve'),
        Comment(text: 'Les accessoires dorés sont magnifiques !', userName: 'Frank'),
      ],
    ),
    Outfit(
      id: 'outfit3',
      description: 'Tenue sportive avec un survêtement gris et des baskets blanches. Confortable pour une séance de sport ou une journée détente.',
      photos: [
        'lib/assets/tenue3.png',
      ],
      hashtags: ['sport', 'confortable', 'baskets', 'streetwear'],
      createdAt: DateTime.now(),
      userId: 'user789',
      likes: 89,
      comments: [
        Comment(text: 'Quelle marque de baskets ?', userName: 'Grace'),
        Comment(text: 'Parfait pour le sport !', userName: 'Hank'),
      ],
    ),
    Outfit(
      id: 'outfit4',
      description: 'Tenue bohème avec une robe longue fleurie et un chapeau en paille. Parfaite pour un festival ou une journée à la plage.',
      photos: [
        'lib/assets/tenue4.png',
        'lib/assets/tenue4_detail.png',
      ],
      hashtags: ['bohème', 'festival', 'été', 'plage'],
      createdAt: DateTime.now(),
      userId: 'user123',
      likes: 210,
      comments: [
        Comment(text: 'J\'adore les motifs floraux !', userName: 'Isla'),
        Comment(text: 'Le chapeau est trop mignon !', userName: 'Jack'),
      ],
    ),
    Outfit(
      id: 'outfit5',
      description: 'Tenue professionnelle avec un tailleur bleu marine et une chemise blanche. Idéale pour le bureau ou un entretien.',
      photos: [
        'lib/assets/tenue5.png',
      ],
      hashtags: ['professionnel', 'bureau', 'élégant', 'formel'],
      createdAt: DateTime.now(),
      userId: 'user456',
      likes: 178,
      comments: [
        Comment(text: 'Très classe !', userName: 'Kate'),
        Comment(text: 'Parfait pour un entretien !', userName: 'Leo'),
      ],
    ),
    Outfit(
      id: 'outfit6',
      description: 'Tenue streetwear avec un hoodie oversize et un jean déchiré. Style urbain et décontracté pour une sortie entre amis.',
      photos: [
        'lib/assets/tenue6.png',
        'lib/assets/tenue6_detail.png',
      ],
      hashtags: ['streetwear', 'urbain', 'décontracté', 'hoodie'],
      createdAt: DateTime.now(),
      userId: 'user789',
      likes: 432,
      comments: [
        Comment(text: 'J\'adore le style streetwear !', userName: 'Mia'),
        Comment(text: 'Où as-tu acheté le hoodie ?', userName: 'Noah'),
        Comment(text: 'Le jean est parfait !', userName: 'Oscar'),
      ],
    ),
    Outfit(
      id: 'outfit7',
      description: 'Tenue de plage avec un paréo coloré et un maillot une pièce. Idéale pour les vacances au soleil.',
      photos: [
        'lib/assets/tenue7.png',
      ],
      hashtags: ['plage', 'vacances', 'été', 'paréo'],
      createdAt: DateTime.now(),
      userId: 'user123',
      likes: 198,
      comments: [
        Comment(text: 'Parfait pour l\'été !', userName: 'Paula'),
        Comment(text: 'Les couleurs sont magnifiques !', userName: 'Quinn'),
      ],
    ),
    Outfit(
      id: 'outfit8',
      description: 'Tenue rock avec un t-shirt de groupe, un jean slim et des bottes. Style rebelle pour un concert ou une soirée.',
      photos: [
        'lib/assets/tenue8.PNG',
        'lib/assets/tenue8_detail.PNG',
      ],
      hashtags: ['rock', 'concert', 'rebelle', 'bottes'],
      createdAt: DateTime.now(),
      userId: 'user456',
      likes: 356,
      comments: [
        Comment(text: 'Quel groupe ?', userName: 'Rachel'),
        Comment(text: 'J\'adore le style rock !', userName: 'Sam'),
        Comment(text: 'Les bottes sont trop cool !', userName: 'Tina'),
      ],
    ),
    Outfit(
      id: 'outfit9',
      description: 'Tenue minimaliste avec un pull sobre et un pantalon droit. Style épuré et intemporel pour toutes les occasions.',
      photos: [
        'lib/assets/tenue9.png',
      ],
      hashtags: ['minimaliste', 'épuré', 'intemporel', 'chic'],
      createdAt: DateTime.now(),
      userId: 'user789',
      likes: 145,
      comments: [
        Comment(text: 'Très élégant !', userName: 'Uma'),
        Comment(text: 'Parfait pour un look sobre.', userName: 'Victor'),
      ],
    ),
    Outfit(
      id: 'outfit10',
      description: 'Tenue hivernale avec un manteau en laine, un pull col roulé et des bottines. Parfaite pour les journées froides.',
      photos: [
        'lib/assets/tenue10.png',
        'lib/assets/tenue10_detail.png',
      ],
      hashtags: ['hiver', 'chaud', 'laine', 'bottines'],
      createdAt: DateTime.now(),
      userId: 'user123',
      likes: 287,
      comments: [
        Comment(text: 'Parfait pour l\'hiver !', userName: 'Wendy'),
        Comment(text: 'Le manteau est super !', userName: 'Xavier'),
        Comment(text: 'J\'adore les bottines !', userName: 'Yara'),
      ],
    ),
  ];

  static final List<Place> places = [
    Place(
      id: '1',
      name: 'Friperie Vintage',
      address: '123 Rue de Paris',
      description: 'La meilleure friperie de Paris avec des pièces uniques des années 70 à 90.',
      latitude: 48.8566,
      longitude: 2.3522,
      userId: 'user123',
      photos: ['lib/assets/tenue1.png'],
      tags: ['vintage', 'pas cher', 'années 90'],
      rating: 4.5,
      likes: 10,
      reviews: [
        Review(userId: 'user1', comment: 'Super endroit avec des pièces uniques !', rating: 5.0),
        Review(userId: 'user2', comment: 'J\'adore cet endroit, les prix sont abordables !', rating: 4.5),
      ],
    ),
  ];

  static UserProfile _userProfile = UserProfile(
    uid: 'user123',
    name: 'Antonin',
    surname: 'TERRASSON',
    photoUrl: 'lib/assets/tenue2.png',
    points: 42.5,
    badges: {'fripes': 2, 'outfits': 1, 'avis': 3},
    stats: {'placesAdded': 5, 'outfitsAdded': 10}, // Mis à jour pour 10 tenues
    favoriteOutfits: ['outfit1', 'outfit2', 'outfit5', 'outfit8'],
    favoritePlaces: ['1'],
    publishedOutfits: ['outfit1', 'outfit2', 'outfit3', 'outfit4', 'outfit5', 'outfit6', 'outfit7', 'outfit8', 'outfit9', 'outfit10'],
    draftOutfits: [],
    selectedTitle: 'Explorateur',
    unlockedTitles: ['Explorateur', 'Pro', 'Créateur'],
    selectedTheme: 'light',
    bannerPath: 'lib/assets/tenue1.png',
  );

  static UserProfile get userProfile => _userProfile;
  static void updateUserProfile(UserProfile newProfile) {
    _userProfile = newProfile;
  }
}
