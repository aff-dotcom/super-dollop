class UserProfile {
  final String uid;
  final String name;
  final String surname;
  final String? photoUrl;
  final double points;
  final Map<String, int> badges;
  final Map<String, dynamic> stats;
  final List<String> favoriteOutfits;
  final List<String> favoritePlaces;
  final List<String> publishedOutfits;
  final List<String> draftOutfits;
  final String selectedTitle;
  final List<String> unlockedTitles;
  final String selectedTheme;
  final String? bannerPath;

  UserProfile({
    required this.uid,
    required this.name,
    required this.surname,
    this.photoUrl,
    required this.points,
    required this.badges,
    required this.stats,
    required this.favoriteOutfits,
    required this.favoritePlaces,
    required this.publishedOutfits,
    required this.draftOutfits,
    required this.selectedTitle,
    required this.unlockedTitles,
    required this.selectedTheme,
    this.bannerPath,
  });

  // Méthode pour créer une copie modifiée du profil
  UserProfile copyWith({
    String? uid,
    String? name,
    String? surname,
    String? photoUrl,
    double? points,
    Map<String, int>? badges,
    Map<String, dynamic>? stats,
    List<String>? favoriteOutfits,
    List<String>? favoritePlaces,
    List<String>? publishedOutfits,
    List<String>? draftOutfits,
    String? selectedTitle,
    List<String>? unlockedTitles,
    String? selectedTheme,
    String? bannerPath,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      photoUrl: photoUrl ?? this.photoUrl,
      points: points ?? this.points,
      badges: badges ?? this.badges,
      stats: stats ?? this.stats,
      favoriteOutfits: favoriteOutfits ?? this.favoriteOutfits,
      favoritePlaces: favoritePlaces ?? this.favoritePlaces,
      publishedOutfits: publishedOutfits ?? this.publishedOutfits,
      draftOutfits: draftOutfits ?? this.draftOutfits,
      selectedTitle: selectedTitle ?? this.selectedTitle,
      unlockedTitles: unlockedTitles ?? this.unlockedTitles,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      bannerPath: bannerPath ?? this.bannerPath,
    );
  }
}
