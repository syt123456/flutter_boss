import 'package:flutter/material.dart';
import 'package:flutter_boss/widgets/mine/contact_item.dart';
import 'package:flutter_boss/widgets/mine/menu_item.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>  with AutomaticKeepAliveClientMixin<MinePage> {
  final double _appBarHeight = 180.0;
  final String _userHead =
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571713795133&di=d4a179da93384a873bcc9cafa9947fbf&imgtype=0&src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201909%2F08%2F20190908195051_bxyyq.jpg';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color.fromARGB(255, 242, 242, 245),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _appBarHeight,
            flexibleSpace: new FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, -0.4),
                        colors: const <Color>[
                          const Color(0x00000000),
                          const Color(0x00000000)
                        ],
                      ),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Expanded(
                        flex: 3,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Padding(
                              padding: const EdgeInsets.only(
                                top: 30.0,
                                left: 30.0,
                                bottom: 15.0,
                              ),
                              child: new Text(
                                'Star Her',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35.0),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                left: 30.0,
                              ),
                              child: new Text(
                                '找工作中',
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Expanded(
                        flex: 1,
                        child: new Padding(
                          padding: const EdgeInsets.only(top: 40.0, right: 30.0,),
                          child: new CircleAvatar(
                            radius: 35.0,
                            backgroundImage: new NetworkImage(_userHead),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                new Container(
                  color: Colors.white,
                  child: new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new ContactItem(
                          count: '69',
                          title: '沟通过',
                        ),
                        new ContactItem(
                          count: '10',
                          title: '面试',
                        ),
                        new ContactItem(
                          count: '37',
                          title: '已投递',
                        ),
                        new ContactItem(
                          count: '53',
                          title: '感兴趣',
                        ),
                      ],
                    ),
                  ),
                ),
                new Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      new MenuItem(
                        icon: Icons.print,
                        title: '我的微简历',
                      ),
                      new MenuItem(
                        icon: Icons.archive,
                        title: '简历附件',
                      ),
                      new MenuItem(
                        icon: Icons.home,
                        title: '管理求职意向',
                      ),
                      new MenuItem(
                        icon: Icons.assessment,
                        title: '我的动态',
                      ),
                      new MenuItem(
                        icon: Icons.security,
                        title: '隐私设置',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
