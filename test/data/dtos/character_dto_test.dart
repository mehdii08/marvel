import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/data/dtos/character_dto.dart';
import 'package:marvel_characters/data/dtos/image_dto.dart';
import 'package:marvel_characters/data/dtos/resource_dto.dart';
import 'package:marvel_characters/data/dtos/resources_dto.dart';
import 'package:marvel_characters/data/dtos/url_dto.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:marvel_characters/domain/entities/url.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const id = 99;
  const name = 'Iron Man';
  const description = '';
  const modified = '2014-04-29T14:18:17-0400';
  const resourceURI = 'http://gateway.marvel.com/v1/public/characters/1011334';
  const thumbnail = ImageDTO(
      path: 'http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784',
      extension: 'jpg');
  const comics = ResourcesDTO(
      title: 'Comics',
      available: 1,
      returned: 1,
      collectionURI:
          'http://gateway.marvel.com/v1/public/characters/1011334/comics',
      items: [
        ResourceDTO(
          resourceURI: 'http://gateway.marvel.com/v1/public/comics/21366',
          name: 'Avengers: The Initiative (2007) #14',
        )
      ]);
  const stories = ResourcesDTO(
    title: 'Stories',
    available: 1,
    returned: 1,
    collectionURI:
        'http://gateway.marvel.com/v1/public/characters/1011334/stories',
    items: [
      ResourceDTO(
        resourceURI: 'http://gateway.marvel.com/v1/public/stories/19947',
        name: 'Cover #19947',
        type: 'cover',
      ),
    ],
  );
  const series = ResourcesDTO(
    title: 'Series',
    available: 1,
    returned: 1,
    collectionURI:
        'http://gateway.marvel.com/v1/public/characters/1011334/series',
    items: [
      ResourceDTO(
        resourceURI: 'http://gateway.marvel.com/v1/public/series/1945',
        name: 'Avengers: The Initiative (2007 - 2010)',
      ),
    ],
  );
  const events = ResourcesDTO(
    title: 'Events',
    available: 1,
    returned: 1,
    collectionURI:
        'http://gateway.marvel.com/v1/public/characters/1011334/events',
    items: [
      ResourceDTO(
        resourceURI: 'http://gateway.marvel.com/v1/public/events/269',
        name: 'Secret Invasion',
      ),
    ],
  );
  const urls = [
    UrlDTO(
      type: 'detail',
      url:
          'http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=5295c550265a24404f9cace64c971bd6',
    )
  ];

  const tCharacterDTO = CharacterDTO(
    id: id,
    name: name,
    description: description,
    modified: modified,
    resourceURI: resourceURI,
    thumbnail: thumbnail,
    comics: comics,
    stories: stories,
    series: series,
    events: events,
    urls: urls,
  );
  final tCharacter = Character(
    id: id,
    name: name,
    description: description,
    modified: DateTime.parse(modified),
    resourceURI: resourceURI,
    thumbnail: thumbnail.entity,
    comics: comics.entity,
    stories: stories.entity,
    series: series.entity,
    events: events.entity,
    urls: List<Url>.from(urls.map((e) => e.entity)),
  );
  test('fromJson', () {
    final result =
        CharacterDTO.fromJson(json.decode(fixture('character.json')));
    expect(result, tCharacterDTO);
  });
  test('toEntity', () {
    expect(tCharacter, tCharacterDTO.entity);
  });
}
