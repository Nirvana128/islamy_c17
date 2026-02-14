class PrayerTimeModel {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String readableDate;
  final String hijriDate;
  final String hijriMonth;
  final String dayName;

  PrayerTimeModel({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.readableDate,
    required this.hijriDate,
    required this.hijriMonth,
    required this.dayName,
  });

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    var timings = json['data']['timings'];
    var date = json['data']['date'];
    var hijri = date['hijri'];

    return PrayerTimeModel(
      fajr: timings['Fajr'],
      dhuhr: timings['Dhuhr'],
      asr: timings['Asr'],
      maghrib: timings['Maghrib'],
      isha: timings['Isha'],
      readableDate: date['readable'],
      hijriDate: hijri['day'],
      hijriMonth: hijri['month']['en'],
      dayName: date['gregorian']['weekday']['en'],
    );
  }
}