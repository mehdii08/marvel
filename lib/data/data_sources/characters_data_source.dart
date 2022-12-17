import 'package:marvel_characters/data/dtos/characterDTO.dart';

abstract class CharactersDataSource {
  Future<List<CharacterDTO>> getCharacters({int? limit, int? offset});
}
