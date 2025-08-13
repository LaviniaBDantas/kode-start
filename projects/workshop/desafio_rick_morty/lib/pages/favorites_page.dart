import 'package:flutter/material.dart';
import 'package:desafio_rick_morty/components/app_bar_component.dart';
import 'package:desafio_rick_morty/components/character_card.dart';
import 'package:desafio_rick_morty/data/favorites_manager.dart';
import 'package:desafio_rick_morty/models/detailed_characters.dart';
import 'package:desafio_rick_morty/models/paginated_characters.dart';
import 'package:desafio_rick_morty/theme/app_colors.dart';
import 'package:desafio_rick_morty/pages/details_page.dart';

class FavoritesPage extends StatefulWidget {
  static const routeId = '/favorites';
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<List<DetailedCharacter>>? favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      favoritesFuture = FavoritesManager.loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context, isSecondPage: true),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<List<DetailedCharacter>>(
        future: favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar favoritos",
                style: TextStyle(color: AppColors.white),
              ),
            );
          }
          
          final favorites = snapshot.data ?? [];
          
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: AppColors.white.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Nenhum favorito ainda",
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Adicione personagens aos favoritos na tela de detalhes",
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.5),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 7.5),
            itemBuilder: (context, index) {
              final detailedCharacter = favorites[index];
              final character = Character(
                id: detailedCharacter.id,
                name: detailedCharacter.name,
                image: detailedCharacter.image,
              );
              
              return CharacterCard(
                character: character,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    DetailsPage.routeId,
                    arguments: detailedCharacter.id,
                  ).then((_) {
                    _loadFavorites();
                  });
                },
              );
            },
            itemCount: favorites.length,
          );
        },
      ),
    );
  }
}
