import 'package:flutter/material.dart';
import 'package:marvel_characters/domain/entities/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;
  const CharacterListItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            SizedBox(
                width: 150,
                height: 150,
                child: Image.network(character.thumbnail.url)),
            Column(
              children: [
                Text(
                  character.name,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
