import 'package:equatable/equatable.dart';
import 'package:marvel_characters/data/dtos/image_dto.dart';
import 'package:marvel_characters/data/dtos/items_dto.dart';
import 'package:marvel_characters/data/dtos/url_dto.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:marvel_characters/domain/entities/url.dart';

class CharacterDTO extends Equatable {
  final int id;
  final String name;
  final String description;
  final String modified; //todo DateTime
  final String resourceURI;
  final List<UrlDTO> urls;
  final ImageDTO thumbnail;
  final ItemsDTO comics;
  final ItemsDTO stories;
  final ItemsDTO events;
  final ItemsDTO series;

  const CharacterDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.resourceURI,
    required this.urls,
    required this.thumbnail,
    required this.comics,
    required this.stories,
    required this.events,
    required this.series,
  });

  factory CharacterDTO.fromJson(Map<String, dynamic> json) {
    final urls = List<UrlDTO>.from(json['urls'].map((v) => UrlDTO.fromJson(v)));
    return CharacterDTO(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      modified: json['modified'],
      resourceURI: json['resourceURI'],
      urls: urls,
      thumbnail: ImageDTO.fromJson(json['thumbnail']),
      comics: ItemsDTO.fromJson(json['comics']),
      stories: ItemsDTO.fromJson(json['stories']),
      events: ItemsDTO.fromJson(json['events']),
      series: ItemsDTO.fromJson(json['series']),
    );
  }

  Character get entity => Character(
        id: id,
        name: name,
        description: description,
        modified: modified,
        resourceURI: resourceURI,
        urls: List<Url>.from(urls.map((e) => e.entity)),
        thumbnail: thumbnail.entity,
        comics: comics.entity,
        stories: stories.entity,
        events: events.entity,
        series: series.entity,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        modified,
        resourceURI,
        urls,
        thumbnail,
        comics,
        stories,
        events,
        series,
      ];
}
