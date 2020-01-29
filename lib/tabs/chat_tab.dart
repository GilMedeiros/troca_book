import 'package:flutter/material.dart';
import 'package:troca_book/Tiles/chat_tile.dart';

class Chat_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Chat'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.only(top: 10,bottom: 10),
          itemCount: 2,
          itemBuilder: (context, index){
          return Chat_tile();
          }
      ),
    );
  }
}
