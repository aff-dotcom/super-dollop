import 'package:flutter/material.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Récompenses')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Card(
              child: ListTile(
                leading: Icon(Icons.emoji_events, color: Colors.red),
                title: Text('Badges'),
                subtitle: Text('Collectionnez des badges en participant activement !'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: const [
                  BadgeItem(icon: Icons.star, label: 'Explorateur', description: 'Ajoutez 5 lieux'),
                  BadgeItem(icon: Icons.military_tech, label: 'Roi de la fripe', description: 'Atteignez 100 points'),
                  BadgeItem(icon: Icons.whatshot, label: 'Tendance', description: 'Postez 10 tenues'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Détails'),
            ),
          ],
        ),
      ),
    );
  }
}

class BadgeItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;

  const BadgeItem({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.red),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
