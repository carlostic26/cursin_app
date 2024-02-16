import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AgradecimientosScreen extends StatelessWidget {
  final BannerAd staticAd;
  bool? darkTheme;

  AgradecimientosScreen({
    required this.staticAd,
    required this.darkTheme,
  });

  static const AdRequest request = AdRequest();

  Future<void> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    darkTheme = themePrefs.getBool('isDarkTheme');
    if (darkTheme != null) {
      darkTheme = darkTheme;
    } else {
      darkTheme = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        title: Text(
          "Agradecimientos",
          style: TextStyle(
            fontSize: 16.0,
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
                            color: darkTheme == true
                                ? Color.fromARGB(255, 94, 94, 94)
                                : Color.fromARGB(255, 208, 208, 208),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                8.0,
                                26.0,
                                8.0,
                                8.0,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "El equipo de Cursin agradece y reconoce la colaboración de las siguientes personas, quienes han aportado ajustes " +
                                        "y demás elementos dentro del desarrollo, marketing, experiencia de usuario e interfaz de usuario (UX/UI) para que Cursin pueda funcionar como aplicación móvil:\n\n",
                                    style: TextStyle(
                                      color: darkTheme == true
                                          ? Colors.white
                                          : Color.fromARGB(255, 65, 65, 65),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Colaborador No 1. ---------------------------------------------------------------
                                      Text(
                                        " 🎖️ Carlos Peñaranda.\n(Colombia)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: darkTheme == true
                                              ? Colors.white
                                              : Color.fromARGB(
                                                  255,
                                                  65,
                                                  65,
                                                  65,
                                                ),
                                        ),
                                      ),
                                      InkWell(
                                        child: Text(
                                          'Ver en Linkedin',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        onTap: () {
                                          launch(
                                              'https://www.linkedin.com/in/carlos-andres-penaranda/');
                                        },
                                      ),

                                      //Colaborador No 2. ---------------------------------------------------------------
                                      Text(
                                        "\n\n🎖️ Carlos Parraga.\n(Ecuador)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: darkTheme == true
                                              ? Colors.white
                                              : Color.fromARGB(
                                                  255,
                                                  65,
                                                  65,
                                                  65,
                                                ),
                                        ),
                                      ),
                                      InkWell(
                                        child: Text(
                                          'Ver en Linkedin',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        onTap: () {
                                          launch(
                                              'https://www.linkedin.com/in/carlos-parraga-b9451a153/');
                                        },
                                      ),

                                      //Colaborador No 3. ---------------------------------------------------------------
                                      Text(
                                        "\n\n🎖️ Abel Guardo.\n(Colombia)",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: darkTheme == true
                                              ? Colors.white
                                              : Color.fromARGB(
                                                  255,
                                                  65,
                                                  65,
                                                  65,
                                                ),
                                        ),
                                      ),
                                      InkWell(
                                        child: Text(
                                          'Ver en Linkedin',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        onTap: () {
                                          launch(
                                              'https://www.linkedin.com/in/abelguardop/');
                                        },
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(
          child: Column(
            children: [
              Container(
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
