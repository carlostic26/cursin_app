import 'package:cursin/model/dbhelper.dart';
import 'package:cursin/screens/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AppOpenAd? openAd;

Future<void> loadAd() async {
  //Anun de apertura
  await AppOpenAd.load(
      adUnitId:
          // test:  // ca-app-pub-3940256099942544/3419835294
          // real: ca-app-pub-4336409771912215/5446190186 || real2:ca-app-pub-4336409771912215/5955842482
          'ca-app-pub-4336409771912215/5955842482',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
        openAd = ad;
        openAd!.show();
      }, onAdFailedToLoad: (error) {
        print("adv failed to load $error");
      }),
      orientation: AppOpenAd.orientationPortrait);
}

Future<void> main() async {
  // init adv
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  //init db sqlite
  await DatabaseHandler().initializeDB();

  await MobileAds.instance.initialize();
  await loadAd();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: percentIndicator(),
  ));
}
