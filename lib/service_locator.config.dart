// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/network/api_helper.dart' as _i5;
import 'data/data_sources/characters_data_source.dart' as _i6;
import 'data/data_sources/characters_remote_data_source.dart' as _i7;
import 'data/repositories/characters_repository.dart' as _i8;
import 'domain/repositories/characters_remote_repository.dart' as _i9;
import 'domain/use_cases/get_characters.dart' as _i10;
import 'presentation/blocs/characters_list/characters_cubit.dart' as _i11;
import 'service_locator.dart' as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  await gh.singletonAsync<_i4.Dio>(
    () => registerModule.resolveDio,
    preResolve: true,
  );
  gh.lazySingleton<_i5.ApiHelper>(() => _i5.ApiHelper(get<_i4.Dio>()));
  gh.lazySingleton<_i6.CharactersDataSource>(
      () => _i7.CharactersRemoteDataSource(api: get<_i5.ApiHelper>()));
  gh.lazySingleton<_i8.CharactersRepository>(() =>
      _i9.CharactersRemoteRepository(
          remoteDataSource: get<_i6.CharactersDataSource>()));
  gh.lazySingleton<_i10.GetCharacters>(
      () => _i10.GetCharacters(get<_i8.CharactersRepository>()));
  gh.factory<_i11.CharactersCubit>(
      () => _i11.CharactersCubit(getCharacters: get<_i10.GetCharacters>()));
  return get;
}

class _$RegisterModule extends _i12.RegisterModule {}
