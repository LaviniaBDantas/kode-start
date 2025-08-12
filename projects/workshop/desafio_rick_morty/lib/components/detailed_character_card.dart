import 'package:flutter/material.dart';
import 'package:desafio_rick_morty/models/detailed_characters.dart';
import 'package:desafio_rick_morty/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailedCharacterCard extends StatelessWidget {
  const DetailedCharacterCard({
    required this.detailedCharacter,
    required this.firstAppearanceName,
    Key? key,
  }) : super(key: key);

  final DetailedCharacter detailedCharacter;
  final String firstAppearanceName;

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
          SizedBox(
            width: double.infinity,
            height: 160, 
            child: Image.network(
              detailedCharacter.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailedCharacter.name.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 38),
                // Exibe o status com o indicador e a espécie
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: detailedCharacter.status == 'Alive'
                            ? Colors.green
                            : Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${detailedCharacter.status} - ${detailedCharacter.species}',
                      style: GoogleFonts.lato(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                _DetailField(label: 'Gender:', value: detailedCharacter.gender),
                const SizedBox(height: 15),
                _DetailField(
                  label: 'Origin:',
                  value: detailedCharacter.origin.name,
                ),
                const SizedBox(height: 15),
                _DetailField(
                  label: 'Last know location:',
                  value: detailedCharacter.location.name,
                ),
                const SizedBox(height: 15),
                _DetailField(
                  label: 'First seen in:',
                  value: firstAppearanceName,
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
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.lato(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
