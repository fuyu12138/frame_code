import 'dart:convert' show json;

/// 作者： 付雨
/// 创建时间： 2020/9/7
/// 版权： 江苏远大信息股份有限公司


class RealDataModel {

  String aqi;
  String id;
  String name;
  String time;
  List<FactorValues> factorValues;
  List<MainPollutes> mainPollutes;

  RealDataModel.fromParams({this.aqi, this.id, this.name, this.time, this.factorValues, this.mainPollutes});

  factory RealDataModel(jsonStr) => jsonStr == null ? null : jsonStr is String ? RealDataModel.fromJson(json.decode(jsonStr)) : RealDataModel.fromJson(jsonStr);

  RealDataModel.fromJson(jsonRes) {
    aqi = jsonRes['aqi'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    time = jsonRes['time'];
    factorValues = jsonRes['factorValues'] == null ? null : [];

    for (var factorValuesItem in factorValues == null ? [] : jsonRes['factorValues']){
      factorValues.add(factorValuesItem == null ? null : FactorValues.fromJson(factorValuesItem));
    }

    mainPollutes = jsonRes['mainPollutes'] == null ? null : [];

    for (var mainPollutesItem in mainPollutes == null ? [] : jsonRes['mainPollutes']){
      mainPollutes.add(mainPollutesItem == null ? null : MainPollutes.fromJson(mainPollutesItem));
    }
  }

  @override
  String toString() {
    return '{"aqi": ${aqi != null?'${json.encode(aqi)}':'null'}, "id": ${id != null?'${json.encode(id)}':'null'}, "name": ${name != null?'${json.encode(name)}':'null'}, "time": ${time != null?'${json.encode(time)}':'null'}, "factorValues": $factorValues, "mainPollutes": $mainPollutes}';
  }
}

class MainPollutes {

  String factor;
  String unit;
  String value;

  MainPollutes.fromParams({this.factor, this.unit, this.value});

  MainPollutes.fromJson(jsonRes) {
    factor = jsonRes['factor'];
    unit = jsonRes['unit'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"factor": ${factor != null?'${json.encode(factor)}':'null'}, "unit": ${unit != null?'${json.encode(unit)}':'null'}, "value": ${value != null?'${json.encode(value)}':'null'}}';
  }
}

class FactorValues {

  String factor;
  String unit;
  String value;

  FactorValues.fromParams({this.factor, this.unit, this.value});

  FactorValues.fromJson(jsonRes) {
    factor = jsonRes['factor'];
    unit = jsonRes['unit'];
    value = jsonRes['value'];
  }

  @override
  String toString() {
    return '{"factor": ${factor != null?'${json.encode(factor)}':'null'}, "unit": ${unit != null?'${json.encode(unit)}':'null'}, "value": ${value != null?'${json.encode(value)}':'null'}}';
  }
}

