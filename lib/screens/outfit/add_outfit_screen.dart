import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../../utils/constants.dart' as AppColors;

class AddOutfitScreen extends StatefulWidget {
  const AddOutfitScreen({super.key});

  @override
  State<AddOutfitScreen> createState() => _AddOutfitScreenState();
}

class _AddOutfitScreenState extends State<AddOutfitScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _hashtagsController = TextEditingController();
  List<XFile> _selectedPhotos = [];
  bool _isUploading = false;

  Future<void> _pickPhotos() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _selectedPhotos = pickedFiles;
      });
    }
  }

  Future<void> _uploadOutfit() async {
    if (_selectedPhotos.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez ajouter au moins une photo et une description.')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final outfitId = FirebaseFirestore.instance.collection('outfits').doc().id;
      final List<String> photoUrls = [];

      for (var photo in _selectedPhotos) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('outfits/$userId/$outfitId/${photo.name}');
        await ref.putFile(File(photo.path));
        final url = await ref.getDownloadURL();
        photoUrls.add(url);
      }

      final hashtags = _hashtagsController.text
          .split(' ')
          .where((tag) => tag.startsWith('#'))
          .map((tag) => tag.trim())
          .toList();

      await FirebaseFirestore.instance.collection('outfits').doc(outfitId).set({
        'id': outfitId,
        'userId': userId,
        'description': _descriptionController.text,
        'hashtags': hashtags,
        'photos': photoUrls,
        'createdAt': FieldValue.serverTimestamp(),
        'likes': 0,
      });

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'points': FieldValue.increment(2),
      });

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une tenue'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _pickPhotos,
              child: Container(
                color: AppColors.secondaryColor,
                child: _selectedPhotos.isEmpty
                    ? const Icon(Icons.add_photo_alternate, size: 50)
                    : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: _selectedPhotos.length,
                  itemBuilder: (context, index) {
                    return Image.file(
                      File(_selectedPhotos[index].path),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _hashtagsController,
              decoration: const InputDecoration(
                labelText: 'Hashtags (ex: #vintage #fripes)',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _isUploading ? null : _uploadOutfit,
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Publier'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _hashtagsController.dispose();
    super.dispose();
  }
}
