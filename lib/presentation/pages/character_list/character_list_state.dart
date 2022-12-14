import 'package:equatable/equatable.dart';

abstract class CharacterListState extends Equatable{
  final List<String> characters;

  const CharacterListState(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharacterListInitial extends CharacterListState{
  const CharacterListInitial(super.characters);
}

class CharacterListLoading extends CharacterListState{
  const CharacterListLoading(super.characters);
}

class CharacterListLoaded extends CharacterListState{
  const CharacterListLoaded(super.characters);
}

class CharacterListLoadFailed extends CharacterListState{
  const CharacterListLoadFailed(super.characters);
}


