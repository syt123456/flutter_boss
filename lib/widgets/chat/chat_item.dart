import 'package:flutter/material.dart';


class ChatItem extends StatelessWidget{
  final IconData icon;
  final String title;
  final String subTitle;
  final Color color;
  var onPressed;

  ChatItem({Key key, this.icon,this.color,this.title,this.subTitle, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          ListTile(
            leading:new Icon(icon,color: color,size: 40,),
            title:new Text(title,style: TextStyle(fontSize: 18.0),),
            subtitle: new Text(subTitle,style: TextStyle(fontSize: 14.0),),
          ),
          Divider(height:10.0,indent:0.0,color: Colors.grey,),
        ],
      )
    );
  }


}