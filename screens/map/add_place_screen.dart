import 'package:flutter/material.dart';
import '../../utils/constants.dart' as AppColors;

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  final List<String> _tags = [];
  String _review = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un lieu'), backgroundColor: AppColors.primaryColor),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nom du lieu'),
              validator: (value) => value!.isEmpty ? 'Requis' : null,
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Adresse'),
              validator: (value) => value!.isEmpty ? 'Requis' : null,
              onSaved: (value) => _address = value!,
            ),
            const SizedBox(height: 16),
            // Tags
            Wrap(
              spacing: 8,
              children: _tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _tags.add('Nouveau tag ${_tags.length + 1}');
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un tag'),
            ),
            // Avis
            TextFormField(
              decoration: const InputDecoration(labelText: 'Avis'),
              onSaved: (value) => _review = value!,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context);
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
