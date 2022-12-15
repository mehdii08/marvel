import 'package:equatable/equatable.dart';
import 'package:marvel_characters/core/errors/failures.dart';
import 'package:marvel_characters/domain/entities/character.dart';

abstract class CharactersState extends Equatable {
  final List<Character> characters;

  const CharactersState(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharactersInitial extends CharactersState {
  const CharactersInitial({required List<Character> characters})
      : super(characters);
}

class CharactersLoading extends CharactersState {
  const CharactersLoading({required List<Character> characters})
      : super(characters);
}

class CharactersLoaded extends CharactersState {
  const CharactersLoaded({required List<Character> characters})
      : super(characters);
}

class CharactersLoadFailed extends CharactersState {
  final Failure failure;
  const CharactersLoadFailed(
      {required List<Character> characters, required this.failure})
      : super(characters);
}
