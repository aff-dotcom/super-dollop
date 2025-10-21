// lib/screens/profile/edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../models/user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile userProfile;
  const EditProfileScreen({
    super.key,
    required this.userProfile,
  });
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserProfile _editedProfile;
  String? _selectedBanner;
  String? _selectedTitle;
  List<String> _availableTitles = ['Explorateur', 'Pro des Fripes', 'Éco-Héros'];

  // Liste des chemins des bannières disponibles
  final List<String> backgroundImages = [
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

  @override
  void initState() {
    super.initState();
    _editedProfile = widget.userProfile;
    _selectedBanner = _editedProfile.bannerPath;
    _selectedTitle = _editedProfile.selectedTitle;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _editedProfile = _editedProfile.copyWith(photoUrl: pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Navigator.pop(
                context,
                _editedProfile.copyWith(
                  bannerPath: _selectedBanner,
                  selectedTitle: _selectedTitle ?? _editedProfile.selectedTitle,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Photo de profil
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _editedProfile.photoUrl != null
                    ? FileImage(File(_editedProfile.photoUrl!))
                    : null,
                child: _editedProfile.photoUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            // Sélecteur de bannière
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bannière du profil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Choisir une bannière'),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: backgroundImages.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: () => setState(() => _selectedBanner = null),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _selectedBanner == null
                                          ? Colors.blue
                                          : Colors.grey.shade300!,
                                      width: 2,
                                    ),
                                    color: Colors.grey[100],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Aucune',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            }
                            final bannerPath = backgroundImages[index - 1];
                            return GestureDetector(
                              onTap: () => setState(() => _selectedBanner = bannerPath),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: _selectedBanner == bannerPath
                                            ? Colors.blue
                                            : Colors.grey.shade300!,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.asset(
                                        bannerPath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (_selectedBanner == bannerPath)
                                    const Positioned(
                                      top: 4,
                                      right: 4,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.blue,
                                        child: Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Choisir une bannière'),
                ),
                if (_selectedBanner != null) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Aperçu:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(_selectedBanner!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            // Sélecteur de titre
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Titre du profil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Choisir un titre'),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _availableTitles.length,
                          itemBuilder: (context, index) {
                            final title = _availableTitles[index];
                            return ListTile(
                              title: Text(title),
                              trailing: _selectedTitle == title
                                  ? const Icon(Icons.check, color: Colors.blue)
                                  : null,
                              onTap: () => setState(() => _selectedTitle = title),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Choisir un titre'),
                ),
                if (_selectedTitle != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Titre sélectionné : $_selectedTitle',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
