import 'package:equatable/equatable.dart';
import 'package:marvel_characters/domain/entities/image.dart';

class ImageDTO extends Equatable {
  final String path;
  final String extension;

  const ImageDTO({required this.path, required this.extension});

  factory ImageDTO.fromJson(Map<String, dynamic> json) {
    return ImageDTO(path: json['path'], extension: json['extension']);
  }

  Image get entity => Image(path, extension);

  @override
  List<Object?> get props => [path, extension];
}
