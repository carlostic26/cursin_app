import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/services/ads_ids/ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class infoApp extends StatefulWidget {
  const infoApp(BuildContext context, {Key? key}) : super(key: key);

  @override
  _infoAppState createState() => _infoAppState();
}

//Subname to playstore
//"Cursin: Cursos Gratis Certificables por organizaciones de alto valor.",
class _infoAppState extends State<infoApp> {
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
      // print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: cursinAds.banner_adUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // print('$ad loaded: ${ad.responseInfo}');
          if (this.mounted) {
            setState(() {
              // Wen the ad is loaded, get the ad size and use it to set
              // the height of the ad container.
              _anchoredAdaptiveAd = ad as BannerAd;
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  bool? darkTheme;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      bool? isDarkTheme = themePrefs.getBool('isDarkTheme');
      if (isDarkTheme != null) {
        darkTheme = isDarkTheme;
      } else {
        darkTheme = true;
      }
    });
  }

  @override
  void initState() {
    //load ads
    //loadStaticBannerAd();
    //_loadAdaptativeAd();

    getSharedThemePrefs();
  }

  @override
  Widget build(BuildContext context) {
    _loadAdaptativeAd();
    return Scaffold(
      //no color backg cuz the backg is an image
      backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
      appBar: AppBarWidget(),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                child: Column(
                  children: [
                    Container(
                        height: 180,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Image.asset("assets/logo.png")),
                    //que es cursin
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Card(
                            color: Color.fromARGB(19, 158, 158, 158),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('¿Qué es Cursin?',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'Cursin es una aplicación móvil para Android cuya función es indexar y recopilar semanalmente ' +
                                          'cursos gratuitos que emiten diferentes sitios plataformas eb educativas como Google, IBM, Microsoft, Cisco, ' +
                                          'Meta, Intel, Kaggle, ONU, Unicef, entre muchas otras más.',
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //para que sirve
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Card(
                            color: Color.fromARGB(19, 158, 158, 158),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('¿Para que sirve?',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'Esta herramienta le permite a los usuarios acceder de manera fácil y rápida a una gran variedad de cursos' +
                                          ' en línea, con certificados emitidos por las plataformas educativas mencionadas, pudiendo asi mejorar ' +
                                          'sus habilidades y conocimientos en diferentes áreas y temas.',
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //cual es su objetivo
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Card(
                            color: Color.fromARGB(19, 158, 158, 158),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('¿Cual es su objetivo?',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'Esta iniciativa busca facilitar el acceso gratuito a la ' +
                                          'educación en línea, que puede ser útil para personas que buscan aprender nuevas habilidades, pero no tienen el ' +
                                          'tiempo o los recursos para buscar cursos de manera individual.',
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //como son los cursos
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Card(
                            color: Color.fromARGB(19, 158, 158, 158),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('¿Cómo son los Cursos?',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'Cursin indexa semanalmente cerca de 30 a 40 cursos nuevos que forman parte de la amplia lista de cursos gratuitos dentro de la App, que cumplan con cuatro características principales.\n\n' +
                                          '1. Cursos completamente gratis.\n' +
                                          '2. Cursos completamente asíncronos.\n' +
                                          '3. Cursos con tipo de emisión certificable.\n' +
                                          '4. Cursos emitidos por plataformas reconocidas o instituciones de alto valor.',
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Card(
                            color: Color.fromARGB(19, 158, 158, 158),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('¿Existe Cursin web?',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'No. Actualmente Cursin no cuenta con un motor de búsqueda en internet, por lo que sólo existe la versión en aplicaciones móviles para android la cual estás usando en este momento. El único sitio oficial de cursin es www.cursin.app el cual es un blog de caracter informativo sobre la app Curisn.\n\nEn caso de que veas cualquier otro sitio web con el nombre de Cursin, debes saber que es falso y puedes caer en estafa si accedes. Siempre confirmamos por este medio que sitios y redes sociales manejamos.',
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Card(
                            color: Color.fromARGB(19, 158, 158, 158),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '¿Se pueden abrir los cursos en computadora?',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'Si. Cursin app solo es la herramienta que tienes a mano para encontrar ese curso que tanto necesitabas. Una vez accedas, podrás copiar el enlace web de dicho curso o abrirlo directamente en el navegador.',
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Card(
                            color: Color.fromARGB(19, 158, 158, 158),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Datos interesantes',
                                      style: new TextStyle(
                                        fontSize: 18.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 10.0),
                                  Text(
                                      'Existe un gran número de plataformas y sitios que lanzan cursos gratuitos frecuentemente en programas académicos sin necesidad de pagarlos, por lo que se decidió desarrollar Cursin App para entregar a los usuarios semanalmente cada curso gratuito, mejorando así la formación academica y profesional de quien decida tomarlos.\n\n' +
                                          '✅ Cursin nace de la idea del Ing. Carlos Peñaranda, cuando identificó que gracias a las TIC se puede encontrar una gran variedad de herramientas que permiten obtener conocimiento de alta calidad de forma gratuita, permitiendo impulsar el aprendizaje autodidacta.\n\n' +
                                          '✅ Cursin es conocida como el "Google" de los cursos gratis online y asincrónicos, en donde se entrega el acceso web a los usuarios' +
                                          ' gracias a las plataformas y sitios que los emiten al público.\n\n' +
                                          '✅ Cursin es importante porque actúa como una "Biblioteca" donde siempre se podrá encontrar material educativo ' +
                                          'de alto valor sin tener que invertir económicamente en ello.\n\n' +
                                          '✅ Cursin ha llegado a ocupar el segundo lugar entre las aplicaciónes moviles del momento mas exitosas de Play Store bajo la categoría de educación.',
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        color: darkTheme == true
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                      child: Text(
                          "Apóyanos con una calificación de 5 estrellas" +
                              " y un comentario positivo en Play Store",
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            color:
                                darkTheme == true ? Colors.white : Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueGrey), // Color del botón blueGrey
                        ),
                        child: Text(
                          'Dar 5 ⭐ en PlayStore',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        onPressed: () {
                          launch(
                              'https://play.google.com/store/apps/details?id=com.appcursin.blogspot');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
          ? Container(
              color: Color.fromARGB(0, 33, 149, 243),
              width: _anchoredAdaptiveAd?.size.width.toDouble(),
              height: _anchoredAdaptiveAd?.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            )
          : Container(
              color: Color.fromARGB(0, 33, 149, 243),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height *
                  0.1, // 10% de la altura de la pantalla
            ),
    );
  }

  PreferredSizeWidget AppBarWidget() {
    return AppBar(
      elevation: 0,
      backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: darkTheme == true ? Colors.white : Colors.grey[850],
            ), // Icono del botón de hamburguesa
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      title: Text(
        "Información",
        style: TextStyle(
          color: darkTheme == false ? Colors.grey[850] : Colors.white,
          fontSize: 16.0, /*fontWeight: FontWeight.bold*/
        ),
      ),
      centerTitle: true,
    );
  }
}
