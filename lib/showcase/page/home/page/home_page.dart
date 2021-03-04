import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frame_code/frame/util/image_utils.dart';
import 'package:frame_code/frame/widgets/load_image.dart';
import 'package:frame_code/frame/res/colors.dart';
import 'package:frame_code/showcase/utils/aqi_utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// 作者： 付雨
/// 创建时间： 2020/9/7
/// 版权： 江苏远大信息股份有限公司
/// 首页

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: _headSliverBuilder,
        body: SingleChildScrollView(
          child: _body(context),
        )
      ),
    );
  }

  /// 标题栏
  List<Widget> _headSliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget> [
      SliverAppBar(
          elevation: 4,
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 5),
                  child: LoadAssetImage('home/icon_lists',width: 24,)
              ),
              SizedBox(width: 10,),
              Flexible(
                  flex: 1,
                  child: Text("通州监测站(国)")
              ),
            ],
          ),
          backgroundColor: Theme.of(context).accentColor,
          expandedHeight: 120.0,
          floating: false,
          pinned: true,
          snap: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            background: Stack(
              children: [
                LoadAssetImage('home/home_top_bg',
                  format: ImageFormat.jpg,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,),
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: 56),
                    width: double.infinity,
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "32",
                              style: TextStyle(
                                  fontSize: 48,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              children: [
                                Text(
                                  "O",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "晴",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,

                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              LoadAssetImage('home/icon_wind',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,),
                              Text(
                                "2级别",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(width: 20,),
                              LoadAssetImage('home/icon_humidity',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,),
                              Text(
                                "41%",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                print("更多");
              },
            ),
          ]
      )
    ];
  }

  Widget _body(BuildContext context) {
    return Container(
      color: Color(0xffefefef),
      child: Column(
        children: [
          _aqiModel(context),
          _factorTrend(context),
          _goodDaysStatistics(context),
          _aqiAddUp(context),
        ],
      )
    );
  }

  /// aqi模块+考核目标
  Widget _aqiModel(BuildContext context){
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    ImageUtils.getImgPath('home/icon_ring'),
                    width: 16,
                    color: Colours.color_blue_main,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "AQI指数",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colours.color_blue_main,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                "2020-88-88 88:88",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "78",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AqiUtils.getAQIColor('78')
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 24,
                            child: Center(
                              child: Text(
                                AqiUtils.getAQIGrade('78'),
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: AqiUtils.getAQIColor('78'),
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: Colours.color_blue_light,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(child: Text('首要污染物', style: TextStyle(color: Colors.white),),),
                                    Center(child: Text('浓度值', style: TextStyle(color: Colors.white),),),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Color(0xffc3e9fd), width: 1),
                                    left: BorderSide(color: Color(0xffc3e9fd), width: 1),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(child: Text('PM2.5', style: TextStyle(color: Colors.black),),),
                                    Center(child: Text('57', style: TextStyle(color: Colors.black),),),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Color(0xffc3e9fd), width: 1),
                                    left: BorderSide(color: Color(0xffc3e9fd), width: 1),
                                    bottom: BorderSide(color: Color(0xffc3e9fd), width: 1),
                                    top: BorderSide(color: Color(0xffc3e9fd), width: 1)
                                  ),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(child: Text('--', style: TextStyle(color: Colors.black),),),
                                    Center(child: Text('--', style: TextStyle(color: Colors.black),),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                      child: LoadAssetImage("home/icon_calendar",width: 48,)
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('空气质量日历'),
                                      Text('点击查看日历', style: TextStyle(color: Colors.grey, fontSize: 12),),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],


                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    '单位：CO单位mg/m³，其他ug/m³',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                    ),
                  ),
                ],
              ),
              Container(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _barItem("PM2.5", '57', '70'),
                    _barItem("PM10", '98', '150'),
                    _barItem("O3", '169', '100'),
                    _barItem("NO2", '26', '60'),
                    _barItem("SO2", '12', '40'),
                    _barItem("CO", '1.2', '2'),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Image.asset(
                    ImageUtils.getImgPath('home/icon_ring'),
                    width: 16,
                    color: Colours.color_blue_main,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "考核目标",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colours.color_blue_main,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(flex: 1,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    color: Colours.color_blue_light,
                    child: Container(
                      width: 70,
                      height: 30,
                      child: Center(
                        child: Text(
                          '历史',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _checkBadge(true),
                  _checkBadge(false),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ///AQI指数-柱状
  Widget _barItem(String name, String value, String maxValue){
    return Container(
      height: 150,
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Text(
            value,
            style: TextStyle(
              color: Colours.color_blue_main
            ),
          ),
          Container(
            width: 20,
            height: double.parse(value)/double.parse(maxValue)>1
                ?100:100*double.parse(value)/double.parse(maxValue),
            decoration: BoxDecoration(
              color: Colours.color_blue_main,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              color: Colors.grey
            ),
          )
        ],
      ),
    );
  }

  ///考核目标-徽章
  Widget _checkBadge(bool isGood) {
    return Stack(
      children: [
        LoadAssetImage(isGood? 'home/pic_badge_good':'home/pic_badge_bad',width: 100,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                    '达标'
                ),
              ),
            ),
            Container(
              width: 100,
              child: Center(
                child: Text(
                    '年管控目标',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey
                  ),
                ),
              ),
            ),
            Container(
              width: 100,
              child: Center(
                child: Text(
                    '88.8/88.8',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.red
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 9),
              width: 100,
              child: Center(
                child: Text(
                    'PM2.5',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  ///最近24小时趋势
  Widget _factorTrend(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Row(
            children: [
              Image.asset(
                ImageUtils.getImgPath('home/icon_ring'),
                width: 16,
                color: Colours.color_blue_main,
              ),
              SizedBox(width: 10),
              Text(
                "最近24小时趋势",
                style: TextStyle(
                  fontSize: 18,
                  color: Colours.color_blue_main,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(flex: 1,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                color: Colours.color_blue_light,
                child: Container(
                  width: 70,
                  height: 30,
                  child: Center(
                    child: Text(
                      '还原',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '最近24小时',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colours.color_blue_main
                        ),
                      ),
                      Text(
                        '最近30天',
                        style: TextStyle(
                          fontSize: 16
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 15,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: double.infinity,
                            height: 2,
                            color: Color(0xffd0dada),
                          ),
                        ),
                        Center(
                          widthFactor: 1.3,
                          child: Card(
                            color: Colours.color_blue_main,
                            child: Container(
                              width: 120,
                              height: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                      height: 200,
                      child:getBar()
                  ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 15,
                      padding: EdgeInsets.all(5),
                      crossAxisCount: 4,
                      childAspectRatio: 2.0,
                      children: _singleSelectFactorWidgets(),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );

  }

  ///柱状图
  Widget getBar() {
    List<Barsales> dataBar = [
      new Barsales("08-09", 20),
      new Barsales("08-10", 50),
      new Barsales("08-11", 20),
      new Barsales("08-12", 80),
      new Barsales("08-13", 120),
      new Barsales("08-14", 30),
      new Barsales("08-15", 0),
      new Barsales("08-16", 12),
      new Barsales("08-17", 67),
      new Barsales("08-18", 20),
      new Barsales("08-19", 50),
      new Barsales("08-20", 20),
      new Barsales("08-21", 80),
      new Barsales("08-22", 120),
      new Barsales("08-23", 30),
      new Barsales("08-24", 0),
      new Barsales("08-25", 12),
      new Barsales("08-26", 67),
      new Barsales("08-27", 20),
      new Barsales("08-28", 50),
      new Barsales("08-29", 20),
    ];

    var seriesBar = [
      charts.Series(
        data: dataBar,
        domainFn: (Barsales sales, _) => sales.data,
        measureFn: (Barsales sales, _) => sales.value,
        labelAccessorFn: (Barsales sales,_) => sales.value.toString(),
        id: "trend",
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      )
    ];
    return charts.BarChart(
      seriesBar,
      animate: true,
      behaviors: [
        charts.PanAndZoomBehavior(),
        charts.SlidingViewport(),
        charts.SlidingViewport(),
      ],
      // barGroupingType: charts.BarGroupingType.stacked,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        showAxisLine: true,
        renderSpec: charts.GridlineRendererSpec(
          tickLengthPx: 0, // 刻度标识突出的长度
          // labelOffsetFromAxisPx: 12, // 刻度文字距离轴线的位移
          labelStyle: charts.TextStyleSpec(
            // 刻度文字的样式
            color: charts.Color.fromHex(code: '#000000'),
          ),
          axisLineStyle: charts.LineStyleSpec(
            // 轴线的样式
            color: charts.Color.fromHex(code: '#000000'),
          ),
          lineStyle: charts.LineStyleSpec(
            // 轴线的样式
            color: charts.Color.transparent,
          ),
        ),
      ),
      domainAxis: new charts.OrdinalAxisSpec(

        viewport: new charts.OrdinalViewport('08-09', 7),
        tickFormatterSpec: charts.BasicOrdinalTickFormatterSpec(),
        renderSpec: charts.SmallTickRendererSpec(
          // 主轴绘制的配置
          tickLengthPx: 0, // 刻度标识突出的长度
          // labelOffsetFromAxisPx: 32, // 刻度文字距离轴线的位移
          labelStyle: charts.TextStyleSpec(
            // 刻度文字的样式
            color: charts.Color.fromHex(code: '#000000'),
          ),
          axisLineStyle: charts.LineStyleSpec(
            // 轴线的样式
            color: charts.Color.fromHex(code: '#000000'),
          ),
        ),
      ),
    );
  }

  ///优良天数统计
  Widget _goodDaysStatistics(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Row(
            children: [
              Image.asset(
                ImageUtils.getImgPath('home/icon_ring'),
                width: 16,
                color: Colours.color_blue_main,
              ),
              SizedBox(width: 10),
              Text(
                "优良天数统计",
                style: TextStyle(
                  fontSize: 18,
                  color: Colours.color_blue_main,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(flex: 1,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                color: Colours.color_blue_light,
                child: Container(
                  width: 70,
                  height: 30,
                  child: Center(
                    child: Text(
                      '月度',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                color: Colors.transparent,
                child: Container(
                  width: 70,
                  height: 30,
                  child: Center(
                    child: Text(
                      '年度',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Center(
                      child: _simplePie(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///空气质量累计情况
  Widget _aqiAddUp(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Row(
            children: [
              Image.asset(
                ImageUtils.getImgPath('home/icon_ring'),
                width: 16,
                color: Colours.color_blue_main,
              ),
              SizedBox(width: 10),
              Text(
                "空气质量累计情况",
                style: TextStyle(
                  fontSize: 18,
                  color: Colours.color_blue_main,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(flex: 1,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                color: Colours.color_blue_light,
                child: Container(
                  width: 70,
                  height: 30,
                  child: Center(
                    child: Text(
                      '月度',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                color: Colors.transparent,
                child: Container(
                  width: 70,
                  height: 30,
                  child: Center(
                    child: Text(
                      '年度',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 5,
                padding: EdgeInsets.all(0),
                children: _aqiAddUpItem(),
                childAspectRatio: 4.0,
              )
            ),
          ),
        ),
      ],
    );
  }
  /// 因子单选
  List<Widget> _singleSelectFactorWidgets() {
    List<String> factor = ['PM2.5','PM10','O3','NO2','SO2','CO'];
    List<Widget> _list = [];

    for(var i =0; i<factor.length; i++){
      _list.add(
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          color: i==0? Colours.color_blue_main : Color(0xffb1b7c2),
          child: Center(
            child: Text(
              factor[i],
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        )
      );
    }
    return _list;
  }

  /// 累计情况item
  List<Widget> _aqiAddUpItem() {
    List<String> factor = ['PM2.5','PM10','O3','NO2','SO2','CO',"优良天数"];
    List<Widget> _list = [];

    for(var i =0; i<factor.length; i++){
      _list.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Center(child: Text(factor[i])),
                  Center(child: Text('30'
                  ,style: TextStyle(
                      color: Colours.color_blue_main
                    ),)),
                ],
              ),
              Column(
                children: [
                  Center(child: Text('同比')),
                  Center(child: Text('--')),
                ],
              ),
              Column(
                children: [
                  Center(child: Text('环比')),
                  Center(child: Text('+30%')),
                ],
              )
            ],
          )
      );
    }
    return _list;
  }

  /// 饼图
  Widget _simplePie() {
    var random = Random();

    var data = [
      PieSales(0, random.nextInt(100), charts.ColorUtil.fromDartColor(Color(0xFF126610))),
      PieSales(1, random.nextInt(100), charts.ColorUtil.fromDartColor(Color(0xFF522210))),
      PieSales(2, random.nextInt(100), charts.ColorUtil.fromDartColor(Color(0xFF929910))),
      PieSales(3, random.nextInt(100), charts.ColorUtil.fromDartColor(Color(0xFFD26699))),
    ];

    var seriesList = [
      charts.Series<PieSales, int>(
        id: 'Sales',
        domainFn: (PieSales sales, _) => sales.year,
        measureFn: (PieSales sales, _) => sales.sales,
        data: data,
        colorFn: (PieSales sales, _) => sales.color,
        labelAccessorFn: (PieSales row, _) => '${row.year}: ${row.sales}',
      )
    ];

    return charts.PieChart(seriesList,
      animate: true,
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 30,
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
          labelPosition: charts.ArcLabelPosition.outside)
        ]
      )
    );
  }
}

// 柱状图
class Barsales {
  String data;
  int value;
  Barsales(this.data, this.value);
}
/// 饼图
class PieSales {
  final int year;
  final int sales;
  final charts.Color color;

  PieSales(this.year, this.sales, this.color);
}