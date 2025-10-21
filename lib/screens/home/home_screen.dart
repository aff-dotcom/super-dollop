// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/place.dart';
import '../../services/mock_data .dart';
import 'reward_progress_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Place topRatedPlace = MockData.places.reduce((a, b) =>
    a.reviews.length > b.reviews.length ? a : b);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 50.0, bottom: 80.0),
          child: Column(
            children: [
              // Logo en haut à gauche
              const Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 80,
                  height: 24,
                ),
              ),
              const SizedBox(height: 10),
              // Citation du jour
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Citation du jour: \"Réutiliser, c'est chic !\"",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFaf83b6),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Section News
              const Card(
                child: ListTile(
                  title: Text(
                      'Nouvelle collection de vêtements recyclés disponible !'),
                ),
              ),
              const SizedBox(height: 20),
              // Barre de progression des récompenses
              const Text(
                'Progression des Récompenses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFaf83b6),
                ),
              ),
              RewardProgressBar(
                currentPoints: MockData.userProfile.points.toInt(),
                maxPoints: 100,
              ),
              const SizedBox(height: 20),
              // Lieu le plus populaire
              GestureDetector(
                onTap: () {
                  // Navigue vers la carte
                  context.go('/map');
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lieu le plus populaire (24h)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFaf83b6)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          topRatedPlace.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: topRatedPlace.photos.take(3).map((photoUrl) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    photoUrl,
                                    width: 120,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          topRatedPlace.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            Text(
                              ' ${topRatedPlace.rating} (${topRatedPlace.reviews.length} avis)',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Adresse: ${topRatedPlace.address}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
