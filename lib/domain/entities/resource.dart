import 'package:equatable/equatable.dart';

class Resource extends Equatable {
  final String resourceURI;
  final String name;
  final String? type;

  const Resource(this.resourceURI, this.name, {this.type});

  @override
  List<Object?> get props => [resourceURI, name, type];
}
