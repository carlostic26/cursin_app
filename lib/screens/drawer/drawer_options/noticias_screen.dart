import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/screens/webview/webviewNewsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class noticiasScreen extends StatefulWidget {
  const noticiasScreen(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<noticiasScreen> createState() => _noticiasScreenState();
}

class _noticiasScreenState extends State<noticiasScreen> {
  late BannerAd staticAd;
  bool staticAdLoaded = false;

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  void loadStaticBannerAd() {
    staticAd = BannerAd(
        adUnitId: //test: ca-app-pub-4336409771912215/8304641094  ||  real: ca-app-pub-4336409771912215/1019860019
            'ca-app-pub-4336409771912215/1019860019',
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
    loadStaticBannerAd();

    getSharedThemePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //no color backg cuz the backg is an image
      backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Articulos, noticias y podcast sobre Cursin",
          style: TextStyle(
            color: darkTheme == false ? Colors.grey[850] : Colors.white,
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          //Diario angelopolitano
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Diario Angelopolitano",
                      style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => webviewNewsScreen(
                                urlNew:
                                    'https://diarioangelopolitano.com/2022/08/03/cursin-la-app-que-te-permite-tomar-curso-gratuitos-con-certificacion/')),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://blogger.googleusercontent.com/img/a/AVvXsEij8AzSzRfxQz0QMvlwUZ1gTgMe2KQXA7ie7_A-CzpvySjGXWD5PCfAI5LdglO7USgYw7J0lz5RBTdmx5mETqD_H7Y3I9lxlYaU7TBQmKMgeTgW7xG72pj2S1SGGRCSOln8lOc07NjBvw_Vp-2c2Ldsez8hGewMXOn1LuWD1vkqBW0wgrtr1C0cLLi0',
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 5,
                          child: Container(
                            height: 25,
                            width: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => webviewNewsScreen(
                                          urlNew:
                                              'https://diarioangelopolitano.com/2022/08/03/cursin-la-app-que-te-permite-tomar-curso-gratuitos-con-certificacion/')),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              child: Text(
                                'Leer',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "3/08/2022",
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "‘Cursin’ la app que te permite tomar curso gratuitos con certificación.",
                    style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          // la opinion
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Diario La Opinión",
                      style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => webviewNewsScreen(
                                urlNew:
                                    'https://www.laopinion.com.co/economia/camara-junior-reconocio-los-jovenes-sobresalientes-de-norte-de-santander')),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://www.laopinion.com.co/sites/default/files/2023-02/jovenes-sobresalientes.jpg',
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 5,
                          child: Container(
                            height: 25,
                            width: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => webviewNewsScreen(
                                          urlNew:
                                              'https://www.laopinion.com.co/economia/camara-junior-reconocio-los-jovenes-sobresalientes-de-norte-de-santander')),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              child: Text(
                                'Leer',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "21/02/2023",
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Cámara Junior reconoció a los Jóvenes Sobresalientes de Norte de Santander s",
                    style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          //conectados con - podcast
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Podcast de Jesús Barón",
                      style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => webviewNewsScreen(
                                urlNew: 'https://youtu.be/6dW9Wb1Hj-E')),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.ytimg.com/vi/6dW9Wb1Hj-E/maxresdefault.jpg',
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 5,
                          child: Container(
                            height: 25,
                            width: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => webviewNewsScreen(
                                          urlNew:
                                              'https://youtu.be/6dW9Wb1Hj-E')),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              child: Text(
                                'Ver',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "3/08/2022",
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "#28 CARLOS PEÑARANDA - FUNDADOR CURSIN APP.",
                    style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          //try catch - podcast
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Podcast de Try Catch",
                      style: TextStyle(
                          color: darkTheme == true
                              ? Colors.white
                              : Colors.grey[850],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => webviewNewsScreen(
                                urlNew: 'https://youtu.be/j2XrQJrYXw0')),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.ytimg.com/vi/j2XrQJrYXw0/hq720.jpg?sqp=-oaymwE2CNAFEJQDSFXyq4qpAygIARUAAIhCGAFwAcABBvABAfgB_gmAAtAFigIMCAAQARh_IDsoOzAP&rs=AOn4CLCAISmBpuq7G9RPEneP93rLkaas8A',
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 5,
                          child: Container(
                            height: 25,
                            width: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => webviewNewsScreen(
                                          urlNew:
                                              'https://youtu.be/j2XrQJrYXw0')),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              child: Text(
                                'Ver',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "17/06/2022",
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Cursin La plataforma de cursos con certificados gratuita",
                    style: TextStyle(
                      color:
                          darkTheme == true ? Colors.white : Colors.grey[850],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
