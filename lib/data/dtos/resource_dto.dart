import 'package:equatable/equatable.dart';
import 'package:marvel_characters/domain/entities/resource.dart';

class ResourceDTO extends Equatable {
  final String resourceURI;
  final String name;
  final String? type;

  const ResourceDTO(this.resourceURI, this.name, {this.type});

  factory ResourceDTO.fromJson(Map<String, dynamic> json) {
    return ResourceDTO(json['resourceURI'], json['name'],
        type: json.containsKey('type') ? json['extension'] : null);
  }

  Resource get entity => Resource(resourceURI, name);

  @override
  List<Object?> get props => [resourceURI, name, type];
}
