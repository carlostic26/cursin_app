import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/ads_ids/ads.dart';
import 'package:cursin/screens/webview/courses_webview.dart';
import 'package:cursin/screens/drawer/drawer.dart';
import 'package:cursin/screens/drawer/drawer_options/carruselCertifiedWidget.dart';
import 'package:cursin/screens/drawer/drawer_options/courses_favs.dart';
import 'package:cursin/screens/drawer/drawer_options/delete_anun.dart';
import 'package:cursin/screens/drawer/drawer_options/search_courses.dart';
import 'package:cursin/screens/drawer/drawer_options/ultimos_cursos.dart';
import 'package:cursin/screens/infoScreens/agradecimientos.dart';
import 'package:cursin/screens/infoScreens/info_app.dart';
import 'package:cursin/screens/infoScreens/info_cursin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mailto/mailto.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cursin/screens/drawer/drawer_options/categorias_select.dart';
import 'package:url_launcher/url_launcher.dart';

class certificadosScreen extends StatefulWidget {
  const certificadosScreen({super.key});

  @override
  State<certificadosScreen> createState() => _certificadosScreenState();
}

//Clase que abre una pantalla entregando información relacionada a los certificados de estudio mas comunes que se puedan encontrar

class _certificadosScreenState extends State<certificadosScreen> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptativeAd();
  }

  Future<void> _loadAdaptativeAd() async {
    CursinAdsIds cursinAds = CursinAdsIds();
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId: cursinAds.banner_adUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  bool? darkTheme1, isNotifShowed;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme1 = themePrefs.getBool('isDarkTheme');
    });
  }

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  @override
  void initState() {
    super.initState();

    _loadAdaptativeAd();
    //es necesario inicializar el sharedpreferences tema, para que la variable book darkTheme esté inicializada como la recepcion del valor del sharedpreferences
    getSharedThemePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        title: Text(
          "Certificados",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //pass to search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => searchedCourses(
                        catProviene: "sinCategoria",
                        puntoPartida: 'categorias_select'),
                  ),
                );
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Estos son algunos certificados que puedes obtener usando Cursin App como herramienta para encontrar cursos gratis online de toda internet.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: darkTheme1 == true ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),

            //carrusel
            carruselCertifiedScreen(),
            SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.green,
                  boxShadow: [
                    //BoxShadow(color: Color.fromARGB(255, 24, 24, 24), spreadRadius: 3),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: new ExpansionTile(
                      backgroundColor: Colors.grey,
                      title: Text('¿Cómo reclamo mi certificado?',
                          style: new TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          )),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Card(
                                      color: Colors.grey,
                                      child: new Container(
                                        child: Column(
                                          children: [
                                            Text(
                                                'Si en la tabla de información del curso dentro de Cursin, la emisión del certificado se encuentra marcada como "con certificado gratis" significa que no tendrás que pagar absolutamente nada por dicho diploma.\n\nSi en la tabla de información del curso dentro de Cursin, la emisión del certificdo se encuentra marcada como "Sin certificado" significa que puede que no emitan ningún certificado, o que puede que cobren por ello.\n'),
                                            Text(
                                                'Cada plataforma dueña de los cursos gratis es autónoma en la manera de emitir los certificados de finalización.'),
                                            Text(
                                                '\nLa mayoria de las plataformas libera los certificados una vez se alcanza el 100% de todas las clases o lecciones que conforman el curso.'),
                                            Text(
                                                '\nDependiendo de la plataforma que emite el curso, es posible que el certificado lo envíen directamente a tu correo electronico asociado'),
                                            Text(
                                                '\nDependiendo de la plataforma que emite el curso, es posible que el certificado pueda descargarse directamente. Por lo tanto, te recomendamos que abras el curso con el navegador si deseas descargar el certificado en tu dispositivo.'),
                                          ],
                                        ),
                                      )),
                                ],

                                //img button save
                              )),
                        ),
                      ] // Add all items you wish to show when the tile is expanded
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: drawerCursin(context: context),
      //ad banner bottom screen
      bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
          ? Container(
              color: Color.fromARGB(0, 33, 149, 243),
              width: _anchoredAdaptiveAd!.size.width.toDouble(),
              height: _anchoredAdaptiveAd!.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            )
          : Container(
              color: Color.fromARGB(
                  0, 33, 149, 243), // Aquí se establece el color del Container
              width: _anchoredAdaptiveAd!.size.width.toDouble(),
              height: _anchoredAdaptiveAd!.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            ),
    );
  }
}
