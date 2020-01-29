import'package:flutter/material.dart';
import 'package:troca_book/Tiles/Anuncio_Tile.dart';

    class Home_Tab extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Stack(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.only(top: 40,bottom: 40),
              itemCount: 10,
              itemBuilder: (context,index){
                return AnuncioTile();
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
    }
