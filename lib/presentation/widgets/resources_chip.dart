import 'package:flutter/material.dart';
import 'package:marvel_characters/domain/entities/resources.dart';

class ResourcesChip extends StatelessWidget {
  final Resources resources;

  const ResourcesChip({Key? key, required this.resources}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          resources.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4.0,
          children: List<Chip>.from(
            resources.items.map(
              (e) => Chip(label: Text(e.name)),
            ),
          ),
        ),
      ],
    );
  }
}
