import 'package:equatable/equatable.dart';
import 'package:marvel_characters/domain/entities/resource.dart';

class Items extends Equatable {
  final int available;
  final int returned;
  final String collectionURI;
  final List<Resource> items;

  const Items(
    this.available,
    this.returned,
    this.collectionURI,
    this.items,
  );

  @override
  List<Object?> get props => [available, returned, collectionURI, items];
}
