import 'package:flutter/material.dart';
import 'package:troca_book/tabs/Home_tab.dart';
import 'package:troca_book/tabs/favoritos_tab.dart';
import 'package:troca_book/tabs/minha_conta_tab.dart';
import 'package:troca_book/telas/CriarAnuncio_Page.dart';
import 'package:troca_book/tabs/meus_anuncios_tab.dart';
import 'package:troca_book/widgets/CustomDrawer.dart';

class Home_Page extends StatelessWidget {

  final _pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pagecontroller,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        //Página 0 - Tela de INICIO
        Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add,size: 40,color: Colors.black,),
            tooltip: "Criar anúncio",
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CriarAnuncioPage()));
            },

          ),
          drawer: CustomDrawer(_pagecontroller),
          body: Home_Tab(),
          appBar: AppBar(

            actions: <Widget>[
              IconButton(icon: Icon(Icons.search,color: Colors.black,size: 31,),onPressed: (){},)
            ],
          ),
        ),

        //Favoritos - 1
        Scaffold(
          drawer: CustomDrawer(_pagecontroller),
          appBar: AppBar(
            title: Text('Favoritos'),
          ),
          body: FavoritosTab(),
        ),

        //Meus Anuncios - 2
        Scaffold(
          drawer: CustomDrawer(_pagecontroller),
          appBar: AppBar(
            title: Text('Seus anúncios'),
          ),
          body: MeusAnuncios(),
        ),

        //Minha conta - 3
        Scaffold(
          drawer: CustomDrawer(_pagecontroller),
          appBar: AppBar(
            title: Text('Minha conta'),
          ),
          body: MinhaContaPage(),
        ),

      ],
    );
  }
}
