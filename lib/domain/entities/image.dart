import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final String path;
  final String extension;

  const Image(this.path, this.extension);

  String get url => '$path.$extension';

  @override
  List<Object?> get props => [path, extension];
}
