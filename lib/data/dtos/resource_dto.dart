import 'package:equatable/equatable.dart';
import 'package:marvel_characters/domain/entities/resource.dart';

class ResourceDTO extends Equatable {
  final String resourceURI;
  final String name;
  final String? type;

  const ResourceDTO({
    required this.resourceURI,
    required this.name,
    this.type,
  });

  factory ResourceDTO.fromJson({required Map<String, dynamic> json}) {
    return ResourceDTO(
      resourceURI: json['resourceURI'],
      name: json['name'],
      type: json.containsKey('type') ? json['type'] : null,
    );
  }

  Resource get entity => Resource(resourceURI, name);

  @override
  List<Object?> get props => [resourceURI, name, type];
}
