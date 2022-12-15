import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18next/i18next.dart';
import 'package:marvel_characters/presentation/blocs/characters_list/characters_cubit.dart';
import 'package:marvel_characters/presentation/blocs/characters_list/characters_state.dart';
import 'package:marvel_characters/presentation/widgets/characters_list_item.dart';
import 'package:marvel_characters/service_locator.dart';

class CharactersScreen extends StatefulWidget {
  static const String route = "/";

  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();
  late CharactersCubit _charactersCubit;

  _onListScrolled() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 100) {
      _charactersCubit.fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    _charactersCubit = sl()..fetchData();
    _scrollController.addListener(_onListScrolled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t('page.characters.title')),
      ),
      backgroundColor: const Color(0xFFe0e0e0),
      body: BlocProvider<CharactersCubit>(
        create: (_) => _charactersCubit,
        child: BlocConsumer<CharactersCubit, CharactersState>(
          listener: (context, state) {
            print('----------> state : $state');
            if (state is CharactersLoadFailed) {
              print(
                  '----------> failed : ${(state as CharactersLoadFailed).failure.message}');
            }
            print('----------> characters : ${state.characters.length}');
          },
          builder: (context, state) {
            if (state is CharactersLoading && state.characters.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final characters = state.characters;
            return ListView.builder(
                controller: _scrollController,
                itemCount:
                    characters.length + (state is CharactersLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.characters.length) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: SizedBox.fromSize(
                          size: const Size.square(36),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  return CharacterListItem(character: characters[index]);
                });
          },
        ),
      ),
    );
  }
}
