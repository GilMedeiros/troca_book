import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:troca_book/models/usermodel.dart';

class MinhaContaPage extends StatefulWidget {
  @override
  _MinhaContaTabState createState() => _MinhaContaTabState();
}

class _MinhaContaTabState extends State<MinhaContaPage> {
  //Variaveis
  int _radiovalue;
  String genero = '';
  int generoID;

  //Função dos botões RADIO
  void _handleradiovalue(int value) {
    setState(() {
      _radiovalue = value;
    });

    switch (_radiovalue) {
      case 0:
        setState(() {
          genero = 'Feminino';
          generoID = 0;
        });
        break;
      case 1:
        setState(() {
          genero = 'Masculino';
          generoID = 1;
        });
        break;
      case 2:
        setState(() {
          genero = 'Não informar';
          generoID = 2;
        });
        break;
    }
  }

  //Controllers
  final primeironome = TextEditingController();
  final nomecompleto = TextEditingController();
  final telefone = TextEditingController();
  final cep = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var user = UserModel.of(context).usuario;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Dados da conta",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 35, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text('Nome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ))),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: TextFormField(
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp(r"[A-zÀ-ÿ ]")),
                  ],
                  autovalidate: true,
                  validator: (text){
                    if(text.startsWith(' ')){
                      return 'Não pode iniciar com um espaço, digite um nome';
                    }
                  },
                  controller: primeironome,
                  maxLength: 30,

                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                    hintText: user == null ? ' ': user['Nome'],
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 35, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text('Nome completo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ))),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: TextFormField(
                  controller: nomecompleto,
                  maxLength: 65,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp(r"[A-zÀ-ÿ ]")),
                  ],
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: user == null ? ' ': user['NomeCompleto'],
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 35, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text('Celular',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ))),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: TextField(
                  controller: telefone,
                  maxLength: 11,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: user == null ? ' ': user['Celular'],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Gênero',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: _radiovalue,
                        onChanged: _handleradiovalue,
                      ),
                      Text('Feminino'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: _radiovalue,
                        onChanged: _handleradiovalue,
                      ),
                      Text('Masculino'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 2,
                        groupValue: _radiovalue,
                        onChanged: _handleradiovalue,
                      ),
                      Text("Não informar"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 35, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text('Cep',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ))),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: TextFormField(
                  controller: cep,
                  maxLength: 8,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: user == null ? ' ': user['CEP'],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: RaisedButton(
                onPressed: () {
                  UserModel.of(context).UserData(
                      primeironome.text,
                      nomecompleto.text,
                      telefone.text,
                      cep.text,
                      genero,
                      generoID,
                      );
                },
                elevation: 0.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Salvar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Text(UserModel.of(context).errorString, style: TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {

    if(UserModel.of(context).usuario == null){

      return null;
    } else {
      int id = UserModel.of(context).usuario['generoID'];
      setState(() {
        _radiovalue = id;
      });
    }

  }
}
