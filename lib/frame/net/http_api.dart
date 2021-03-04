import 'package:frame_code/frame/config/app_base_config.dart';

/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司
/// 接口地址

class HttpApi {

  static final baseUrl = AppBaseConfig.MockUrl;
  static final weatherPath = "https://free-api.heweather.com/s6";

  /// 登录
  static final loginPath = baseUrl+"/Frame/UserLoginApp";
  /// 实时数据
  static final realData = baseUrl+"/Air/APPRealData";
  /// 版本更新
  static final versionInfo = baseUrl+"/Air/AppVersion";
  /// 站点列表
  static final airPortInfo = baseUrl+"/Air/AirPortInfo";
  /// 天气
  static final weather = baseUrl+"/weather/now";
  /// 实时AQI
  static final realAQI = baseUrl+"/Air/RealAQI";
  /// 考核目标
  static final aqiAssessment = baseUrl+"/Air/AQIAssessment";
  /// 因子趋势
  static final factorTrend = baseUrl+"/Air/FactorTrend";
  /// 累计情况
  static final aqiAccumulative = baseUrl+"/Air/AQIAccumulative";
  /// 优良天数统计
  static final fineDays = baseUrl+"/Air/FineDays";
}