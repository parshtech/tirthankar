import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:Tirthankar/models/music.dart';
// / import 'employee.dart';

class languageSelector {
  String album = "";
  String ename = "";
  String mname = "";
  String esign = "";
  String msign = "";
  String other1 = "";
  String other2 = "";
  String title = "";
  String appname = "";

  String getAlbum(String module, int lang_index) {
    if (lang_index == 0 || lang_index == null) {
      return module;
    } else {
      switch (module) {
        case "Tirthankar":
          return "तीर्थंकर";
          break;
        case "Language":
          return "भाषा";
          break;
        case "PRAVCHAN":
          return "प्रवचन";
          break;
        case "BHAKTAMBAR":
          return "भक्तांम्बर";
          break;
        case "NAMOKAR MANTRA":
          return "णमोकार";
          break;
        case "BHAJAN":
          return "भजन";
          break;
        case "KIDS":
          return "कहानिया";
          break;
        case "STUTI":
          return "स्तुति";
          break;
        case "FAVORITE":
          return "फेवरेट";
          break;
        case "JINALAY":
          return "जिनालय";
          break;
        case "JAIN RASOI":
          return "जैन रसोई";
          break;
        case "CALENDAR":
          return "पंचांग";
          break;
        case "JINVANI TV":
          return "जिनवाणी चैनल";
          break;
        case "AARTI":
          return "आरती";
          break;
        case "SETTING":
          return "सेटिंग";
          break;
        case "JAIN BOOKS":
          return "जैन पुस्तक";
          break;
        case "INFO":
          return "संस्था माहीती ";
          break;
        case "PRAMAN SAGAR":
          return "प्रमाणसागर जी";
          break;
        case "AUDIO":
          return "MP3";
          break;
        case "VIDEO":
          return "विडिओ";
          break;
        case "TARUN SAGAR":
          return "तरुणसागर जी";
          break;
        case "PUSHPDANT SAGAR":
          return "पुष्पदंतसागर जी";
          break;
        case "PULAK SAGAR":
          return "पुलकसागर जी";
          break;
        case "DR. HUKUMCHAND JI":
          return "डॉ. हुकमचन्दजी";
          break;
        case "VIDYA SAGAR":
          return "विद्यासागर जी";
          break;
        case "NAMOKAR/BHAKTAMBAR":
          return "णमोकार/भक्ताम्बर";
          break;
        case "CHALISA":
          return "चालीसा";
          break;
        case "VIDHAN":
          return "विधान";
          break;
        case "MUSIC":
          return "संगीत पूजा/गीत";
          break;
        case "BOOK":
          return "पुस्तक";
          break;
        case "VIDEO":
          return "विडिओ";
          break;
        case "JAIN RASOI":
          return "जैन रसोई";
          break;
        case "POOJA":
          return "पूजा";
          break;
        case "JAIN POOJA":
          return "जैन पूजा";
          break;
        case "LANGUAGE":
          return "भाषा";
          break;
        case "DAILY":
          return "फेवरेट";
          break;
        case "JAIN TIRTH":
          return "जैन तीर्थ";
          break;
        case "JAIN GROUPS":
          return "जैन संस्था";
          break;
        case "JAIN MAGAZINE":
          return "जैन पत्रिका";
          break;
        case "CHOOSE PHONE NUMBER":
          return "फोन नंबर चयन करे";
          break;

        default:
          return module;
          break;
      }
    }
  }

  String getAlert(String module, int langIndex) {
    if (langIndex == 0 || langIndex == null) {
      return module;
    } else {
      switch (module) {
        case "Check internet connection":
          return "इंटरनेट कनेक्शन चेक करे!!";
          break;
        case "Enter page no less than book page":
          return "पृष्ठ क्रमांक चेक करे";
          break;
        case "Please enter Page No":
          return "पृष्ठ क्रमांक संपादित करे";
          break;
        case "Unable to play this song!!":
          return "यह गाना/भजन उप्लभद नही है!!";
          break;
        case "Enter Song/Bhajan name to search!!":
          return "गाना/भजन धुंडने के लिये याह लिखे!!";
          break;
        case "Enter City/State name to search!!":
          return "शहर का अथवा राज्य के नुसार धुंडने के लिये याह लिखे!!";
          break;
        case "No record found!!":
          return "जानकारी उप्लभद नही है!!";
          break;
        case "No Song/Bhajan found!!":
          return "यह गाना/भजन उप्लभद नही है!!";
          break;
        case "MARATHI":
          return "मराठी";
          break;
        case "DAILY":
          return "फेवरेट";
          break;
        case "MARATHI & HINDI":
          return "मराठी & हिंदी";
          break;
        case "HINDI":
          return "हिंदी";
          break;
        case "POOJA":
          return "पूजा";
          break;
        case "VIDHAN":
          return "विधान";
          break;
        case "PUJA":
          return "पूजा";
          break;
        case "ENGLISH":
          return "इंग्लिश";
          break;
        case "Storage Permission Required":
          return "स्टोरेज ऍक्सेस परमिशन प्रदान करे!!";
          break;
        case "Download Book to view":
          return "क्लिक डाउनलोड आयकॉन टू डाउनलोड बुक!!";
          break;
        case "Please select song to play.":
          return "संगीत शुरु करणे के लिये, अपने पसंदीदा गाणे को सिलेक्ट करे!!";
          break;
        case "Song removed from favorite":
          return "गाना फेवरेट में असंपादित हुआ !!";
          break;
        case "Song added to favorite":
          return "गाना फेवरेट में सम्पादित हुआ !!";
          break;

        default:
          return module;
          break;
      }
    }
  }

  Future<int> getLanguage() async {
    int langIndex;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    langIndex = prefs.getInt('language') ?? 0;
    return langIndex;
  }
}
