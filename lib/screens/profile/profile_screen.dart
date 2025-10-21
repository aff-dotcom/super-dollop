// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import '../../services/mock_data .dart';
import '../../widgets/badge_widget.dart';
import '../reward/badges_detail_screens.dart';
import 'edit_profile_screen.dart';
import '../../models/badge_model.dart' as badge_model;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isBadgesExpanded = false;

  @override
  Widget build(BuildContext context) {
    final userProfile = MockData.userProfile;

    return Scaffold(
      body: Stack(
        children: [
          // Bannière en arrière-plan
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 180,
            child: userProfile.bannerPath != null
                ? Image.asset(
              userProfile.bannerPath!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
                : Container(
              color: const Color.fromARGB(77, 175, 131, 182),
            ),
          ),
          // Contenu principal
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                // Logo et bouton d'édition
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0xFFaf83b6),
                        child: Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          final updatedProfile = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                userProfile: userProfile,
                              ),
                            ),
                          );
                          if (updatedProfile != null) {
                            MockData.updateUserProfile(updatedProfile);
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Photo de profil
                Transform.translate(
                  offset: const Offset(0, 20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: userProfile.photoUrl != null
                          ? NetworkImage(userProfile.photoUrl!)
                          : null,
                      backgroundColor: Colors.grey,
                      child: userProfile.photoUrl == null
                          ? const Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.grey,
                      )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // Nom
                Transform.translate(
                  offset: const Offset(0, 20),
                  child: Text(
                    "${userProfile.name} ${userProfile.surname}".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // Titre
                if (userProfile.selectedTitle.isNotEmpty)
                  Transform.translate(
                    offset: const Offset(0, 20),
                    child: Text(
                      userProfile.selectedTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFaf83b6),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                const SizedBox(height: 40),
                // Section Badges
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BadgesDetailScreen(),
                            ),
                          );
                        },
                        child: ListTile(
                          title: const Text(
                            'Badges',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFaf83b6),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              _isBadgesExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                            onPressed: () {
                              setState(() {
                                _isBadgesExpanded = !_isBadgesExpanded;
                              });
                            },
                          ),
                        ),
                      ),
                      if (_isBadgesExpanded)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: userProfile.badges.entries
                                .map<Widget>(
                                  (entry) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const BadgesDetailScreen(),
                                    ),
                                  );
                                },
                                child: BadgeWidget(
                                  badge: badge_model.Badge(
                                    type: entry.key,
                                    name: _getBadgeName(
                                      entry.key,
                                      entry.value,
                                    ),
                                    level: entry.value,
                                    threshold: _getThreshold(
                                      entry.key,
                                      entry.value,
                                    ),
                                    icon: _getIconForBadgeType(entry.key),
                                    id: '',
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Tenues
                Container(
                  height: 280,
                  margin: const EdgeInsets.only(bottom: 80),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          indicatorColor: Color(0xFFaf83b6),
                          labelColor: Color(0xFFaf83b6),
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: 'Publiées'),
                            Tab(text: 'Brouillons'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Tenues publiées
                              GridView.builder(
                                padding: const EdgeInsets.all(8),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                ),
                                itemCount: userProfile.publishedOutfits.length,
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.image,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              // Tenues brouillons
                              GridView.builder(
                                padding: const EdgeInsets.all(8),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                ),
                                itemCount: userProfile.draftOutfits.length,
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.image,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getBadgeName(String type, int level) {
    switch (type) {
      case 'fripes':
        return level >= 5 ? 'Légende des Fripes' : 'Explorateur de Fripes';
      case 'outfits':
        return level >= 5 ? 'Star des Tenues' : 'Créateur de Tenues';
      case 'avis':
        return level >= 5 ? 'Critique Expert' : 'Avis Apprecié';
      default:
        return 'Badge';
    }
  }

  int _getThreshold(String type, int level) {
    switch (type) {
      case 'fripes':
        return [1, 5, 10, 20, 30][level.clamp(0, 4)];
      case 'outfits':
        return [1, 3, 8, 15, 30][level.clamp(0, 4)];
      case 'avis':
        return [1, 5, 10, 20, 40][level.clamp(0, 4)];
      default:
        return 0;
    }
  }

  IconData _getIconForBadgeType(String type) {
    switch (type) {
      case 'fripes':
        return Icons.shopping_bag;
      case 'outfits':
        return Icons.checkroom;
      case 'avis':
        return Icons.star;
      default:
        return Icons.help;
    }
  }
}
