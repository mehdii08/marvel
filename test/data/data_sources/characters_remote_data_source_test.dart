import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_characters/core/config.dart';
import 'package:marvel_characters/core/network/api_helper.dart';
import 'package:marvel_characters/data/data_sources/characters_remote_data_source.dart';
import 'package:marvel_characters/data/dtos/character_dto.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockApiHelper extends Mock implements ApiHelper {}

void main() {
  late CharactersRemoteDataSource dataSource;
  late MockApiHelper apiHelper;

  setUp(() {
    registerFallbackValue(Method.get);
    apiHelper = MockApiHelper();
    dataSource = CharactersRemoteDataSource(api: apiHelper);
  });

  test('getCharactersTest', () async {
    final responseJson = jsonDecode(fixture('get_characters.json'));
    final testResult = responseJson['data']['results'] as List<dynamic>;
    final characters = testResult.map((e) => CharacterDTO.fromJson(e)).toList();
    when(() => apiHelper.request(
              any(),
              method: any(named: 'method'),
              queryParameters: any(named: 'queryParameters'),
              data: any(named: 'data'),
            ))
        .thenAnswer((_) async => Response(
            data: json.decode(fixture('get_characters.json')),
            statusCode: 200,
            requestOptions: RequestOptions(path: '')));

    final result = await dataSource.getCharacters(
      limit: 5,
      offset: 0,
    );

    verify(() => apiHelper.request(
          '$apiPath/characters',
          queryParameters: {
            'limit': 5,
            'offset': 0,
          },
        )).called(1);

    expect(result, characters);

    await dataSource.getCharacters(limit: 5, offset: 0);

    verify(() => apiHelper.request(
          '$apiPath/characters',
          queryParameters: {
            'limit': 5,
            'offset': 0,
          },
        )).called(1);
  });
}
