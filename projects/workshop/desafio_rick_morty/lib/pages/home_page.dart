import 'package:flutter/material.dart';
import 'package:desafio_rick_morty/components/app_bar_component.dart';
import 'package:desafio_rick_morty/components/character_card.dart';
import 'package:desafio_rick_morty/data/repository.dart';
import 'package:desafio_rick_morty/models/paginated_characters.dart';
import 'package:desafio_rick_morty/pages/details_page.dart';
import 'package:desafio_rick_morty/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PaginatedCharacter>? characters;

  @override
  initState() {
    characters = Repository.getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: characters,
        builder: (context, AsyncSnapshot<PaginatedCharacter> snapshot) {
          if (snapshot.hasData) {
            final dataResults = snapshot.data!.results;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 7.5),
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: dataResults[index],
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DetailsPage.routeId,
                      arguments: dataResults[index].id,
                    );
                  },
                );
              },
              itemCount: dataResults.length,
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