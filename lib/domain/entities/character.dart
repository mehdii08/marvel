import 'package:equatable/equatable.dart';
import 'package:marvel_characters/domain/entities/image.dart';
import 'package:marvel_characters/domain/entities/items.dart';
import 'package:marvel_characters/domain/entities/url.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String description;
  final String modified; //todo DateTime
  final String resourceURI;
  final List<Url> urls;
  final Image thumbnail;
  final Items comics;
  final Items stories;
  final Items events;
  final Items series;

  const Character({
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