import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:troca_book/models/usermodel.dart';

class AnuncioModel extends Model{

  AnuncioModel(this.user){
    if(user.isLoggedinF());
  }

  static AnuncioModel of(BuildContext context) =>
      ScopedModel.of<AnuncioModel>(context);

    UserModel user;

  Future<ParseObject> CriarAnuncio(
      String Titulo,
      int Trocar,
      String Categoria,
      String Condicao,
      String autor,
      bool mostrartelefone,
      String descicao,
      String preco,
      VoidCallback funcao,
      List<ParseFile> imagem
      ) async {

      var Anuncio = ParseObject('Anuncios')..set('ID', user.usuario.objectId)
        ..set('Titulo', Titulo)..set('Troca', Trocar)
        ..set('Preco', preco)..set('Categoria', Categoria)
        ..set('Condicao', Condicao)..set('Autor', autor)
        ..set('MostraTelefone', mostrartelefone)
        ..set('Descricao', descicao)
        ..set<List<ParseFile>>('Images', imagem);
      var response = await Anuncio.save();
      if(response.success){
        funcao();
        response.results.first;
      }

  }

}