import 'dart:async';

import 'package:flutter/material.dart';
import 'chat/chat_item.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: new Text('聊天',
            style: new TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
      body: new Container(
        padding: const EdgeInsets.only(left: 20.0,top: 10.0),
        child: new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ChatItem(
              icon:Icons.add_circle,
              color: Colors.deepOrangeAccent,
              title: 'XXX发布了新职位',
              subTitle: '超过100位Boss新发布',),
            new ChatItem(
              icon:Icons.remove_red_eye,
              color: Colors.blueAccent,
              title: 'XXX查看了您'
              ,subTitle: '10位Boss查看',),
            new ChatItem(
              icon:Icons.notifications,
              color: Colors.greenAccent,
              title: 'XXX发布了新职位',
              subTitle: '超过100位Boss新发布',),
          ],
        ),
      ),
    );
  }
}
