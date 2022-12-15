import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marvel_characters/core/errors/failures.dart';
import 'package:marvel_characters/core/use_case.dart';
import 'package:marvel_characters/data/repositories/characters_repository.dart';
import 'package:marvel_characters/domain/entities/character.dart';

@lazySingleton
class GetCharacters extends UseCase<List<Character>, Params> {
  final CharactersRepository _repository;

  const GetCharacters(this._repository);

  @override
  Future<Either<Failure, List<Character>>> call(Params params) =>
      _repository.getCharacters(
        limit: params.limit,
        offset: params.offset,
      );
}

class Params {
  final int? limit, offset;

  Params({
    this.limit,
    this.offset,
  });
}
