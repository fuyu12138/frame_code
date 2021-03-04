import 'package:flutter/material.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司
/// 用户名、密码输入框封装

class MyTextField extends StatefulWidget {

  final TextEditingController controller;
  final bool autoFocus;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String hintText;
  final FocusNode focusNode;
  final bool isPwd;
  final Function onEditingComplete;

  const MyTextField({
    Key key,
    @required this.controller,
    this.autoFocus = false,
    this.textInputType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    this.isPwd = false,
    this. onEditingComplete,
    this.textInputAction = TextInputAction.done
  }):super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();

}

class _MyTextFieldState extends State<MyTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      obscureText: widget.isPwd,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      onEditingComplete: widget.onEditingComplete,
      style: TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
        fillColor: Color.fromARGB(100, 255, 255, 255),
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.white
        ),
        contentPadding: EdgeInsets.fromLTRB(20,0,20,0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.5
          )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide.none
        ),
      )
    );
  }
}