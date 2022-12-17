import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18next/i18next.dart';
import 'package:go_router/go_router.dart';
import 'package:marvel_characters/core/app_colors.dart';
import 'package:marvel_characters/core/errors/failures.dart';
import 'package:marvel_characters/presentation/blocs/characters_list/characters_cubit.dart';
import 'package:marvel_characters/presentation/blocs/characters_list/characters_state.dart';
import 'package:marvel_characters/presentation/pages/character_details_screen.dart';
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
  bool showingErrorDialog = false;

  _onListScrolled() {
    if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100 &&
        !showingErrorDialog) {
      _charactersCubit.fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    _charactersCubit = sl()..fetchData();
    _scrollController.addListener(_onListScrolled);
  }

  showErrorDialog(Failure failure) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)), //this right here
      child: SizedBox(
        height: 200.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                failure.messageIsKey
                    ? context.t(failure.message!)
                    : failure.message!,
                style: const TextStyle(color: AppColors.red),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showingErrorDialog = false;
                  _charactersCubit.fetchData();
                },
                child: Text(
                  context.t('errors.try_again'),
                  style:
                      const TextStyle(color: AppColors.black, fontSize: 18.0),
                ))
          ],
        ),
      ),
    );
    showingErrorDialog = true;
    showDialog(
        context: context,
        builder: (BuildContext context) => errorDialog,
        barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t('page.characters.title')),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocProvider<CharactersCubit>(
        create: (_) => _charactersCubit,
        child: BlocConsumer<CharactersCubit, CharactersState>(
          listener: (context, state) {
            if (state is CharactersLoadFailed) {
              showErrorDialog(state.failure);
            }
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
                  return CharacterListItem(
                    character: characters[index],
                    onTap: (character) {
                      context.push(
                          CharacterDetailsScreen.generateRoute(character.id),
                          extra: character);
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
