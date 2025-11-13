// card_item.dart
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;

  const CardItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(title),
      ),
    );
  }
}

