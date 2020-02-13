
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {


  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);


  @override
  void addListener(listener) {
    super.addListener(listener);
    _currentuserload();
  }



  //Atributos
  ParseUser usuario;
  int error;
  String errorString = '';
  String erroCADASTRO= '';


  void RetornaErro() {

    if(error == null){
      notifyListeners();
      return null;
    }
    if (error == 200) {
      errorString = 'O e-mail está incorreto';
      notifyListeners();
    }
    if (error == 201) {
      errorString = 'A senha está incorreta';
      notifyListeners();
    }
    if (error == 202){
      erroCADASTRO = 'O e-mail já está sendo usado';
      notifyListeners();
    }
    if(error == 203){
      erroCADASTRO = 'O e-mail já está em uso';
      notifyListeners();
    }
    if(error == 204){
      errorString = 'Preencha o campo com um e-mail válido';
      notifyListeners();
    }
    if(error == 205){
      errorString = 'O e-mail especificado não foi encontrado';
      notifyListeners();
    }
    if(error == 206){
      errorString = 'Sessão inválida, faça login';
      notifyListeners();
    }
    if(error == 207){
      errorString = 'O usuário só pode ser criado quando cadastrado';
      notifyListeners();
    }
    if(error == 208){
      errorString = 'Esta conta já está sendo usada no momento';
      notifyListeners();
    }
    if(error == 209){
      errorString = 'O token de acesso já não é mais válido. Faça login novamente';
      notifyListeners();
    }
    if(error == 101){
      errorString = 'E-mail ou senha está incorreto';
      notifyListeners();
    }
    notifyListeners();
}


  //Autenticação do usuário
  Future<ParseUser> autenticacao({
  @required String username,
    @required String email,
    @required String pass,
    @required VoidCallback funcao,
  }) async {
      var user = ParseUser(username,pass,email);
      var response = await user.login();
      if(response.success){
        usuario = user;
        funcao();
        notifyListeners();
        error = null;
        errorString = '';
        return response.result;
      } else {
        notifyListeners();
        error = response.error.code;
        print("Erro: ${response.error}");
        RetornaErro();
      }

      notifyListeners();
      return null;
  }

  //Cadastro do usuário
  Future<ParseUser> cadastro({
  @required String username,
    @required String email,
    @required String pass,
    @required String cep,
    @required String celular,
    @required String nome,
    @required VoidCallback funcao,
  }) async{
    var user = ParseUser(username,pass,email)..set("Nome", nome,)..set("CEP", cep)..set("Celular", celular);
    var result = await user.create();
    if(result.success){
      usuario = user;
      funcao();
      notifyListeners();
      errorString = '';
      error = null;
      return user;
    } else {
      notifyListeners();
      error = result.error.code;
      RetornaErro();
      print("Error: ${result.error}");
    }
    notifyListeners();
    return null;
  }

  //Logoff do usuário
  void deslogar(context) {
        showDialog(
        context: context,
    builder: (context) =>
        AlertDialog(
          title: Text("Confirmar logout"),
          content: Text("Deseja mesmo sair da sua conta?"),
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancelar')
            ),
            FlatButton(
              onPressed: () async{
                var user = usuario;
                var response = await user.logout();
                if(response.success){
                  usuario = null;
                  notifyListeners();
                  Navigator.of(context).pop();
                  print('Usuario deslogado');
                }
              },
              child: Text("Sim"),
            )
          ],
        )
    ) ?? false;
  }

  //Usuario logado
  bool isLoggedinF(){
     return usuario != null;
  }

  //UsuarioAtual
  void _currentuserload() async {
    ParseUser cUser = await ParseUser.currentUser();
    if(cUser == null){
      return null;
    } else {
      usuario = cUser;
      cUser.login();
      notifyListeners();
    }

    notifyListeners();
  }

    //Dados adicionais
    Future<ParseUser> UserData (String nome,String nomeCompleto,String telefone,String CEP,String genero,int generoID) async{

    var user = usuario..set('Nome', nome.isEmpty || nome.startsWith(' ')? null: nome)..set('NomeCompleto', nomeCompleto.isEmpty || nomeCompleto.startsWith(' ') ? null : nomeCompleto)..set('Celular', telefone.isEmpty || telefone.startsWith(' ')? null:telefone)..set('CEP', CEP.isEmpty || CEP.startsWith(' ') ? null: CEP)..set('Genero', genero.isEmpty || genero.startsWith(' ')? null : genero)..set('generoID', generoID);
    var response = await user.update();

    if(response.success){
      notifyListeners();
      return user;
    } else{
      RetornaErro();
      print(response.error);
    }

    notifyListeners();
    }

    //Favoritos do usuário
    Future<ParseUser> UserFavorites(String objectID) async {
      var user = usuario..setAdd('Favoritos', objectID);
      var response = await user.update();
      if(response.success){
        notifyListeners();
      }
      notifyListeners();
    }


}