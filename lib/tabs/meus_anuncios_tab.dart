
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:troca_book/Tiles/meu_anuncio_tile.dart';
import 'package:troca_book/models/usermodel.dart';

class MeusAnuncios extends StatefulWidget {



  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {

  Future<List> getinfoFromUser() async{
    var response = await ParseObject('_User').getObject(UserModel.of(context).usuario.objectId);
    var results = await response.result['Anuncios'];

    List asd = List();

    for(final Anuncio in results){
      var an = await ParseObject('Anuncios').getObject(Anuncio);
      var addonlist = await an.result;
      asd.add(addonlist);
    }
     return asd;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getinfoFromUser(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data.length == 0){
            return Center(child: Text("Você ainda não tem nenhum anúncio publicado"),);
          }
          return Center(child: CircularProgressIndicator(),);
        }

          return ListView.builder(
              itemCount: snapshot.data.length = null ? 0 : snapshot.data.length,
              itemBuilder: (context,index){
                return MeuAnuncioTile(snapshot.data[index]);
              }
          );


      }
    );
  }
}
