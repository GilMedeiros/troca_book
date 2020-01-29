import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:troca_book/models/usermodel.dart';
import 'package:troca_book/telas/Home_page.dart';

class CadastroPage extends StatefulWidget {

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final email = TextEditingController();

  final senha = TextEditingController();

  final nome = TextEditingController();

  final cep = TextEditingController();

  final celular = TextEditingController();

  final senhaConfirma = TextEditingController();

  final FormKey = GlobalKey<FormState>();

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
            appBar: AppBar(
              actions: <Widget>[
                IconButton(icon: Icon(Icons.info_outline),
                  onPressed: (){},)
              ],
              title: Text('Troca Book'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: 150),
              child: Form(
                key: FormKey,
                child: Column(
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
                        child: TextFormField(
                          validator: (text){
                            if(text.isEmpty || text.length < 2){
                              return 'Por favor digite seu nome';
                            }
                          },
                          controller: nome,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10,right: 10),
                              hintText: "Nome*",
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
                        child: TextFormField(
                          validator: (text){
                            if(!text.contains('@') || text.isEmpty)
                              return 'Insira um e-mail válido';
                          },
                          controller: email,
                          keyboardType: TextInputType.emailAddress ,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10,right: 10),
                              hintText: "E-mail*",
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
                        child: TextFormField(
                          maxLength: 11,
                          controller: celular,
                          keyboardType: TextInputType.number ,
                          decoration: InputDecoration(
                            counterText: ' ',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10,right: 10),
                              hintText: "Celular",
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
                        child: TextFormField(
                          validator: (text){
                            if(text.length < 8)
                              return "Sua senha precisa ter no mínimo 8 caracteres";
                          },
                          controller: senha,
                          obscureText: true,
                          decoration: InputDecoration(
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10,right: 10),
                              hintText: "Senha*",
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
                        child: TextFormField(
                          autovalidate: true,
                          validator: (text){
                            if(senha.text != text){
                              return 'As senhas não conferem';
                            }
                          },
                          controller: senhaConfirma,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10,right: 10),
                              hintText: "Confirma sua senha*",
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic
                              )
                          ),
                        ),
                      ),
                    ),
                    Text(model.erroCADASTRO,style: TextStyle(color: Colors.red),),
                    SizedBox(height: 15,),
                    FlatButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Criar conta"),
                      onPressed: (){
                        if(FormKey.currentState.validate()){
                          UserModel.of(context).cadastro(username: email.text, email: email.text, pass: senha.text, cep: cep.text, celular: celular.text, nome: nome.text,funcao: sucesso);
                        } else {

                        }

                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

  }
}
