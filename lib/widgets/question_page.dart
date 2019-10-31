import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget{
  @override
  _QuestionPageState createState() {
    return _QuestionPageState();
  }

}
class _QuestionPageState extends State<QuestionPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 4,
        child: new Scaffold(
            appBar: new AppBar(
              backgroundColor:Colors.white,
              centerTitle: true,
              title: new Text('应聘小技巧',style: new TextStyle(fontSize: 20.0, color: Color.fromRGBO(0, 215, 198, 1))),
              bottom: new TabBar(
                isScrollable: true,
                labelColor: Color.fromRGBO(0, 215, 198, 1),
                unselectedLabelColor: Color.fromRGBO(145, 145, 145, 1),
                tabs: <Widget>[
                  new Tab(
                    text: '推荐动态',
                    icon: Icon(Icons.grade,size: 30,)
                  ),
                  new Tab(
                    text: '热榜话题',
                    icon: Icon(Icons.golf_course,size: 30,)
                  ),
                  new Tab(
                    text: '查看题库',
                    icon:Icon(Icons.question_answer,size: 30,)
                  ),
                  new Tab(
                    text: '发布动态',
                    icon:Icon(Icons.add_circle_outline,size: 30,)
                  ),
                ],
                controller: _tabController,
              ),
            ),
            body: new TabBarView(
              children: <Widget>[
                new Center(
                  child: _putInfo()
                ),
                new Center(
                  child: _hotTopic()
                ),
                new Center(
                  child: _question()
                ),
                new Center(
                  child: _issue()
                ),
              ],
            ),
        )
    );
  }

  //推荐动态
  Widget _putInfo(){
    return new Card(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width:30,
                margin: const EdgeInsets.all(10.0),
                child: new Image.network('https://ps.ssl.qhimg.com/t01c2def919778941fb.jpg'),
              ),
              new Text('面试小达人'),
              new DateTime(2019);
            ],
          )
        ],
      ),
    );
  }

  //热搜话题
  Widget _hotTopic(){
    return new ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context,int index){
        return new Column(
          children: <Widget>[
            new ListTile(
              leading: Icon(Icons.looks_one,color: Colors.redAccent,),
              title: Text('话题：30岁改行还来得及吗？'),
              trailing: Icon(Icons.arrow_upward,size: 15),
            ),
            new ListTile(
              leading: Icon(Icons.looks_two,color: Colors.redAccent),
              title: Text('话题：蜗居在一线城市的感受'),
              trailing: Icon(Icons.arrow_upward,size: 15),
            ),
            new ListTile(
              leading: Icon(Icons.looks_two,color: Colors.redAccent),
              title: Text('话题：第一份工作让你学到了什么'),
              trailing: Icon(Icons.arrow_upward,size: 15,),
            ),
          ],
        );
      },
    );
  }

  //查看题库
  Widget _question(){
    return new GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.only(top:20.0,left: 20.0,right: 20.0),
      //主轴间隔
      mainAxisSpacing: 20.0,
      //横轴间隔
      crossAxisSpacing: 10.0,
      children: <Widget>[
        new Container(
          child: new GridTile(
            child:Container(),
            header:  Column(
              children: <Widget>[
                new Icon(Icons.assignment_turned_in,size: 50,),
                new Text('面试宝典',style: TextStyle(fontSize: 18),)
              ],
            ),
          ),
        ),
        new Container(
          child: new GridTile(
            child:Container(),
            header:  Column(
              children: <Widget>[
                new Icon(Icons.assignment,size: 50,),
                new Text('笔试题库',style: TextStyle(fontSize: 18),)
              ],
            ),
          ),
        ),
        new Container(
          child: new GridTile(
            child:Container(),
            header:  Column(
              children: <Widget>[
                new Icon(Icons.collections_bookmark,size: 50,),
                new Text('公司套题',style: TextStyle(fontSize: 18),)
              ],
            ),
          ),
        ),
      ],
    );
  }

  //发布动态
  Widget _issue(){
    return new Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          new TextField(
            maxLines: 5,
            autofocus: false,
            decoration: InputDecoration(
              hintText: "说点什么吧,分享给大家！",
              hintMaxLines: 20,
              border: InputBorder.none,
            ),
            obscureText: false,
          ),
          new Row(
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.image),
                  onPressed: (){}
              ),
              new Text('插入图片')
            ],
          ),
          new MaterialButton(
            onPressed: (){},
            color: Colors.blueAccent,
            child: new Text('发布',style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}