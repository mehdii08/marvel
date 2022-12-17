import 'package:marvel_characters/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:marvel_characters/domain/entities/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters({
    int? limit,
    int? offset,
  });
}
