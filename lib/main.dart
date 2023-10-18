import 'dart:async';
import 'package:cursin/utils/ads_ids/ads.dart';
import 'package:cursin/controller/theme_preferences.dart';
import 'package:cursin/screens/launch/percent_indicator_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cursin/infrastructure/models/localdb/cursosdb_sqflite.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/local_notifications/local_notifications.dart';

AppOpenAd? openAd;
bool isAdLoaded = false;

Future<void> loadOpenAd() async {
  CursinAdsIds cursinAds = CursinAdsIds();
  //apertura
  await AppOpenAd.load(
    adUnitId: cursinAds.openApp_adUnitId,
    request: const AdRequest(),
    adLoadCallback: AppOpenAdLoadCallback(
      onAdLoaded: (ad) {
        openAd = ad;
        openAd!.show();
        print("**Anuncio cargado correctamente");
        isAdLoaded = true; // El anuncio se cargó y mostró correctamente
      },
      onAdFailedToLoad: (error) {
        print("Error al cargar el anuncio: $error");

        isAdLoaded = false; // El anuncio no se cargó o mostró correctamente
      },
    ),
    orientation: AppOpenAd.orientationPortrait,
  );
}

Future<void> main() async {
  // init adv
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  //init theme
  final themePreference = ThemePreference();
  await themePreference.initialize();

  //init db sqlite
  await DatabaseHandler().initializeDB();

  await MobileAds.instance.initialize();
  // Inicializar anuncio de apertura y cancelar después de 9 segundos
  await loadOpenAd();

  Timer(Duration(seconds: 9), () async {
    if (isAdLoaded == false) {
      openAd?.dispose();
      print("Anuncio de apertura cancelado después de 9 segundos.");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('adCancelado', true);
    } else {
      print("Anuncio de apertura mostrado correctamente.");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('adCancelado', false);
    }
  });

  //solicitar permisos local notification
  await LocalNotifications.initializeLocalNotificatios();
  await LocalNotifications.requestPermissionLocalNotification();

  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PercentIndicatorRiverpod(),
    ),
  ));
}
