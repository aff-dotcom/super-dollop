import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Citation du jour: "Réutiliser, c\'est chic !"', style: TextStyle(fontSize: 18)),
    );
  }
}
