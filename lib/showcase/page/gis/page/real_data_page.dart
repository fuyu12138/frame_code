
import 'package:flutter/material.dart';
/// 作者： 付雨
/// 创建时间： 2020/9/4
/// 版权： 江苏远大信息股份有限公司

// ignore: must_be_immutable
class RealDataPage extends StatefulWidget {
  String content = '';
  RealDataPage(this.content);
  @override
  _RealDataPageState createState() => _RealDataPageState();
}

class _RealDataPageState extends State<RealDataPage> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            child: Center(
              child: Text(
                widget.content
              ),
            ),
          ),
        ),
      ),
    );
  }
}

