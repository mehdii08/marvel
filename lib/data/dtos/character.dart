import 'package:equatable/equatable.dart';

class CharacterDTO extends Equatable{
  const CharacterDTO();

  factory CharacterDTO.fromJson(Map<String, dynamic> json){
    return const CharacterDTO();//todo
  }

  @override
  List<Object?> get props => [/*todo*/];

}