import 'package:flutter/material.dart';
import 'package:desafio_rick_morty/models/detailed_characters.dart';
import 'package:desafio_rick_morty/theme/app_colors.dart';

class DetailedCharacterCard extends StatelessWidget {
  const DetailedCharacterCard({required this.detailedCharacter,required this.firstAppearanceName, Key? key})
      : super(key: key);

  final DetailedCharacter detailedCharacter;
  final String firstAppearanceName;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            detailedCharacter.image,
            fit: BoxFit.cover,
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
                const SizedBox(height: 15),
                _buildInfoRow('Status', detailedCharacter.status),
                _buildInfoRow('Espécie', detailedCharacter.species),
                _buildInfoRow('Gênero', detailedCharacter.gender),
                _buildInfoRow('Origem', detailedCharacter.origin.name),
                _buildInfoRow('Última Localização', detailedCharacter.location.name),
                _buildInfoRow('Primeira aparição', firstAppearanceName),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}