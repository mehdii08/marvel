import 'package:flutter/material.dart';
import 'package:flutter_i18next/i18next.dart';

class CharacterDetailsScreen extends StatefulWidget {
  static const route = "/character/:character_id/details";
  const CharacterDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t('page.characters.title')),),
    );
  }
}
