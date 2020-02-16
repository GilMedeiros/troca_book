import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:troca_book/models/createAnunciomodel.dart';
import 'package:troca_book/models/usermodel.dart';
import 'package:troca_book/telas/Home_page.dart';


const String PARSE_APP_ID = 'roZfbV28kg0UeohGwxHks6OiY4jma3OB89Yjt2s9';

const String PARSE_APP_URL = 'https://parseapi.back4app.com';

const String MASTER_KEY = 'Ji9EmDwmXWPUUZRSb6uBwpPhMIblvu0PRjs6dRx8';

const String LIVE_QUERY_URL = 'trocabook.back4app.io';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Parse().initialize(
    PARSE_APP_ID,
    PARSE_APP_URL,
    masterKey: MASTER_KEY,
    liveQueryUrl: LIVE_QUERY_URL,
    autoSendSessionId: true,
    debug: true,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );
  runApp(
      ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(builder: (context,child,model){
          return ScopedModel<AnuncioModel>(
            model: AnuncioModel(model),
            child:MyApp(),
          );
        },)
      )
  );

}


class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 241, 89),
      ),
      debugShowCheckedModeBanner: false,
      home: Home_Page(),
    );
  }

}
