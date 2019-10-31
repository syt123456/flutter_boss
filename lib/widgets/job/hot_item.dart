import 'package:flutter/material.dart';

class HotItem extends StatelessWidget{
  final IconData iconData;
  final String text;
  final Color color;
  final VoidCallback onPressed;
//  HotItem({Key key,this._iconData,this._text,this.onPressed}):super(key:key);
  HotItem({Key key, this.iconData, this.text,this.color, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 80,
      margin: const EdgeInsets.only(left: 10),
      decoration: new BoxDecoration(
        border: new Border.all(width: 2,color: color),
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      child:new GestureDetector(
        onTap: onPressed,
        child: Column(
          children: <Widget>[
            new Padding(
              padding:const EdgeInsets.only(bottom: 10.0),
              child:new Icon(iconData,color: color,size: 35,),
            ),
            new Text(text,style: TextStyle(color: Colors.blueGrey,fontSize: 16)),
          ],
        ),
      ),
    );
  }

}