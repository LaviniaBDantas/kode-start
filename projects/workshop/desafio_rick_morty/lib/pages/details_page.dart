import 'package:flutter/material.dart';
import 'package:desafio_rick_morty/components/app_bar_component.dart';
import 'package:desafio_rick_morty/components/detailed_character_card.dart';
import 'package:desafio_rick_morty/data/repository.dart';
import 'package:desafio_rick_morty/models/detailed_characters.dart';
import 'package:desafio_rick_morty/theme/app_colors.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({required this.characterId, Key? key}) : super(key: key);

  final int characterId;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<DetailedCharacter>? detailedCharacter;

  @override
  initState() {
    detailedCharacter = Repository.getCharacterDetails(widget.characterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context, isSecondPage: true),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: detailedCharacter,
        builder: (context, AsyncSnapshot<DetailedCharacter> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              children: [
                DetailedCharacterCard(detailedCharacter: data),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro.",
                style: TextStyle(color: AppColors.white),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}