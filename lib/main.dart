import 'package:flutter/material.dart';
import 'package:marvel_characters/presentation/marvel_characters_app.dart';
import 'package:marvel_characters/service_locator.dart';

void main() async {
  await initSL();
  runApp(const MarvelCharactersApp());
}
