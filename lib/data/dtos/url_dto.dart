import 'package:equatable/equatable.dart';
import 'package:marvel_characters/domain/entities/url.dart';

class UrlDTO extends Equatable {
  final String type;
  final String url;

  const UrlDTO({required this.type, required this.url});

  factory UrlDTO.fromJson({required Map<String, dynamic> json}) {
    return UrlDTO(type: json['type'],url: json['url']);
  }

  Url get entity => Url(type, url);

  @override
  List<Object?> get props => [type, url];
}
