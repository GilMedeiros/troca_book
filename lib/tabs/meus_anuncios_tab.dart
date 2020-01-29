import 'package:flutter/material.dart';
import 'package:troca_book/Tiles/meu_anuncio_tile.dart';
class MeusAnuncios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

        itemCount: 2,
        itemBuilder: (context,index){
          return MeuAnuncioTile();
        }
    );
  }
}
