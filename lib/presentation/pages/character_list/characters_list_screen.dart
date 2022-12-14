import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18next/i18next.dart';
import 'package:marvel_characters/presentation/pages/character_list/character_list_cubit.dart';
import 'package:marvel_characters/presentation/pages/character_list/character_list_state.dart';

class CharactersListScreen extends StatefulWidget {
  static const String route = "/";

  const CharactersListScreen({Key? key}) : super(key: key);

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t('page.characters.title')),),
      body: BlocProvider<CharacterListCubit>(
        create: (_) => CharacterListCubit(),//todo get it
        child: BlocConsumer<CharacterListCubit,CharacterListState>(
          listener: (context, state){
            //todo
          },
          builder: (context, state){
              return Container();//todo
          },
        ),
      ),
    );
  }
}
