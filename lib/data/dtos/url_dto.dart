import 'package:equatable/equatable.dart';
import 'package:marvel_characters/domain/entities/url.dart';

class UrlDTO extends Equatable {
  final String type;
  final String url;

  const UrlDTO(this.type, this.url);

  factory UrlDTO.fromJson(Map<String, dynamic> json) {
    return UrlDTO(json['type'], json['url']);
  }

  Url get entity => Url(type, url);

  @override
  List<Object?> get props => [type, url];
}
