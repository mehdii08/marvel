import 'package:equatable/equatable.dart';
import 'package:marvel_characters/data/dtos/resource_dto.dart';
import 'package:marvel_characters/domain/entities/resources.dart';
import 'package:marvel_characters/domain/entities/resource.dart';

class ResourcesDTO extends Equatable {
  final String title;
  final int available;
  final int returned;
  final String collectionURI;
  final List<ResourceDTO> items;

  const ResourcesDTO({
    required this.title,
    required this.available,
    required this.returned,
    required this.collectionURI,
    required this.items,
  });

  factory ResourcesDTO.fromJson({required String title, required Map<String, dynamic> json}) {
    final items = List<ResourceDTO>.from(
        json['items'].map((v) => ResourceDTO.fromJson(json: v)));
    return ResourcesDTO(
        title: title,
        available: json['available'],
        returned: json['returned'],
        collectionURI: json['collectionURI'],
        items: items,
    );
  }

  Resources get entity => Resources(title, available, returned, collectionURI,
      List<Resource>.from(items.map((e) => e.entity)));

  @override
  List<Object?> get props => [title, available, returned, collectionURI, items];
}
