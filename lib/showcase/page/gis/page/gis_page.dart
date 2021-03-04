
import 'dart:async';

import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frame_code/const_config.dart';
// import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
// import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';
import 'package:frame_code/frame/res/colors.dart';
import 'package:frame_code/frame/util/image_utils.dart';
import 'package:frame_code/frame/widgets/load_image.dart';
import 'package:frame_code/showcase/page/gis/page/real_data_page.dart';
import 'package:frame_code/showcase/page/gis/provider/gis_page_provider.dart';
import 'package:frame_code/showcase/page/gis/widgets/bubble_scale_transition.dart';
import 'package:frame_code/showcase/page/gis/widgets/top_bar_select_transition.dart';
import 'package:frame_code/showcase/page/main/provider/home_provider.dart';
import 'package:frame_code/showcase/utils/aqi_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司

class GISPage extends StatefulWidget {

  @override
  _GISPageState createState() => _GISPageState();
}

class _GISPageState extends State<GISPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  double _margin = 10;
  double maxMargin = 10;
  double _marginHeight = 50;
  double _alpha = 1;
  double _iconWidth = 48;
  final PageController _pageController = PageController();

  // BMFMapOptions mapOptions = BMFMapOptions(
  //     center: BMFCoordinate(39.917215, 116.380341),
  //     zoomLevel: 12,
  //     mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));

  AnimationController _bubbleAnimationController;
  Animation<double> animation;

  List<double> _topBorderPosition = [];

  List<Widget> _pageList;
  double _panelTopPadding = 20;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _requestLocaitonPermission();

    _pageList = [
      RealDataPage("实时AQI"),
      RealDataPage("历史趋势"),
      RealDataPage("监测数据"),
    ];

    _bubbleAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _bubbleAnimationController, curve: Curves.ease));


  }

  @override
  void reassemble() {
    super.reassemble();
    _requestLocaitonPermission();
  }

  void _requestLocaitonPermission() async {
    PermissionStatus status = await Permission.location.request();
    print('permissionStatus=====> $status');
  }

  var firstLocation = true;
  void _onLocationChanged(AMapLocation location) {
    if (null == location) {
      return;
    }
    print('_onLocationChanged ${location.toJson()}');
    if(firstLocation&&(location.latLng.latitude>10&&location.latLng.longitude>10)) {
      firstLocation = false;
      _changeCameraPosition(location.latLng,18);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      apiKey: ConstConfig.amapApiKeys,
      onMapCreated: onMapCreated,
      myLocationStyleOptions: MyLocationStyleOptions(
        true,
        circleFillColor: Color.fromARGB(80, 4, 168, 254),
        circleStrokeColor: Colors.blue,
        circleStrokeWidth: 1,
      ),
      onLocationChanged: _onLocationChanged,
    );



    double width = MediaQuery.of(context).size.width - 10;
    for(int i = 0 ; i < 7; i++) {
      _topBorderPosition.add(width*4*i/33);
    }
    _topBorderPosition.add(width - width*5/33);
    return
      SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).padding.top,
        minHeight: 150,
        renderPanelSheet: false,
        body: Container(
          child: Stack(
            children: [
              // BMFMapWidget(
              //   onBMFMapCreated: (controller) {
              //     onBMFMapCreated(controller);
              //   },
              //   mapOptions: mapOptions,
              // ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: map,
              ),
              Consumer<GISPageProvider>(
                builder: (_, provider, __) {
                  return SafeArea(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(5),
                            color: Colors.white70,
                            child: Stack(
                                children: [
                                  Row(
                                    children: _topSelectLists(provider),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: _topBorderPosition[provider.topBarType]),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xff0062ff),width: 2),
                                        ),
                                        height: 30,
                                        width: (MediaQuery.of(context).size.width-10)*(provider.topBarType == 7? 5:4)/33,
                                      ),
                                    ),
                                  )
                                ]
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 15, 5),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    provider.changeNameStatus();
                                  },
                                  child: LoadAssetImage(
                                    provider.getPointNameStatus ? 'gis/icon_show_name' : 'gis/icon_hide_name',
                                    width: _iconWidth,
                                  ),
                                ),
                                Text(''),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                },
                                  child: LoadAssetImage(
                                    'gis/icon_online', width: _iconWidth,),
                                ),
                                Text(
                                  '在线情况',
                                  style: TextStyle(
                                      fontSize: 10
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 15, 5),
                            child: Column(
                              children: [
                                LoadAssetImage(
                                  'gis/icon_real_data', width: _iconWidth,),
                                Text(
                                  '实时数据',
                                  style: TextStyle(
                                      fontSize: 10
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: BubbleScaleTransition(
                                    animation: animation,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 140,
                                          child: LoadAssetImage(
                                            'gis/dialog_bg_bubble',
                                            width: double.infinity,
                                            height: double.infinity,
                                            // height: 140,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 20, 20, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text('图例说明'),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  LoadAssetImage(
                                                    'gis/marker_online',
                                                    height: 16,),
                                                  Text('点位在线'),
                                                  SizedBox(width: 20,),
                                                  LoadAssetImage(
                                                    'gis/marker_offline',
                                                    height: 16,),
                                                  Text('点位离线'),
                                                ],
                                              ),
                                              LoadAssetImage(
                                                'gis/air_legend', height: 50,),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (_bubbleAnimationController
                                          .isCompleted) {
                                        _bubbleAnimationController.reverse();
                                      } else {
                                        _bubbleAnimationController.forward();
                                      }
                                    },
                                    child: LoadAssetImage(
                                      'gis/icon_legend',
                                      width: _iconWidth,
                                    )
                                ),
                                Text(''),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              )
            ],
          ),
        ),
        panel: Consumer<GISPageProvider>(
            builder: (_, provider, __) {
              return Container(
                child: Card(
                  margin: EdgeInsets.fromLTRB(_margin, 0, _margin, 0),
                  color: Color(0xffefefef),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                  ),
                  child: Container(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 190,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/home/home_top_bg.jpg',),
                                  fit: BoxFit.fill
                              ),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0,_panelTopPadding,0,20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '站点名称',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(flex: 1,),

                                      GestureDetector(
                                        onTap: () {
                                          Provider.of<HomeProvider>(context, listen: false).index = 0;
                                          // _pageController.jumpToPage(0);
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 24,
                                          child: Center(
                                            child: Text(
                                              '点位首页',
                                              style: TextStyle(
                                                  color: Colours.color_blue_main,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          '基本信息',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12
                                          ),
                                        ),
                                      ),
                                      Spacer(flex: 1,),
                                      Text(
                                        '2020/09/13 21:00',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 10,),
                                                Text(
                                                  'AQI',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 20,),
                                                Text(
                                                  '28',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 48
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '环境质量',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Container(
                                                  width: 70,
                                                  height: 20,
                                                  child: Center(
                                                    child: Text(
                                                      AqiUtils.getAQIGrade('785'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AqiUtils.getAQIColor('785'),
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  child: Text(
                                                    '首要污染物',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '--',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  child: Text(
                                                    '浓度值',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '--',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 80,),
                                                Text(
                                                  '--',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Card(
                                    elevation: 4,
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(200)),
                                    ),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              provider.setPositionDetailType(0);
                                              _pageController.jumpToPage(0);
                                            },
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(color: provider.detailType == 0 ?
                                                      Colours.color_blue_main : Colors.transparent,
                                                      width: 3),
                                                  )
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '实时AQI',
                                                  style: TextStyle(
                                                    color: provider.detailType == 0 ?
                                                      Colours.color_blue_main : Colors.grey,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              provider.setPositionDetailType(1);
                                              _pageController.jumpToPage(1);
                                            },
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(color: provider.detailType == 1 ?
                                                    Colours.color_blue_main : Colors.transparent,
                                                        width: 3),
                                                  )
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '历史趋势',
                                                  style: TextStyle(
                                                    color: provider.detailType == 1 ?
                                                      Colours.color_blue_main : Colors.grey,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              provider.setPositionDetailType(2);
                                              _pageController.jumpToPage(2);
                                            },
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(color: provider.detailType == 2 ?
                                                    Colours.color_blue_main : Colors.transparent,
                                                        width: 3),
                                                  )
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '监测数据',
                                                  style: TextStyle(
                                                    color: provider.detailType == 2 ?
                                                      Colours.color_blue_main : Colors.grey,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: PageView(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    controller: _pageController,
                                    onPageChanged: (int index) => provider.setPositionDetailType(index),
                                    children: _pageList,
                                  )
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              );
            }
        ),
        onPanelSlide: (position) {
          setState(() {
            _panelTopPadding = 20 + (MediaQuery.of(context).padding.top - 20)*position;
            _margin = (1-2*position)<0?0:(1-2*position)*maxMargin;
            _alpha = position;
          });
        },
    );
  }

  ///百度地图UI隐藏效果
  Widget _item(double height, double alpha) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: height),
      child: Opacity(
        opacity: alpha,
        child: Column(
          children: [
            LoadAssetImage('/login/logo',width: 30),
            Text('gis'),
          ],
        ),
      ),
    );
  }

  List<Widget> _topSelectLists(GISPageProvider provider) {
    List<Widget> _list = [];
    List<String> _grade = ['全部','优','良','轻度污染','中度污染','重度污染','严重污染','有效性不足'];
    List<Color> _bgColor = [Colours.color_blue_light  ,Colours.color_1,Colours.color_2,Colours.color_3,
      Colours.color_4,Colours.color_5,Colours.color_6,Colours.color_0];
    for(int i =0 ;i< _grade.length; i++) {
      _list.add(
        Expanded(
          flex: i==7 ? 5 : 4,
          child: Center(
            child: GestureDetector(
              onTap: () {
                provider.setTopBarType(i);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0,8,0,8),
                color: _bgColor[i],
                child: Center(
                  child: Text(
                    _grade[i],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      );
    }
    return _list;
  }



  void _changeCameraPosition(LatLng latLng, double zoom) {
    _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          //中心点
            target: latLng,
            //缩放级别
            zoom: zoom,
            //俯仰角0°~45°（垂直与地图时为0）
            tilt: 30,
            //偏航角 0~360° (正北方为0)
            bearing: 0),
      ),
      animated: true,
    );
  }

  AMapController _mapController;
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
