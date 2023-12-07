import 'dart:async';
import 'package:cursin/screens.dart';
import 'package:cursin/screens/launch/dialog_gdpr.dart';
import 'package:cursin/screens/launch/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:gdpr_dialog/gdpr_dialog.dart';
import 'package:cursin/infrastructure/models/localdb/cursos_TIC_db.dart';

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
  await DatabaseTICHandler().initializeDB();

  await MobileAds.instance.initialize();
  // Inicializar anuncio de apertura y cancelar después de 9 segundos

  await loadOpenAd();

  Timer(Duration(seconds: 10), () async {
    if (isAdLoaded == false) {
      openAd?.dispose();
      print("Anuncio de apertura cancelado después de 15 segundos.");
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
      home: LoadingScreen(),
    ),
  ));
}
