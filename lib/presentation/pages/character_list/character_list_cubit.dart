import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_characters/presentation/pages/character_list/character_list_state.dart';

class CharacterListCubit extends Cubit<CharacterListState>{

  CharacterListCubit() : super(const CharacterListInitial([]));

  fetchData(){

  }
}