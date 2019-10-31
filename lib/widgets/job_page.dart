import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_boss/common/config/config.dart';
import 'package:flutter_boss/model/job.dart';
import 'package:flutter_boss/widgets/job/job_item.dart';
import 'job/job_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'job/hot_item.dart';

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> with AutomaticKeepAliveClientMixin {

  List<String> imgs = [];
  int index;

  //获取职位列表数据
  List<Job> jobList = List<Job>();
  Future<List<Job>> _fetchJobList() async {
    final response = await http.get('${Config.BASE_URL}/test/job/list');
    List<Job> jobList = List<Job>();
    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body);
      for (dynamic data in result) {
        Job jobData = Job.fromJson(data);
        jobList.add(jobData);
      }
    }
    return jobList;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.gps_fixed), onPressed: (){},alignment: Alignment.centerLeft,),
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),
      body:new CustomScrollView(
          slivers:<Widget>[
            new SliverList(
              delegate: new SliverChildListDelegate(
                <Widget>[
                  new Container(
                    child: Row(
                      children: <Widget>[
//                        new EditableText(controller: null, focusNode: null, style: null, cursorColor: null, backgroundCursorColor: null)
                      ],
                    ),
                  ),
                  new Container(
                    height: 200.0,
                    child: new Swiper(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        imgs.add("http://hbimg.b0.upaiyun.com/5220cd923972b7b809c4272b8f08cc22487e378424c9d-uhUTjy_fw658");
                        imgs.add("http://ku.90sjimg.com/back_pic/05/04/72/9159620ab0e4167.jpg");
                        imgs.add("http://img.zcool.cn/community/014b9958d0f201a801219c7768b197.png@900w_1l_2o_100sh.jpg");
                        return Container(
                          margin: const EdgeInsets.only(top:10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      imgs[index]),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        );
                      },
                      pagination: SwiperPagination( // 分页指示器
                          alignment: Alignment.bottomCenter,// 位置 Alignment.bottomCenter 底部中间
                          margin: const EdgeInsets.only(top: 30), // 距离调整
                          builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.greenAccent,
                            color: Colors.blueGrey,
                            size: 10,
                            activeSize: 20,
                            space: 10,
                          )),
                      //                  control: new SwiperControl(),
                      scrollDirection: Axis.horizontal,
                      autoplay: true,
                      viewportFraction: 0.8,// 当前视窗展示比例 小于1可见上一个和下一个视窗
                      scale: 0.8, // 两张图片之间的间隔
                      onTap: (index) {
                        print('点击了第$index个');
                      },
                    ),
                  ),
                  new Container(
                    padding:const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(left: 15),
                    child: new Row(
                      children: <Widget>[
                        new HotItem(
                          iconData:Icons.hourglass_full,
                          text:"好福利" ,
                          color: Colors.blue,
                        ),
                        new HotItem(
                          iconData:Icons.monetization_on ,
                          text:"高薪资" ,
                          color: Colors.green,
                        ),
                        new HotItem(
                          iconData:Icons.gps_fixed ,
                          text:"看附近" ,
                          color: Colors.orange,
                        ),
                        new HotItem(
                          iconData:Icons.school,
                          text:"选校招" ,
                          color: Colors.pink,
                        )
                      ],
                    ),
                  ),
                  new Container(
                    child:new FutureBuilder(
                      future: _fetchJobList(),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          default:
                            if (snapshot.hasError)
                              return new Text('Error: ${snapshot.error}');
                            else
                              return _createListView(context, snapshot);
                        }
                      },
                    ),
                  )

                ],
              ) ,
            )
          ]
        )
    );
  }

  //职位列表显示
  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Job> jobList = snapshot.data;
    return ListView.builder(
      shrinkWrap: true,
      key: new PageStorageKey('job-list'),
      itemCount: jobList.length,
      itemBuilder: (BuildContext context, int index) {
        return new JobItem(
           onPressed: () {
             Navigator.push(
               context,
               MaterialPageRoute(
                  builder: (context) => JobDetailPage(
                    job: jobList[index],index: index,
                  )
               )
             );
           },
           job: jobList[index]
         );
      },
    );
  }
}

