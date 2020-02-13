import 'dart:io';
import 'dart:ui';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:troca_book/models/usermodel.dart';
import 'dart:convert';

class ProdutoPage extends StatefulWidget {

  final snapshot;
  ProdutoPage(this.snapshot);

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {


  Future<ParseResponse> getinfoFromUser() async{
    var response = await ParseObject('_User').getObject(widget.snapshot['UserID']);
    setState(() {
      telefone = response.result['Celular'];
    });
    return response;
  }

  String telefone = " ";

  Future images() async {
    var img = widget.snapshot['images'];
    var jsoni = json.decode(img.toString());
    for (var imgs in jsoni) {
      couserlImg.add(imgs['url']);
    }
  }
  List couserlImg = List();
  @override
  void initState() {
    images();
    getinfoFromUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.grey[200],
          child: Text("Anúncio publicado em 10 de Janeiro 18:09",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w300),textAlign: TextAlign.center,)
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: (){
            UserModel.of(context).UserFavorites('j');
          }),
        ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black54,offset: Offset(0,4),blurRadius:2 )
                  ]),
              child: AspectRatio(
                aspectRatio: 1.1,
                child: Carousel(
                  boxFit: BoxFit.contain,
                  images: couserlImg.map((url){
                    return NetworkImage(url);
                  }).toList(),
                  dotSize: 5.0,
                  dotSpacing: 15.0,
                  autoplay: false,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.white,
                  dotIncreasedColor: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(widget.snapshot['Titulo'],style: TextStyle(fontSize: 24,fontWeight: FontWeight.w300),),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 15,bottom: 5),
                child: Text("R\$ ${widget.snapshot['Preco']}",style: TextStyle(fontSize: 22,color: Colors.black),),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 15,bottom: 5),
                child: Text("Aceita troca: ${widget.snapshot['Troca'] == 1 ? 'Não': 'Sim'}",style: TextStyle(fontSize: 18,color: Colors.black),),
              ),
            ),
            Divider(thickness: 0.7,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 15,bottom: 5),
                child: Text("Descrição",style: TextStyle(fontSize: 15,color: Colors.black54),),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                child: Text(widget.snapshot['Descricao'],style: TextStyle(fontSize: 17,color: Colors.black),maxLines: 10,),
              ),
            ),
            Divider(thickness: 0.8),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 15),
              padding: EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.grey[200],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: Text('Contato',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                  Divider(thickness: 0.8,),
                  Text("Anunciante: ${widget.snapshot['Anunciante']}",style: TextStyle(fontWeight: FontWeight.w300),),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      Text('Telefone: ',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.black)),
                      InkWell(child: Text(widget.snapshot['MostraTelefone'] == true ?  telefone: 'O usuário resolveu não mostrar o telefone',style: TextStyle(color: Colors.blueAccent,decoration: TextDecoration.underline)),)
                    ],
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      onPressed: (){

                      },
                      elevation: 0.0,

                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text("Chat",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ),
                  SizedBox(height: 05,),
                  Divider(thickness: 0.8,),
                  InkWell(
                    child: Text("Ver outros anúncios deste usuário",style: TextStyle(fontWeight: FontWeight.bold),
                    ),onTap: (){},),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
