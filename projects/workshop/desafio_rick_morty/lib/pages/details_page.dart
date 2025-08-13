import 'package:flutter/material.dart';
import 'package:desafio_rick_morty/components/app_bar_component.dart';
import 'package:desafio_rick_morty/components/detailed_character_card.dart';
import 'package:desafio_rick_morty/data/repository.dart';
import 'package:desafio_rick_morty/theme/app_colors.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({required this.characterId, Key? key}) : super(key: key);

  final int characterId;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<Map<String, dynamic>>? data;

  @override
  initState() {
    data = _fetchCharacterAndEpisodeData();
    super.initState();
  }

  Future<Map<String, dynamic>> _fetchCharacterAndEpisodeData() async {
    final detailedCharacter = await Repository.getCharacterDetails(
      widget.characterId,
    );
    final episodeUrl = detailedCharacter.episode.first;
    final episode = await Repository.getEpisodeDetails(episodeUrl);
    return {
      'detailedCharacter': detailedCharacter,
      'firstAppearanceName': episode.name,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context, isSecondPage: true),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              children: [
                DetailedCharacterCard(
                  detailedCharacter: data['detailedCharacter'],
                  firstAppearanceName: data['firstAppearanceName'],
                ),
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