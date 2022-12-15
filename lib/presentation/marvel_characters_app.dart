import 'package:flutter/material.dart';
import 'package:flutter_i18next/i18next_delegate.dart';
import 'package:flutter_i18next/loaders/file_translation_loader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:marvel_characters/presentation/pages/character_details_screen.dart';
import 'package:marvel_characters/presentation/pages/characters_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: CharactersScreen.route,
      builder: (context, state) => const CharactersScreen(),
    ),
    GoRoute(
      path: CharacterDetailsScreen.route,
      builder: (context, state) =>
          const CharacterDetailsScreen(/*state.params['userId']*/),
    ),
  ],
  debugLogDiagnostics: true,
);

const faLocale = Locale('en');

class MarvelCharactersApp extends StatelessWidget {
  const MarvelCharactersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      supportedLocales: const [
        faLocale,
      ],
      locale: faLocale,
      localizationsDelegates: [
        I18NextDelegate(
          translationLoader: FileTranslationLoader(
            useCountryCode: false,
            basePath: 'i18n',
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
