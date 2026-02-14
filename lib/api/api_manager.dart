import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/radio_model.dart';
import '../models/prayer_time_model.dart';

class ApiManager {
  static Future<List<RadioModel>> getRadios() async {
    Uri url = Uri.parse("https://mp3quran.net/api/v3/radios?language=ar");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var radiosList = jsonResponse['radios'] as List;
        return radiosList.map((json) => RadioModel.fromJsonRadio(json)).toList();
      } else {
        throw Exception("Failed to load radios");
      }
    } catch (e) {
      throw Exception("Error fetching radios: $e");
    }
  }
  static Future<List<RadioModel>> getReciters() async {
    Uri url = Uri.parse("https://www.mp3quran.net/api/v3/reciters?language=ar");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var recitersList = jsonResponse['reciters'] as List;
        return recitersList.map((json) => RadioModel.fromJsonReciter(json)).toList();
      } else {
        throw Exception("Failed to load reciters");
      }
    } catch (e) {
      throw Exception("Error fetching reciters: $e");
    }
  }
  static Future<PrayerTimeModel> getPrayerTimes() async {
    DateTime now = DateTime.now();
    String dateString = "${now.day}-${now.month}-${now.year}";
    Uri url = Uri.parse("https://api.aladhan.com/v1/timingsByCity/$dateString?city=Cairo&country=Egypt");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return PrayerTimeModel.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to load prayer times");
      }
    } catch (e) {
      throw Exception("Error fetching prayer times: $e");
    }
  }
}