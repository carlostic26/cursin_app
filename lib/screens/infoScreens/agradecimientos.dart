import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class agradecimientosScreen extends StatefulWidget {
  const agradecimientosScreen(BuildContext context, {Key? key})
      : super(key: key);

  @override
  _agradecimientosScreenState createState() => _agradecimientosScreenState();
}

//Subname to playstore
//"Cursin: Cursos Gratis Certificables por organizaciones de alto valor.",
// ignore: camel_case_types
class _agradecimientosScreenState extends State<agradecimientosScreen> {
  //ads
  late BannerAd staticAd;
  bool staticAdLoaded = false;

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  void loadStaticBannerAd() {
    staticAd = BannerAd(
        adUnitId: 'ca-app-pub-4336409771912215/1019860019',
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            staticAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('ad failed to load ${error.message}');
        }));

    staticAd.load();
  }

  bool? darkTheme1;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme1 = themePrefs.getBool('isDarkTheme');
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    //load ads
    loadStaticBannerAd();
    //es necesario inicializar el sharedpreferences tema, para que la variable book darkTheme esté inicializada como la recepcion del valor del sharedpreferences
    getSharedThemePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //no color backg cuz the backg is an image
      backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,

      appBar: AppBar(
        title: Text(
          "Agradecimientos",
          style: TextStyle(
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imhback.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        //color: Colors.grey[800],

        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    GestureDetector(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Card(
                          color: darkTheme1 == true
                              ? Color.fromARGB(255, 94, 94, 94)
                              : Color.fromARGB(255, 208, 208, 208),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 26.0, 8.0, 8.0),
                              child: Column(
                                children: [
                                  Text(
                                      "El equipo de Cursin agradece y reconoce la colaboracion de las siguientes personas, quienes han aportado ajustes " +
                                          "y demás elementos dentro del desarrollo, marketing, experiencia de usuario e interfaz de usuario (UX/UI) para que Cursin pueda funcionar como aplicación movil:\n\n",
                                      style: new TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        color: darkTheme1 == true
                                            ? Colors.white
                                            : Color.fromARGB(255, 65, 65, 65),
                                      )),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Colaborador No 1. ---------------------------------------------------------------
                                        Text(
                                            " 🎖️ Carlos Peñaranda.\n(Colombia)",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: darkTheme1 == true
                                                  ? Colors.white
                                                  : Color.fromARGB(
                                                      255, 65, 65, 65),
                                            )),
                                        InkWell(
                                          child: Text('Ver en Linkedin',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.blue)),
                                          onTap: () {
                                            // ignore: deprecated_member_use
                                            launch(
                                                'https://www.linkedin.com/in/carlos-andres-pe%C3%B1aranda-tic/');
                                          },
                                        ),

                                        //Colaborador No 2. ---------------------------------------------------------------
                                        Text(
                                            "\n\n🎖️ Carlos Parraga.\n(Ecuador)",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: darkTheme1 == true
                                                  ? Colors.white
                                                  : Color.fromARGB(
                                                      255, 65, 65, 65),
                                            )),
                                        InkWell(
                                          child: Text('Ver en Linkedin',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.blue)),
                                          onTap: () {
                                            // ignore: deprecated_member_use
                                            launch(
                                                'https://www.linkedin.com/in/carlos-parraga-b9451a153/');
                                          },
                                        ),

                                        //Colaborador No 3. ---------------------------------------------------------------
                                        Text("\n\n🎖️ Abel Guardo.\n(Colombia)",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: darkTheme1 == true
                                                  ? Colors.white
                                                  : Color.fromARGB(
                                                      255, 65, 65, 65),
                                            )),
                                        InkWell(
                                          child: Text('Ver en Linkedin',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.blue)),
                                          onTap: () {
                                            // ignore: deprecated_member_use
                                            launch(
                                                'https://www.linkedin.com/in/abelguardop/');
                                          },
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ]),
                                ],
                              )),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //ad banner bottom screen
      bottomNavigationBar: Container(
        height: 60,
        child: Center(
          child: Column(
            children: [
              Container(
                //load de ad and give size
                child: AdWidget(
                  ad: staticAd,
                ),
                width: staticAd.size.width.toDouble(),
                height: staticAd.size.height.toDouble(),
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
        ),
      ),
    );
  }
}
