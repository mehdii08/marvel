import 'package:flutter/material.dart';
import 'package:flutter_i18next/i18next.dart';
import 'package:marvel_characters/core/app_colors.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:marvel_characters/presentation/widgets/resources_chip.dart';
import 'package:marvel_characters/presentation/widgets/urls_chip.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CharacterDetailsScreen extends StatelessWidget {
  static const route = "/character/:character_id/details";
  static String generateRoute(int characterId) =>
      '/character/$characterId/details';
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t('page.character_details.title')),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            color: AppColors.placeHolderColor,
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: Hero(
                tag: 'image:${character.id}',
                child: Image.network(character.thumbnail.url)),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 16),
                Text(
                  character.description,
                  style: const TextStyle(fontSize: 16),
                ),
                if (character.urls.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  UrlsChip(
                    urls: character.urls,
                    onItemPressed: (url) async {
                      if (await canLaunchUrlString(url)) {
                        launchUrlString(url);
                      }
                    },
                  ),
                ],
                if (character.comics.available > 0) ...[
                  const SizedBox(height: 16),
                  ResourcesChip(resources: character.comics),
                ],
                if (character.series.available > 0) ...[
                  const SizedBox(height: 16),
                  ResourcesChip(resources: character.series),
                ],
                if (character.stories.available > 0) ...[
                  const SizedBox(height: 16),
                  ResourcesChip(resources: character.stories),
                ],
                if (character.events.available > 0) ...[
                  const SizedBox(height: 16),
                  ResourcesChip(resources: character.events),
                ],
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
