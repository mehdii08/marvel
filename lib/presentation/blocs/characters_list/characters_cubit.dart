import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:marvel_characters/core/config.dart';
import 'package:marvel_characters/domain/use_cases/get_characters.dart';
import 'package:marvel_characters/presentation/blocs/characters_list/characters_state.dart';

@injectable
class CharactersCubit extends Cubit<CharactersState> {
  final GetCharacters getCharacters;

  CharactersCubit({required this.getCharacters})
      : super(const CharactersInitial(characters: []));

  fetchData() async {
    if (state is CharactersLoading) {
      return;
    }
    emit(CharactersLoading(characters: state.characters));
    final result = await getCharacters.call(Params(
      limit: lazyLoadLimit,
      offset: state.characters.length,
    ));
    result.fold(
      (l) =>
          emit(CharactersLoadFailed(characters: state.characters, failure: l)),
      (r) => emit(CharactersLoaded(characters: [...state.characters, ...r])),
    );
  }
}
