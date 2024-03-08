import 'package:admin/core/constant/app_theme.dart';
import 'package:admin/core/functions/fcmconfig.dart';
import 'package:admin/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class LocaleController extends GetxController {
  Locale? language;

//MyServices myServices = Get.put(MyServices()) ;

  MyServices myServices = Get.find();

  ThemeData appTheme = themeEnglish;

  changeLanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    myServices.sharedPreferences.setString("lang", languageCode);
    appTheme = languageCode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  requestPerLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Get.snackbar("تنبية", "الرجاء تشغيل خدمة تحديد الموقع");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Get.snackbar("تنبية", "الرجاء اعطاء صلاحية الموقع للتطبيق");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Get.snackbar("تنبية", "لا يمكن استخدام التطبيق من دون اللوكيشن");
    }
  }

  @override
  void onInit() {
    //requestPermissionNotification() ;
    //fcmConfig() ;
    requestPerLocation();
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      appTheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      appTheme = themeEnglish;
    }
    super.onInit();
  }
}
