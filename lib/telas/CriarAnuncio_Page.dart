import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:troca_book/Tiles/Images_criar_anuncio_tile.dart';
import 'package:troca_book/models/createAnunciomodel.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:troca_book/tabs/meus_anuncios_tab.dart';
import 'package:troca_book/telas/Home_page.dart';



class CriarAnuncioPage extends StatefulWidget {


  @override
  _CriarAnuncioPageState createState() => _CriarAnuncioPageState();
}

class _CriarAnuncioPageState extends State<CriarAnuncioPage> {
    @override
    void initState(){
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_){
        ListaCat();
      });
    }

  ////BOOL////
  bool isSwitched = false;
  bool switchtelefone = false;

  ////LISTAS////

  List<File> _ListaDeImagens = List<File>();
  List _Categorias = [];
  var _opcoes = ['Condição do item','Novo', 'Marcas de uso', 'Desgastado', 'Bem conservado','Bem usado'];

  ////VARIAVEIS////

  File _cropedImage;
  String padrao = "Categoria";
  String padraozada = 'Condição do item';
  int _radiovalue = 1;
  String erroString = ' ';

  //Controladores
  final tituloController = TextEditingController();
  final precocontroller = TextEditingController();
  final descricaocontroller = TextEditingController();
  final autorcontroller =  TextEditingController();
  final FormStateKey = GlobalKey<FormState>();


  //Função das imagens
  Future getImage() async{

     ImagePicker.pickImage(source: ImageSource.gallery).then((f)async{
      File cropedFile = await ImageCropper.cropImage(
        sourcePath: f.path,
        aspectRatioPresets:[
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: "Recortar imagem",
          lockAspectRatio: true,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.1,
        ),
      );

      setState(() {
          _cropedImage = cropedFile;
      });

      if(cropedFile == null){
        return null;
      } else{
        _ListaDeImagens.add(_cropedImage);
      }


     }
    );

  }


 //Menu das categorias
  Future<QueryBuilder> ListaCat()async{

    final QueryBuilder queryBuilder = QueryBuilder<ParseObject>(ParseObject('categoriaDoItem'))..orderByAscending("categoria");

    final ParseResponse parseResponse = await queryBuilder.query();

    if(parseResponse.success && parseResponse.results.isNotEmpty){
      for(final categoria in parseResponse.results){
        setState(() {
          _Categorias.add(categoria['categoria']);
        });
    }
  }

  }


  //Função dos botões RADIO
  void _handleradiovalue(int value){
    setState(() {
      _radiovalue = value;
    });
      switch(_radiovalue){
        case 0:
          print("Sim");
          break;
        case 1: print("Não");
        break;
      }
  }


  //Confirmar saida da página
  Future<bool> _onwillpop(){
    return showDialog(context: context,
        builder: (context)=> AlertDialog(
          title: Text("Tem certeza ?"),
          content: Text("Você está prestes a perder o anúncio"),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop(false);
            },
            child: Text('Continuar'),),
            FlatButton(onPressed: (){
              Navigator.of(context).pop(true);
            },
            child: Text('Sair'),)
          ],
        )) ?? false;
  }


  //handleParseFile
    List<ParseFile> parsefiles = List<ParseFile>();

    Future<ParseFile> handle() async{

      for(final img in _ListaDeImagens){
        parsefiles.add(ParseFile(img.absolute)['IMG']);
      }
    }

  @override
  Widget build(BuildContext context) {
      handle();

    print(parsefiles);

    void sucesso(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home_Page()));
    }

      //Exibe container do autor
    Widget customcontainer() => (

        Container(
          margin: EdgeInsets.only(left: 15,right: 15,top: 15),
          height: 60,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Center(
            child: TextFormField(
              controller: autorcontroller,
              autovalidate: true,
              validator: (text){
                if(isSwitched == true && text.isEmpty){
                  return 'Insira o nome do autor';
                }
              },
              maxLength: 50,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: 'Escreva o autor',
              ),
            ),
          ),
        )
    );

    return new WillPopScope(
      onWillPop: _onwillpop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Criar Anúncio'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              onPressed: (){},
            ),
          ],
        ),
        body: Form(
          key: FormStateKey,
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: AspectRatio(
                  aspectRatio: 2.3,
                  child: ListView.builder(
                    itemCount: _ListaDeImagens.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                         return GestureDetector(
                             child: ImagesAnunTile(_ListaDeImagens[index]),
                           onTap: (){
                               setState(() {
                                 _ListaDeImagens.removeAt(index);
                               });

                           },
                         );
                      }
                  )
                )
              ),
              InkWell(
                onTap: (){
                  getImage();
                },
                child: Container(color: Colors.blue,height: 70,
                  margin: EdgeInsets.only(bottom: 15),
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Carregar imagens',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),),
                    Text("(Clique na imagem para excluir)",style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 8),)
                  ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Center(
                  child: TextFormField(
                    validator: (text){
                      if(text.isEmpty){
                        return 'Insira um título';
                      }
                    },
                    maxLength: 65,
                    controller: tituloController,
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Título do anúncio (MÁX 65 CARAC.)',
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
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Aceita trocar ?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  Text('Sim'),
                  Radio(
                    value: 0,
                    groupValue: _radiovalue,
                    onChanged: _handleradiovalue,

                  ),
                  Text('Não'),
                  Radio(
                    value: 1,
                    groupValue: _radiovalue,
                    onChanged: _handleradiovalue,
                  ),
                ],
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('R\$',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                Expanded(
                  child: TextFormField(
                    controller: precocontroller,
                    validator: (text){
                      if(text.isEmpty){
                        return 'Insira um preço';
                      }
                    },
                    maxLength: 65,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true),

                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                padding: EdgeInsets.only(left: 15,right: 15),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Categoria',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        DropdownButton(
                          items: _Categorias.map((categorias){
                            return DropdownMenuItem(
                              value: categorias,
                              child: Text(categorias),
                            );
                          }).toList(),
                          onChanged: (novoValor){
                            if(novoValor == "Categoria"){

                            } else {
                              setState(() {
                                this.padrao = novoValor;
                              });

                            }
                          },
                          value:padrao,
                        )
                      ],
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                padding: EdgeInsets.only(left: 15,right: 15),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Condição',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        DropdownButton<String>(
                          items: _opcoes.map((String dropdowlistitem){
                            return DropdownMenuItem<String>(
                              value: dropdowlistitem,
                              child: Text(dropdowlistitem),
                            );
                          }).toList(),
                          onChanged: (String newvalue){
                            if(newvalue == "Condição do item"){
                            } else {
                              setState(() {
                                this.padraozada = newvalue;
                              });
                              print(newvalue);
                            }
                          },
                          value: padraozada,
                        ),
                      ],
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                padding: EdgeInsets.only(left: 15,right: 15),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Incluir o autor',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        Switch(
                          value: isSwitched,
                          onChanged: (value){
                            setState(() {
                              isSwitched = value;
                              if(value == false){
                                autorcontroller.clear();
                              }
                            });
                          },
                          activeTrackColor: Colors.grey,
                          activeColor: Colors.yellow,

                        )
                      ],
                    )
                ),
              ),
              Container(
                child: isSwitched ? customcontainer() : Container(),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                padding: EdgeInsets.only(left: 15,right: 15),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Mostrar telefone',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        Switch(
                          value: switchtelefone,
                          onChanged: (value){
                            setState(() {
                              switchtelefone = value;
                            });
                          },
                          activeTrackColor: Colors.grey,
                          activeColor: Colors.yellow,

                        )
                      ],
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15,bottom: 15, top: 15),
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: TextField(
                  controller: descricaocontroller,
                  scrollPhysics: ScrollPhysics(),
                  maxLines: 7,
                  maxLength: 420,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: 'Descrição',
                  ),
                ),
              ),
              Text(erroString,style: TextStyle(color: Colors.red),textAlign: TextAlign.center,),
              Container(
                margin: EdgeInsets.all(15),
                height: 60,
                child: RaisedButton(
                  onPressed: (){
                      handle().then((f){
                        print(f);
                        if(FormStateKey.currentState.validate() && padrao != 'Categoria' && padraozada != 'Condição do item'){
                          AnuncioModel.of(context).CriarAnuncio(tituloController.text, _radiovalue, padrao, padraozada, autorcontroller.text, switchtelefone, descricaocontroller.text,precocontroller.text,sucesso,parsefiles);
                        }
                        if(padrao == 'Categoria' || padraozada == 'Condição do item'){
                          setState(() {
                            erroString = 'Selecione a categoria e condição do item';
                          });
                        }
                      });
                  },
                  elevation: 0.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Text("Anunciar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
