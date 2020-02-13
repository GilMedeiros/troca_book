
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


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }

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
      List<File> imgList,
      ) async {
      List<ParseFile> imagem = List<ParseFile>();
      for (final img in imgList){
        imagem.add(ParseFile(img,name: 'IMAGEM'));
      }
      var Anuncio = ParseObject('Anuncios')..set('UserID', user.usuario.objectId)
        ..set('Titulo', Titulo)..set('Troca', Trocar)
        ..set('Preco', preco)..set('Categoria', Categoria)
        ..set('Condicao', Condicao)..set('Autor', autor)
        ..set('MostraTelefone', mostrartelefone)
        ..set('Descricao', descicao)..setAddAll('images', imagem)..set('Anunciante', user.usuario['Nome'])..set('Telefone', user.usuario['Celular']);

      var response = await Anuncio.save();
      if(response.success){
        funcao();
      }

  }
//  Future<int> getLengthAnuncios() async{
//    QueryBuilder<ParseObject> queryBuilder =
//    QueryBuilder<ParseObject>(ParseObject('Anuncios'));
//    var response = await queryBuilder.count();
//    if(response.success && response.result != null){
//      int count = response.count;
//      countF = count;
//      print(count);
//      notifyListeners();
//
//    }
//    notifyListeners();
//  }
  
//  Future<QueryBuilder> ListaAnuncios() async{
//    final QueryBuilder queryBuilder = QueryBuilder<ParseObject>(ParseObject('Anuncios'))..orderByAscending('createdAt');
//    final ParseResponse parseResponse = await queryBuilder.query();
//    if(parseResponse.success && parseResponse.result != null){
//      int countAnuncio = parseResponse.count;
//      countF == countAnuncio;
//      print(countAnuncio);
//      notifyListeners();
//    }
//    notifyListeners();
//
//  }


}