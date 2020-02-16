import'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:troca_book/Tiles/Anuncio_Tile.dart';
import 'package:troca_book/models/createAnunciomodel.dart';
import 'package:troca_book/models/usermodel.dart';

    class Home_Tab extends StatefulWidget {

  @override
  _Home_TabState createState() => _Home_TabState();
}

class _Home_TabState extends State<Home_Tab> {


      int countF;

      Future<List> ListaAnuncios() async{
        var response = await ParseObject('Anuncios').getAll();
        var parseResponse = await response.results;
        return parseResponse;
      }

      @override
      Widget build(BuildContext context) {
        return FutureBuilder(
          future: ListaAnuncios(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            } else
            return Stack(
              children: <Widget>[
                ListView.builder(
                    padding: EdgeInsets.only(top: 40,bottom: 40),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,index){
                      return AnuncioTile(snapshot.data[index]);
                    }
                ),

                Container(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.black54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Local: Zona Oeste - RJ",style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                      ],
                    )
                ),
              ],
            );
          }
        );
      }

}
