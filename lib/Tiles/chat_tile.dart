import 'package:flutter/material.dart';

class Chat_tile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white30,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300],
                offset: Offset(2,2)
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage('https://cdn3.iconfinder.com/data/icons/social-messaging-productivity-6/128/profile-male-circle2-512.png'),
            backgroundColor: Colors.transparent,
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 8),
                    child: Text("Gil",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10),
                    child: Text("Eu posso bucar hoje com você o livroaio djadjioa sdjioasji odjaisodjioas doias odiasoi dasi ",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey[700]),),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
