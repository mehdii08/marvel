import 'package:flutter/material.dart';
import 'package:marvel_characters/core/app_colors.dart';
import 'package:marvel_characters/domain/entities/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;
  final Function(Character) onTap;

  const CharacterListItem(
      {super.key, required this.character, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(character),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 150,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Container(
                  width: 150,
                  height: 150,
                  color: AppColors.placeHolderColor,
                  child: Hero(
                    tag: 'image:${character.id}',
                    child: Image.network(character.thumbnail.url),
                  )),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  if (character.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      character.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    getItemsCount(character),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              )),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  String getItemsCount(Character character) {
    var buffer = StringBuffer();
    if (character.comics.available > 0) {
      buffer.write('${character.comics.title}(${character.comics.available}) ');
    }
    if (character.series.available > 0) {
      if (buffer.length > 0) {
        buffer.write(' - ');
      }
      buffer.write('${character.series.title}(${character.series.available}) ');
    }
    if (character.stories.available > 0) {
      if (buffer.length > 0) {
        buffer.write(' - ');
      }
      buffer
          .write('${character.stories.title}(${character.stories.available}) ');
    }
    if (character.events.available > 0) {
      if (buffer.length > 0) {
        buffer.write(' - ');
      }
      buffer.write('${character.events.title}(${character.events.available}) ');
    }
    if (character.urls.isNotEmpty) {
      if (buffer.length > 0) {
        buffer.write(' - ');
      }
      buffer.write('Urls(${character.urls.length}) ');
    }
    return buffer.toString();
  }
}
