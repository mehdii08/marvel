import 'package:equatable/equatable.dart';
import 'package:marvel_characters/data/dtos/resource_dto.dart';
import 'package:marvel_characters/domain/entities/items.dart';
import 'package:marvel_characters/domain/entities/resource.dart';

class ItemsDTO extends Equatable {
  final int available;
  final int returned;
  final String collectionURI;
  final List<ResourceDTO> items;

  const ItemsDTO(
    this.available,
    this.returned,
    this.collectionURI,
    this.items,
  );

  factory ItemsDTO.fromJson(Map<String, dynamic> json) {
    final items = List<ResourceDTO>.from(
        json['items'].map((v) => ResourceDTO.fromJson(v)));
    return ItemsDTO(
        json['available'], json['returned'], json['collectionURI'], items);
  }

  Items get entity => Items(available, returned, collectionURI,
      List<Resource>.from(items.map((e) => e.entity)));

  @override
  List<Object?> get props => [available, returned, collectionURI, items];
}
