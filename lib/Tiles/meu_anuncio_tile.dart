import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:troca_book/models/usermodel.dart';
import 'package:troca_book/telas/Produto_page.dart';
import 'package:troca_book/telas/confirma_excluir.dart';
import 'package:troca_book/telas/editar_anuncio_screen.dart';

class MeuAnuncioTile extends StatefulWidget {

  final snapshot;
  MeuAnuncioTile(this.snapshot);

  @override
  _MeuAnuncioTileState createState() => _MeuAnuncioTileState(snapshot);
}


class _MeuAnuncioTileState extends State<MeuAnuncioTile> {

  final snapshot;

  _MeuAnuncioTileState(this.snapshot);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProdutoPage(snapshot)));
          },
          child: Container(
            margin: EdgeInsets.only(top: 15,right: 5,left: 5),
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black54,offset: Offset(0, 0),blurRadius: 5)
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1/1,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4),topLeft: Radius.circular(4)),
                        image: DecorationImage(image: NetworkImage(json.decode(snapshot['images'].toString())[0]['url']),fit: BoxFit.cover)),),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[

                        Text(snapshot['Titulo'],overflow: TextOverflow.ellipsis,
                          maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                        Text("Autor: ${snapshot['Autor']}",style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        RichText(text: TextSpan(text: 'Aceita trocar:',style: TextStyle(color: Colors.black),children: [TextSpan(text: ' ${snapshot['Troca'] == 1 ? 'Não': 'Sim'}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))]),),
                        Text("R\$ ${snapshot['Preco']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        Text("Estado: ${snapshot['Condicao']}"),
                        Text("Barra da Tijuca, 10 de Janeiro 18:09",style: TextStyle(color: Colors.grey,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(left: 5,right: 5,top: 5),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            boxShadow: [
              BoxShadow(
                offset: Offset(2,1),
                blurRadius: 2,
                color: Colors.grey
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditarAnuncioPage()));
                  },
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Text("Editar"),
                    Icon(Icons.mode_edit,color: Colors.white,)
                  ],
                ),
              ),
              FlatButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmaExcluirPage(snapshot)));
                  },
                textColor: Colors.white,
                child: Row(
                  children: <Widget>[
                    Text("Excluir"),
                    Icon(Icons.delete_forever,color: Colors.white,)
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
