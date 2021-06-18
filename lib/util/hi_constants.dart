/// 常量
class HiConstants {
  static String authTokenK = "auth-token";
  static String authTokenV = "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa";

  static String courseFlagK = "course-flag";
  static String courseFlagV = "fa";

  static const theme = "hi_theme";

  /// 设置请求头校验，注意留意：Console的log输出：flutter: received:
  static headers() {
    Map<String, dynamic> header = {
      HiConstants.authTokenK: HiConstants.authTokenV,
      HiConstants.courseFlagK: HiConstants.courseFlagV
    };
    /* var boardingPass = LoginDao.getBoardingPass();
    if (boardingPass != null) {
      header[LoginDao.BOARDING_PASS] = boardingPass;
    } */
    return header;
  }
}
