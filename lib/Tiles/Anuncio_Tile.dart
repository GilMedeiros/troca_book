import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:troca_book/telas/Produto_page.dart';

class AnuncioTile extends StatelessWidget {

  final snaptshot;
  AnuncioTile(this.snaptshot);

//  Future images() async {
//    var img = snaptshot['images'];
//    var jsoni = json.decode(img.toString());
//    print(jsoni[0]['url']);
//  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProdutoPage(snaptshot)));
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
                image: DecorationImage(image: NetworkImage(json.decode(snaptshot['images'].toString())[0]['url']),fit: BoxFit.cover)),
              ),
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

                    Text(snaptshot['Titulo'],overflow: TextOverflow.ellipsis,
                      maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                    Text("Autor: ${snaptshot['Autor']}",style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    RichText(text: TextSpan(text: 'Aceita trocar:',style: TextStyle(color: Colors.black),children: [TextSpan(text: ' ${snaptshot['Troca'] == 1 ? 'Não': 'Sim'}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))]),),
                    Text("R\$ ${snaptshot['Preco']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    Text("Estado: ${snaptshot['Condicao']}"),
                    Text("Barra da Tijuca, 10 de Janeiro 18:09",style: TextStyle(color: Colors.grey,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
