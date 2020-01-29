import 'package:flutter/material.dart';
import 'package:troca_book/telas/Produto_page.dart';
import 'package:troca_book/telas/editar_anuncio_screen.dart';

class MeuAnuncioTile extends StatefulWidget {
  @override
  _MeuAnuncioTileState createState() => _MeuAnuncioTileState();
}


class _MeuAnuncioTileState extends State<MeuAnuncioTile> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProdutoPage()));
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
                        image: DecorationImage(image: NetworkImage('https://1.bp.blogspot.com/-FzTH3PVFUYM/WwbX-P89w6I/AAAAAAAALhU/1Gar07_XnmgmGIBMY9L_R6fmPFfGRtWkACLcBGAs/s1600/jordanpeterson-750.jpg',),fit: BoxFit.cover)),
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

                        Text("12 regras para a vidas",overflow: TextOverflow.ellipsis,
                          maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                        Text("Autor: Jordan Peterson",style: TextStyle(fontStyle: FontStyle.italic),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        RichText(text: TextSpan(text: 'Aceita trocar:',style: TextStyle(color: Colors.black),children: [TextSpan(text: ' Sim',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))]),),
                        Text("R\$ 50",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        Text("Estado: Bem conservado"),
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
                  showDialog(
                      context: (context),
                    child: AlertDialog(
                      title: Text('Tem certeza ?'),
                      content: Text("Deseja excluir o anúncio? Não é possível desfazer"),

                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){
                            showDialog(
                                context: (context),
                              child: AlertDialog(
                                content: Text("Tem mesmo certeza ??",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                actions: <Widget>[
                                  FlatButton(
                                    textColor: Colors.black,
                                    onPressed: (){},
                                    child: Text('Excluir anúncio'),
                                  ),
                                  FlatButton(
                                    textColor: Colors.black,
                                    onPressed: (){
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancelar"),
                                  )
                                ],
                                backgroundColor: Colors.redAccent,
                              )
                            );
                          },
                          child: Text("Excluir"),

                        ),
                        FlatButton(
                          child: Text('Cancelar'),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  );
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
