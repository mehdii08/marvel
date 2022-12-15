import 'package:equatable/equatable.dart';

class Url extends Equatable {
  final String type;
  final String url;

  const Url(this.type, this.url);

  @override
  List<Object?> get props => [type, url];
}
