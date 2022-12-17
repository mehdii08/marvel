import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/errors/failures.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:marvel_characters/domain/use_cases/get_characters.dart';
import 'package:marvel_characters/presentation/blocs/characters_list/characters_cubit.dart';
import 'package:marvel_characters/presentation/blocs/characters_list/characters_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCharacters extends Mock implements GetCharacters {}

class MockCharacter extends Mock implements Character {}

void main() {
  late MockGetCharacters mockGetCharacters;
  final mockCharacter = MockCharacter();
  final params = Params();

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    registerFallbackValue(params);
  });

  test(
    'Initial state',
    () => expect(
      CharactersCubit(getCharacters: mockGetCharacters).state,
      const CharactersInitial(characters: []),
    ),
  );

  blocTest<CharactersCubit, CharactersState>(
    'Request was successful',
    build: () {
      when(() => mockGetCharacters.call(any()))
          .thenAnswer((_) async => Right([mockCharacter]));
      CharactersCubit cubit = CharactersCubit(getCharacters: mockGetCharacters);
      return cubit;
    },
    act: (bloc) => bloc.fetchData(),
    expect: () => [
      const CharactersLoading(characters: []),
      CharactersLoaded(characters: [mockCharacter]),
    ],
  );

  blocTest<CharactersCubit, CharactersState>('Request was not successful',
      build: () {
        when(() => mockGetCharacters.call(any())).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Test Message')));
        CharactersCubit cubit =
            CharactersCubit(getCharacters: mockGetCharacters);
        return cubit;
      },
      act: (bloc) => bloc.fetchData(),
      expect: () => [
            const CharactersLoading(characters: []),
            const CharactersLoadFailed(
              characters: [],
              failure: ServerFailure(message: 'Test Message'),
            ),
          ]);
}
