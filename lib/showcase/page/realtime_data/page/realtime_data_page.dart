import 'package:flutter/material.dart';
import 'package:frame_code/frame/provider/theme_provider.dart';
import 'package:frame_code/showcase/page/gis/page/real_data_page.dart';
import 'package:frame_code/showcase/page/realtime_data/provider/real_data_provider.dart';
import 'package:frame_code/showcase/provider/user_provider.dart';
import 'package:frame_code/showcase/utils/aqi_utils.dart';
import 'package:provider/provider.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司
class RealTimeDataPage extends StatefulWidget {
  @override
  _RealTimeDataPageState createState() => _RealTimeDataPageState();
}

class _RealTimeDataPageState extends State<RealTimeDataPage> {

  @override
  Widget build(BuildContext context) {
    Provider.of<RealDataProvider>(context, listen: false).requestRealData(
        Provider.of<UserProvider>(context, listen: false).userGuid
    );
    return Scaffold(
      appBar: AppBar(
        title:Text(
          "实时数据",
          style: TextStyle(
              fontSize: 18,
              color: Colors.white
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
        centerTitle:true,
        elevation: 4,
      ),
      body: Container(
        color: Color(0xffefefef),
        child: Consumer<RealDataProvider>(
          builder: (context, provider, child) {
            return RefreshIndicator(
              onRefresh: () async {
                Provider.of<RealDataProvider>(context, listen: false).requestRealData(
                    Provider.of<UserProvider>(context, listen: false).userGuid
                );
              },
              child: ListView.builder(itemBuilder: (_,index) {
                List<Widget> _factorName = [];
                List<Widget> _factorValue = [];
                for(int i=0; i<provider.list[index].factorValues.length; i++){
                  _factorName.add(
                    Expanded(
                      child: Center(
                        child: Text(
                          provider.list[index].factorValues[i].factor,
                        ),
                      ),
                    )
                  );

                  _factorValue.add(Expanded(
                    child: Center(
                      child: Text(
                        provider.list[index].factorValues[i].value == '' ?
                            '--' : provider.list[index].factorValues[i].value
                      ),
                    ),
                  ));
                }
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                provider.list[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                                ),
                              ),
                              Container(
                                width: 70,
                                height: 24,
                                child: Center(
                                  child: Text(
                                    AqiUtils.getAQIGrade(provider.list[index].aqi),
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: AqiUtils.getAQIColor(provider.list[index].aqi),
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                provider.list[index].time,
                              ),
                              Text(
                                  "首要污染物：${provider.list[index].mainPollutes.length == 0 ?
                                  '--' : provider.list[index].mainPollutes[0].factor}"
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:_factorName,
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _factorValue,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },itemCount: provider.list.length,),
            );
          }
        ),
      ),
    );
  }
}
