import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:marvel_characters/core/errors/failures.dart';
import 'package:marvel_characters/data/dtos/character.dart';
import 'package:marvel_characters/data/repositories/characters_repository.dart';
import 'package:marvel_characters/domain/entities/character.dart';
import 'package:flutter/services.dart' show rootBundle;

// @LazySingleton(as: CharactersRepository)
class CharactersFakeRemoteRepository implements CharactersRepository {
  const CharactersFakeRemoteRepository();

  @override
  Future<Either<Failure, List<Character>>> getCharacters(
      {int? limit, int? offset}) async {
    final json =
        jsonDecode(await rootBundle.loadString('assets/character.json'));
    final character = CharacterDTO.fromJson(json);
    try {
      var result = List.generate(limit ?? 5, (index) => character.entity);
      await Future.delayed(const Duration(seconds: 3));
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacter(
      {required int characterId}) async {
    final json =
        jsonDecode(await rootBundle.loadString('assets/character.json'));
    final character = CharacterDTO.fromJson(json);
    try {
      return Right(character.entity);
    } on Exception catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
