import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:troca_book/Tiles/DrawerTile.dart';
import 'package:troca_book/models/usermodel.dart';
import 'package:troca_book/tabs/chat_tab.dart';
import 'package:troca_book/telas/login_screen.dart';

class CustomDrawer extends StatelessWidget {

  CustomDrawer(this.pageController);
  final PageController pageController;


  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: ScopedModelDescendant<UserModel>(
        builder: (context,child,model) {
          return Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 241, 89),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0,5)
                          )
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15,right: 15),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage('https://i.ya-webdesign.com/images/avatar-icon-png-6.png')),
                                    shape: BoxShape.circle
                                ),
                              ),
                              Text(model.isLoggedinF() ? 'Olá, ${model.usuario['Nome']}' :'Faça login ou \ncrie sua conta',style: TextStyle(fontSize: 17),),
                              ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chat_page()));
                              },
                              child: Stack(
                                children: <Widget>[
                                  IconButton(icon: Icon(Icons.chat,color: Colors.black,),
                                  ),
                                  Positioned(
                                    right: 1,
                                    bottom: 5,
                                    child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black87,
                                        ),
                                        child: Center(
                                          child: Text("1",style: TextStyle(color: Colors.white),),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                            IconButton(icon: Icon(Icons.settings),),
                            InkWell(
                              child: Text(model.isLoggedinF() ? 'Sair':'Login',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              onTap: (){
                                      if(model.isLoggedinF()){
                                        model.deslogar(context);
                                      } else{
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                                      }
                              },
                            )
                            //IconButton(icon: Icon(Icons.exit_to_app),onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));},),
                          ],
                        )
                      ],
                    ),
                  ),
                  DrawerTile(pageController,"Início",0),
                  DrawerTile(pageController,'Favoritos',1),
                  DrawerTile(pageController,'Meus Anúncios',2),
                  DrawerTile(pageController,'Minha conta',3),
                ],
              )

          );
        },
      ),
    );
  }
}
