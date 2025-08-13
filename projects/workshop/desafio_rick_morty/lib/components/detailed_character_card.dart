import 'package:flutter/material.dart';
import 'package:desafio_rick_morty/data/favorites_manager.dart';
import 'package:desafio_rick_morty/models/detailed_characters.dart';
import 'package:desafio_rick_morty/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailedCharacterCard extends StatefulWidget {
  const DetailedCharacterCard({
    required this.detailedCharacter,
    required this.firstAppearanceName,
    Key? key,
  }) : super(key: key);

  final DetailedCharacter detailedCharacter;
  final String firstAppearanceName;

  @override
  _DetailedCharacterCardState createState() => _DetailedCharacterCardState();
}

class _DetailedCharacterCardState extends State<DetailedCharacterCard> {
  bool isFavorite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final favorite = await FavoritesManager.isFavorite(widget.detailedCharacter.id);
    setState(() {
      isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      isLoading = true;
    });

    final newFavoriteStatus = await FavoritesManager.toggleFavorite(widget.detailedCharacter);
    
    setState(() {
      isFavorite = newFavoriteStatus;
      isLoading = false;
    });

    // Mostrar feedback ao usuário
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite 
            ? '${widget.detailedCharacter.name} adicionado aos favoritos!'
            : '${widget.detailedCharacter.name} removido dos favoritos!',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: isFavorite ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 160, 
                child: Image.network(
                  widget.detailedCharacter.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: isLoading ? null : _toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 24,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.detailedCharacter.name.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14.5,
                  ),
                ),
                const SizedBox(height: 38),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: widget.detailedCharacter.status == 'Alive'
                            ? Colors.green
                            : Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${widget.detailedCharacter.status} - ${widget.detailedCharacter.species}',
                      style: GoogleFonts.lato(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                _DetailField(label: 'Gender:', value: widget.detailedCharacter.gender),
                const SizedBox(height: 15),
                _DetailField(
                  label: 'Origin:',
                  value: widget.detailedCharacter.origin.name,
                ),
                const SizedBox(height: 15),
                _DetailField(
                  label: 'Last know location:',
                  value: widget.detailedCharacter.location.name,
                ),
                const SizedBox(height: 15),
                _DetailField(
                  label: 'First seen in:',
                  value: widget.firstAppearanceName,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.label, required this.value, Key? key})
    : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            color: AppColors.white,
            fontWeight: FontWeight.w300,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.lato(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }
}
