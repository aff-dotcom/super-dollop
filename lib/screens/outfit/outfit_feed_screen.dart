// lib/screens/outfit/outfit_feed_screen.dart
import 'package:flutter/material.dart';
import '../../models/outfit.dart';
import '../../services/mock_data .dart';
import 'full_screen_outfit.dart';

class OutfitFeedScreen extends StatefulWidget {
  const OutfitFeedScreen({super.key});

  @override
  State<OutfitFeedScreen> createState() => _OutfitFeedScreenState();
}

class _OutfitFeedScreenState extends State<OutfitFeedScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Outfit> _filteredOutfits;

  @override
  void initState() {
    super.initState();
    _filteredOutfits = MockData.outfits;
    _searchController.addListener(_filterOutfits);
  }

  void _filterOutfits() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOutfits = MockData.outfits.where((outfit) {
        return outfit.description.toLowerCase().contains(query) ||
            outfit.hashtags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFecbdae),
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFecbdea),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Rechercher une tenue...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintStyle: TextStyle(color: Colors.black54),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: const Color(0xFFecbdae),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          padding: const EdgeInsets.all(16),
          itemCount: _filteredOutfits.length,
          itemBuilder: (context, index) {
            final outfit = _filteredOutfits[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenOutfit(outfit: outfit),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 9,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          outfit.photos.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              outfit.description,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 4,
                                  children: outfit.hashtags
                                      .map((tag) => Chip(
                                    label: Text(tag, style: const TextStyle(fontSize: 10)),
                                  ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/add-outfit'),
        backgroundColor: const Color(0xFFaf83b6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
