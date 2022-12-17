import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/network/api_helper.dart';
import 'package:marvel_characters/data/data_sources/characters_remote_data_source.dart';
import 'package:marvel_characters/data/dtos/character_dto.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:marvel_characters/domain/repositories/characters_remote_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRemoteDataSource extends Mock
    implements CharactersRemoteDataSource {}

class MockCharacterDTO extends Mock implements CharacterDTO {}

class MockCharacter extends Mock implements Character {}

class MockApiHelper extends Mock implements ApiHelper {}

void main() {
  final apiHelper = MockApiHelper();
  late CharactersRemoteDataSource dataSource;
  late CharactersRemoteRepository repository;

  setUp(() {
    dataSource = CharactersRemoteDataSource(api: apiHelper);
    repository = CharactersRemoteRepository(remoteDataSource: dataSource);
    registerFallbackValue(Method.get);
  });

  test('getCharacters', () async {
    final characterDTO = MockCharacterDTO();
    final character = MockCharacter();
    when(() => characterDTO.entity).thenReturn(character);
    when(() => dataSource.getCharacters(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenAnswer((_) async => [characterDTO]);
    await repository.getCharacters(
      limit: 5,
      offset: 0,
    );
    verify(() => dataSource.getCharacters(
          limit: 5,
          offset: 0,
        )).called(1);
  });
}
