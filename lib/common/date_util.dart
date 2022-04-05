/// 一些常用格式参照。可以自定义格式，例如："yyyy/MM/dd HH:mm:ss"，"yyyy/M/d HH:mm:ss"。
/// 格式要求
/// year -> yyyy/yy   month -> MM/M    day -> dd/d
/// hour -> HH/H      minute -> mm/m   second -> ss/s
class DateFormats {
  static String full = "yyyy-MM-dd HH:mm:ss";
  static String y_mo_d_h_m = "yyyy-MM-dd HH:mm";
  static String y_mo_d = "yyyy-MM-dd";
  static String y_mo = "yyyy-MM";
  static String mo_d = "MM-dd";
  static String mo_d_h_m = "MM-dd HH:mm";
  static String h_m_s = "HH:mm:ss";
  static String h_m = "HH:mm";

  static String zh_full = "yyyy年MM月dd日 HH时mm分ss秒";
  static String zh_y_mo_d_h_m = "yyyy年MM月dd日 HH时mm分";
  static String zh_y_mo_d = "yyyy年MM月dd日";
  static String zh_y_mo = "yyyy年MM月";
  static String zh_mo_d = "MM月dd日";
  static String zh_mo_d_h_m = "MM月dd日 HH时mm分";
  static String zh_h_m_s = "HH时mm分ss秒";
  static String zh_h_m = "HH时mm分";
}
/// Date Util.
class DateUtil {

  /// format date by DateTime.
  /// format 转换格式(已提供常用格式 DateFormats，可以自定义格式："yyyy/MM/dd HH:mm:ss")
  /// 格式要求
  /// year -> yyyy/yy   month -> MM/M    day -> dd/d
  /// hour -> HH/H      minute -> mm/m   second -> ss/s
  static String formatDate(DateTime dateTime, {String? format}) {

    format = format ?? DateFormats.full;
    if (format.contains("yy")) {
      String year = dateTime.year.toString();
      if (format.contains("yyyy")) {
        format = format.replaceAll("yyyy", year);
      } else {
        format = format.replaceAll(
            "yy", year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }
  /// com format.
  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }

  /// 获取本周开始
  static String getWeekFirstDayYYYYMMDD(DateTime dateTime) {
    int current = dateTime.weekday;
    DateTime firstDay = DateTime.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch -
            (24 * 60 * 60 * 1000 * (current - 1)));
    return formatDate(firstDay, format: "yyyy-MM-dd");
  }
  /// 获取本周结束
  static String getWeekLastDayYYYYMMDD(DateTime dateTime) {
    int current = dateTime.weekday;
    DateTime lastDay = DateTime.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch +
            (24 * 60 * 60 * 1000 * (7 - current)));
    return formatDate(lastDay, format: "yyyy-MM-dd");
  }

  static List<String> getTimeBettwenStartTimeAndEnd(
      {required String startTime,
        required String endTime,
        required String format}) {
    var mDataList = <String>[];
    //记录往后每一天的时间搓，用来和最后一天到做对比。这样就能知道什么时候停止了。
    int allTimeEnd = 0;
    //记录当前到个数(相当于天数)
    int currentFlag = 0;
    DateTime startData = DateTime.parse(startTime);
    DateTime endData = DateTime.parse(endTime);
    while (endData.millisecondsSinceEpoch > allTimeEnd) {
      allTimeEnd =
          startData.millisecondsSinceEpoch + currentFlag * 24 * 60 * 60 * 1000;
      var dateTime = DateTime.fromMillisecondsSinceEpoch(
          startData.millisecondsSinceEpoch + currentFlag * 24 * 60 * 60 * 1000);
      String nowMoth = formatDate(dateTime,format: format);
      mDataList.add(nowMoth);
      currentFlag++;
    }
    return mDataList;
  }
}