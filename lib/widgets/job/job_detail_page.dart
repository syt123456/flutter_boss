import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boss/common/config/config.dart';
import 'package:flutter_boss/model/job.dart';
import 'package:flutter_boss/model/job_detail.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class JobDetailPage extends StatefulWidget{
  final Job job;
  final int index;

  JobDetailPage({Key key,@required this.job,@required this.index});
  JobDetailPageState createState() => new JobDetailPageState();
}

class JobDetailPageState extends State<JobDetailPage>{
  ScrollController _scrollController;
  WebViewController _webViewController;
  String _title = "webview";
  int index;

  Future<List<JobDetail>> _fetchJob() async {
    final response = await http.get('${Config.BASE_URL}/test/job/list_detail');
    List<JobDetail> jobDetailList = List<JobDetail>();
    if (response.statusCode == 200) {
      List<dynamic> result = json.decode(response.body);
      for (dynamic data in result) {
        JobDetail jobDetailData = JobDetail.fromJson(data);
        jobDetailList.add(jobDetailData);
      }
    }
    return jobDetailList;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: BoxDecoration(

            ),
            child: _jobdetail(context),
          ),
        )
    );
  }

  Widget _jobdetail(BuildContext context){
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            new SliverAppBar(
              elevation: 0.0,
              pinned: true,
              centerTitle: false,
              title: new Text(
                widget.job.company,
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.star_border,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            SliverList(
                delegate: new SliverChildListDelegate(<Widget>[
                  new Row(
                    children: [
                      new Expanded(
                        flex: 3,
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Padding(
                              padding: const EdgeInsets.only(
                                top: 20.0,
                                left: 25.0,
                                bottom: 10.0,
                              ),
                              child: new Text(
                                '${widget.job.title}',
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.only(
                                top: 35.0,
                                left: 105.0,
                                bottom: 10.0,
                              ),
                              child: new Text(
                                '${widget.job.salary}',
                                style: new TextStyle(
                                    color: Colors.green, fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List<JobDetail>>(
                    future: _fetchJob(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(widget.job.id);
                        index = int.parse(widget.job.id);
                        return _jobBody(context, snapshot,index);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ])
            ),
          ],
        ),
      ],
    );
  }

  Widget _jobBody(BuildContext context, AsyncSnapshot snapshot, int index){
    index = int.parse(widget.job.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 25.0, bottom: 20.0),
          child: Text(
            "职位详情",
            style: new TextStyle(color: Colors.blueGrey, fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.0, bottom: 10.0, right: 25.0),
          child: Text(
            snapshot.data[index-1].context,
            textAlign: TextAlign.justify,
            style: new TextStyle(color: Colors.blueGrey, fontSize: 16.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 25.0, bottom: 10.0),
          child: Text(
            "工作地点："+snapshot.data[index-1].address,
            style: new TextStyle(color: Colors.blueGrey, fontSize: 20.0),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 0.0, bottom: 50.0),
          height: 120.0,
          child: GestureDetector(
//            child:Image.network(
//                "http://api.map.baidu.com/staticimage?width=400&height=300&zoom=11&center="+snapshot.data[index-1].address,
//            ),
//          onTap:(){
//            dituView(snapshot);
//           }
            child: WebView(
              initialUrl: " http://api.map.baidu.com/geocoder?address="+snapshot.data[index-1].address+"&output=html",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController){
                _webViewController = webViewController;
              },
              onPageFinished: (url) {
                _webViewController.evaluateJavascript("document.").then((result){
                  _title = result;
                });
              },
              navigationDelegate: (NavigationRequest request) {
                if(request.url.startsWith("myapp://")) {
                  print("即将打开 ${request.url}");
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              } ,
              javascriptChannels: <JavascriptChannel>[
                JavascriptChannel(
                    name: "share",
                    onMessageReceived: (JavascriptMessage message) {
                      print("参数： ${message.message}");
                    }
                ),
              ].toSet(),
            ),
          )
        ),
        Container(
          padding: const EdgeInsets.only(right: 15),
          alignment: Alignment.bottomRight,
          child:FloatingActionButton(
            onPressed: (){},
            foregroundColor: Colors.greenAccent,
            child: Text('申请',style: TextStyle(color: Colors.white,fontSize: 18 )),
          )
        )
      ],
    );
  }

  Widget dituView(AsyncSnapshot snapshot){
    print("地图");
    return WebView(
      initialUrl: "http://api.map.baidu.com/geocoder?address="+snapshot.data[index-1].address+"&output=html",
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController){
        _webViewController = webViewController;
        
      },
      onPageFinished: (url) {
        _webViewController.evaluateJavascript("document.").then((result){
          _title = result;
        });
      },
      navigationDelegate: (NavigationRequest request) {
        if(request.url.startsWith("myapp://")) {
          print("即将打开 ${request.url}");
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      } ,
      javascriptChannels: <JavascriptChannel>[
        JavascriptChannel(
            name: "share",
            onMessageReceived: (JavascriptMessage message) {
              print("参数： ${message.message}");
            }
        ),
      ].toSet(),
    );
  }

  void callJS(){

  }


}