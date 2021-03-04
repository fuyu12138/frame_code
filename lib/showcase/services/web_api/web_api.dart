
/// 作者： 付雨
/// 创建时间： 2020/9/5
/// 版权： 江苏远大信息股份有限公司

abstract class WebApi {
  Future<String> login(Map params);
  Future<String> getRealData(Map params);
  Future<String> getAppVersion(Map params);
  Future<String> getPortInfo(Map params);
  Future<String> getWeather(Map params);
  Future<String> getRealAQI(Map params);
  Future<String> getAQIAssessment(Map params);
  Future<String> getAQIAccumulative(Map params);
  Future<String> getFactorTrend(Map params);
  Future<String> getFineDays(Map params);
}