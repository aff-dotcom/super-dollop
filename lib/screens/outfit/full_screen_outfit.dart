import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/outfit.dart';

class FullScreenOutfit extends StatefulWidget {
  final Outfit outfit;
  const FullScreenOutfit({super.key, required this.outfit});

  @override
  State<FullScreenOutfit> createState() => _FullScreenOutfitState();
}

class _FullScreenOutfitState extends State<FullScreenOutfit> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _showDetails = false;
  final TextEditingController _commentController = TextEditingController();

  Future<void> _addComment() async {
    if (_commentController.text.isEmpty) return;
    await FirebaseFirestore.instance
        .collection('outfits')
        .doc(widget.outfit.id)
        .collection('comments')
        .add({
      'text': _commentController.text,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'userName': FirebaseAuth.instance.currentUser!.displayName ?? 'Anonyme',
      'createdAt': FieldValue.serverTimestamp(),
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -5) {
            setState(() => _showDetails = true);
          } else if (details.primaryDelta! > 5) {
            setState(() => _showDetails = false);
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.outfit.photos.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return Center(
                  child: Hero(
                    tag: 'outfit-${widget.outfit.id}-$index',
                    child: Image.network(
                      widget.outfit.photos[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: _showDetails ? 100 : 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.outfit.photos.length,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            if (_showDetails)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.outfit.description,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: widget.outfit.hashtags
                            .map((tag) => Chip(
                          label: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 12)),
                          backgroundColor: Colors.white24,
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Commentaires",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('outfits')
                            .doc(widget.outfit.id)
                            .collection('comments')
                            .orderBy('createdAt', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const CircularProgressIndicator();
                          final comments = snapshot.data!.docs;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              return ListTile(
                                title: Text(comment['text'], style: const TextStyle(color: Colors.white)),
                                subtitle: Text(comment['userName'], style: const TextStyle(color: Colors.white70)),
                              );
                            },
                          );
                        },
                      ),
                      TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'Ajouter un commentaire...',
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onSubmitted: (_) => _addComment(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _commentController.dispose();
    super.dispose();
  }
}
