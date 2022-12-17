import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marvel_characters/core/errors/failures.dart';
import 'package:marvel_characters/data/data_sources/characters_data_source.dart';
import 'package:marvel_characters/data/repositories/characters_repository.dart';
import 'package:marvel_characters/domain/entities/character.dart';

@LazySingleton(as: CharactersRepository)
class CharactersRemoteRepository implements CharactersRepository {
  final CharactersDataSource remoteDataSource;

  const CharactersRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Character>>> getCharacters(
      {int? limit, int? offset}) async {
    try {
      final result =
          await remoteDataSource.getCharacters(limit: limit, offset: offset);
      return Right(result.map((e) => e.entity).toList());
    } on Exception catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
