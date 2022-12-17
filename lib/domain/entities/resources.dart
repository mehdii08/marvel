import 'package:equatable/equatable.dart';
import 'package:marvel_characters/domain/entities/resource.dart';

class Resources extends Equatable {
  final String title;
  final int available;
  final int returned;
  final String collectionURI;
  final List<Resource> items;

  const Resources(
    this.title,
    this.available,
    this.returned,
    this.collectionURI,
    this.items,
  );

  @override
  List<Object?> get props => [title, available, returned, collectionURI, items];
}
