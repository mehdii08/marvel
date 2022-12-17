import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/errors/failures.dart';
import 'package:marvel_characters/data/repositories/characters_repository.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:marvel_characters/domain/use_cases/get_characters.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

class MockCharacter extends Mock implements Character {}

void main() {
  late GetCharacters useCase;
  late MockCharactersRepository repository;
  const limit = 5;
  const offset = 0;
  final tResult = [MockCharacter()];
  final tParams = Params(
    limit: limit,
    offset: offset,
  );

  setUp(() {
    repository = MockCharactersRepository();
    useCase = GetCharacters(repository);
  });

  test('Should forward call to repository', () async {
    when(() => repository.getCharacters(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenAnswer((_) async => Right(tResult));
    await useCase(tParams);
    verify(() => repository.getCharacters(
          limit: limit,
          offset: offset,
        )).called(1);
  });

  test('Repository returns the result', () async {
    when(() => repository.getCharacters(
          limit: any(named: 'limit'),
          offset: any(named: 'offset'),
        )).thenAnswer((_) async => Right(tResult));
    final result = await useCase(tParams);
    expect(result, Right(tResult));
  });

  test('Repository returns failure', () async {
    when(() => repository.getCharacters(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ))
        .thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Test message')));
    final result = await useCase(tParams);
    expect(result, const Left(ServerFailure(message: 'Test message')));
  });
}
