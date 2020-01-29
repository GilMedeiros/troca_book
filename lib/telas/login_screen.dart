import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:troca_book/models/usermodel.dart';
import 'package:troca_book/telas/Home_page.dart';
import 'package:troca_book/telas/cadastro_page.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();

  final senha = TextEditingController();


  @override
  Widget build(BuildContext context) {

    void sucesso(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home_Page()));
    }
    return ScopedModelDescendant<UserModel>(
      builder: (context,child,model){
        return SafeArea(
          right: true,
          child: Scaffold(
            resizeToAvoidBottomPadding: true,
            appBar: AppBar(

              actions: <Widget>[
                IconButton(icon: Icon(Icons.info_outline),
                  onPressed: (){},)
              ],
              title: Text('Troca Book'),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                  padding: EdgeInsets.only(left: 15,right: 15),
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:  Center(
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress ,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10,right: 10),
                          hintText: "E-mail",
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                  padding: EdgeInsets.only(left: 15,right: 15),
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child:  Center(
                    child: TextField(
                      controller: senha,
                      obscureText: true,
                      decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10,right: 10),
                          hintText: "Senha",
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic
                          )
                      ),
                    ),
                  ),
                ),
                Text(model.errorString,style: TextStyle(color: Colors.red),),
                InkWell(child: Text("Esqueci minha senha"),),
                SizedBox(height: 15,),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Entrar"),
                  onPressed: (){
                      UserModel.of(context).autenticacao(username: email.text, email: email.text, pass: senha.text,funcao: sucesso);
                      },
                ),
                Divider(),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("Crie uma conta"),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadastroPage()));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
