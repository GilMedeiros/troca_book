import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:troca_book/models/usermodel.dart';

class HandleInfo extends Model{

  HandleInfo(this.user){
    if(user.isLoggedinF());
  }

  static HandleInfo of(BuildContext context) =>
      ScopedModel.of<HandleInfo>(context);



  UserModel user;


}