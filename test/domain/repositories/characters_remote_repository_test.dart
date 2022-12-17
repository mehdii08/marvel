import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/errors/exceptions.dart';
import 'package:marvel_characters/core/errors/failures.dart';
import 'package:marvel_characters/core/network/api_helper.dart';
import 'package:marvel_characters/data/data_sources/characters_data_source.dart';
import 'package:marvel_characters/data/dtos/character_dto.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:marvel_characters/domain/repositories/characters_remote_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRemoteDataSource extends Mock
    implements CharactersDataSource {}

class MockCharacterDTO extends Mock implements CharacterDTO {}

class MockCharacter extends Mock implements Character {}

class MockApiHelper extends Mock implements ApiHelper {}

void main() {
  late MockCharactersRemoteDataSource remoteDataSource;
  late CharactersRemoteRepository repository;

  setUp(() {
    remoteDataSource = MockCharactersRemoteDataSource();
    repository = CharactersRemoteRepository(remoteDataSource: remoteDataSource);
  });

  final tCharacterDTO = MockCharacterDTO();
  final tCharacter = MockCharacter();
  when(() => tCharacterDTO.entity).thenReturn(tCharacter);

  test('Should call to data source if network available', () async {
    when(() => remoteDataSource.getCharacters(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenAnswer((_) async => [tCharacterDTO]);
    await repository.getCharacters(
      limit: 5,
      offset: 0,
    );
    verify(() => remoteDataSource.getCharacters(
          limit: 5,
          offset: 0,
        )).called(1);
  });

  test('Network is not available', () async {
    when(() => remoteDataSource.getCharacters(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenThrow(const NetworkException());
    final result = await repository.getCharacters(
      limit: 5,
      offset: 0,
    );
    expect(result, const Left(NetworkFailure()));
  });

  test('DataSource throws exception', () async {
    when(() => remoteDataSource.getCharacters(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ))
        .thenThrow(
            const ServerException(statusCode: 409, message: 'Test Message'));
    final result = await repository.getCharacters(
      limit: 5,
      offset: 0,
    );
    expect(result, const Left(ServerFailure(message: 'Test Message')));
  });
}
