import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/utils/ads_ids/ads.dart';
import 'package:cursin/screens/drawer/drawer_options/certificados.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class deleteAnunScreen extends StatefulWidget {
  const deleteAnunScreen({super.key});

  @override
  State<deleteAnunScreen> createState() => _deleteAnunScreenState();
}

const int maxAttempts = 3;

//Clase que muestra una pantalla al usuario con información relacionada a las recompensas
//El usuario puede elgir entre ver o no ver anun para siempre en la app a través de recompensas
//La app eliminará los anun cuando el usuario obtenga recompensas, y usar dichas recompensas para dejar de que verlos

class _deleteAnunScreenState extends State<deleteAnunScreen> {
  //initializing reward ad
  RewardedAd? rewardedAd;
  int rewardedAdAttempts = 0;
  int actualCursinCoins = 0;

  CursinAdsIds cursinAds = CursinAdsIds();

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: cursinAds.reward_adUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          rewardedAd = ad;
          rewardedAdAttempts = 0;
        }, onAdFailedToLoad: (error) {
          rewardedAdAttempts++;
          rewardedAd = null;
          print('failed to load ${error.message}');

          if (rewardedAdAttempts <= maxAttempts) {
            createRewardedAd();
          }
        }));
  }

  int enterAcces = 0;

  bool? darkTheme;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme = themePrefs.getBool('isDarkTheme');
    });
  }

  Future<Null> getTotalCoinsPrefs() async {
    //Read all coins saved
    SharedPreferences coinsPrefs = await SharedPreferences.getInstance();
    setState(() {
      actualCursinCoins = coinsPrefs.getInt('cursinCoinsSHP') ?? 2;
    });
  }

  //showing rewarded
  void showRewardedAd() {
    if (rewardedAd == null) {
      if (enterAcces <= 2) {
        Fluttertoast.showToast(
          msg: "Intentalo de nuevo.", // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.BOTTOM, // location
        );

        enterAcces++;
      } else {
        if (enterAcces >= 3) {
          Fluttertoast.showToast(
            msg: "Vuelve más tarde por más monedas", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
          );
        }
        enterAcces++;
      }

      return;
    }

    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => print('ad showed $ad'),

        //when ad closes
        onAdDismissedFullScreenContent: (ad) async {
          //earn 2 coins and save total coins
          SharedPreferences coinsPrefs = await SharedPreferences.getInstance();
          int newCoins = actualCursinCoins + 2;

          setState(() {
            coinsPrefs.setInt('cursinCoinsSHP', newCoins);
            actualCursinCoins = newCoins;
          });

          //open new coins dialog
          showDialogMonedasObtenidas();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print('failed to show the adv $ad');

          //Toast diciendo: no se han podido cargar los anuncios.\n Asegurate de tener una buena conexión a internet, volver a abrir la App o intentar abrir el curso mas tarde, cuando los anuncios estén cargados en tu telefono.
          Fluttertoast.showToast(
            msg:
                "No se han podido cargar los anuncios.\nIntentalo de nuevo en 5 segundos", // message
            toastLength: Toast.LENGTH_LONG, // length
            gravity: ToastGravity.BOTTOM, // location
          );

          createRewardedAd();
        });

    rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      print('reward video ${reward.amount} ${reward.type}');
    });
    rewardedAd = null;
  }

  @override
  void initState() {
    createRewardedAd();
    getSharedThemePrefs();
    getTotalCoinsPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //no color backg cuz the backg is an image
        backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
        appBar: AppBar(
          title: Text(
            "Eliminar anuncios",
            style: TextStyle(
              fontSize: 16.0, /*fontWeight: FontWeight.bold*/
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://blogger.googleusercontent.com/img/a/AVvXsEiwxIH9j_V6Jys6c-b_gE_rxAVTyp4PxyUGXoGWpexwanKxwBxpYcI2DR5pqxOAaOov0OTo83wrlK-YebnAuBV5ZTvzo9UIcLnYDuOYsV6iPaqN75COyqsKN-IZH9V9PSGn1qBpnM78DVk87NQBOVmJJJkBf2kz84LQIhWp87aNFpYY34YKglDXiw=w200-h200',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ), // icono de monedas
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('$actualCursinCoins'),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Stack(children: [
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                //img de eliminar anun
                CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  imageUrl:
                      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEieP-_Xl4wgihWxdJj2sNp4CfM-dePbsRteCK-KUMkgsJYbbWpLtQlLD0t2APCE8rnIY1VfiCkbpTlYW8n1h9oiomi9BjThCq5rKuGut0xrAOPTNmumyNlaQnWzM9UlgCFA7HylzwOsM8sMReqFmUCKRyP4TdVyQzqX2ye1iBHnVycrFCiFEkxulA/w400-h149/ad.gif',
                  placeholder: (context, url) => Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 1.5,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total monedas: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: darkTheme == true
                                ? Colors.white
                                : Colors.black)),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://blogger.googleusercontent.com/img/a/AVvXsEiwxIH9j_V6Jys6c-b_gE_rxAVTyp4PxyUGXoGWpexwanKxwBxpYcI2DR5pqxOAaOov0OTo83wrlK-YebnAuBV5ZTvzo9UIcLnYDuOYsV6iPaqN75COyqsKN-IZH9V9PSGn1qBpnM78DVk87NQBOVmJJJkBf2kz84LQIhWp87aNFpYY34YKglDXiw=w200-h200',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ), // icono de monedas
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        '$actualCursinCoins',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: darkTheme == true
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                    SizedBox(width: 15),

                    Container(
                      height: 20,
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showDialogCanjearMonedas();
                          },
                          icon: Icon(Icons.volunteer_activism,
                              size: 10.0,
                              color: darkTheme == true
                                  ? Colors.black
                                  : Colors.white),
                          label: Text(
                            'Canjear',
                            style: TextStyle(
                                fontSize: 10,
                                color: darkTheme == true
                                    ? Colors.black
                                    : Colors.white),
                          ), // <-- Text
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.amber),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialogConseguirMonedas();
                      },
                      icon: Icon(
                        Icons.volunteer_activism,
                        size: 20.0,
                      ),
                      label: Text('Conseguir monedas'), // <-- Text
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Puedes eliminar para siempre el anuncio que se muestra antes de entrar a un curso dentro de la app Cursin cuando alcances 12 monedas.',
                        style: TextStyle(
                            color: darkTheme == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      Text(
                        '\nPara conseguir monedas solo debes ver algunos videos.\n',
                        style: TextStyle(
                            color: darkTheme == true
                                ? Colors.white
                                : Colors.black),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '¿Para qué sirven las monedas?',
                        style: TextStyle(
                            fontSize: 22.0, // Esto sería similar a H1 en HTML
                            color:
                                darkTheme == true ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Para eliminar los comerciales que salen antes de entrar a un curso encontrado dentro de Cursin. Debes tener en cuenta que se requieren al menos 12 para ello.',
                          style: TextStyle(
                              fontSize: 16.0, // Esto sería similar a H2 en HTML
                              color: darkTheme == true
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '¿Qué son los anuncios?',
                        style: TextStyle(
                            fontSize: 22.0, // Esto sería similar a H1 en HTML
                            color:
                                darkTheme == true ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Son pequeños comerciales de video que te salen justo antes de entrar a cualquier curso que decidas tomar gracias a Cursin App.',
                          style: TextStyle(
                              fontSize: 16.0, // Esto sería similar a H2 en HTML
                              color: darkTheme == true
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '¿Por qué se muestran?',
                        style: TextStyle(
                            fontSize: 22.0, // Esto sería similar a H1 en HTML
                            color:
                                darkTheme == true ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Son necesarios para seguir manteniendo la app en el tiempo. Sirven para seguir indexando nuevos cursos cada semana, reparar bugs, mejorar las interfaces y facilitar el proceso de búsqueda de cualquier curso gratis que necesites.',
                          style: TextStyle(
                              fontSize: 16.0, // Esto sería similar a H2 en HTML
                              color: darkTheme == true
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '¿Cómo conseguir monedas?',
                        style: TextStyle(
                            fontSize: 22.0, // Esto sería similar a H1 en HTML
                            color:
                                darkTheme == true ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Toca en el botón "Conseguir monedas" y espera a que se cargue un pequeño anuncio. Se entregan 2 monedas por cada uno que veas. De esta forma, reunirás la cantidad necesaria para eliminar los que se muestran antes de entrar a un curso.',
                          style: TextStyle(
                              fontSize: 16.0, // Esto sería similar a H2 en HTML
                              color: darkTheme == true
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '¿Cómo canjear las monedas?',
                        style: TextStyle(
                            fontSize: 22.0, // Esto sería similar a H1 en HTML
                            color:
                                darkTheme == true ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Una vez hayas alcanzado 12 monedas, puedes canjearlas para la eliminación del anuncio que se muestra antes de entrar a un curso. Para ello debes tocar en el botón "Canjear".',
                          style: TextStyle(
                              fontSize: 16.0, // Esto sería similar a H2 en HTML
                              color: darkTheme == true
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 200),
              ])),
        ]));
  }

  void showDialogConseguirMonedas() {
    String img =
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiCyyAMG25ddLINbUdES8PpLm8mI2BWnyJIryDtqzXzJKGHYQggIjwYpEZJUqC45nqSvS1D2hiNmMpRjbHHoMsyo7ygWnYXWHEPsNp0Y3xVPgpnLwOWTc7e7kCO0MZMCVL3R4TH_HIERMx_rzHBtv7RYWTsoR2JyKyU6AaKNIdeTLHwCGrvbPcRQw/w320-h240/coins.gif';
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
              image: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
              ),
              title: Text(
                'Obtener monedas',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              description: Text(
                'Puedes obtener 2 monedas activando un corto anuncio. 🕓\n\nAl terminar serán cargadas a tu monedero actual.',
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
              buttonCancelText: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkText: const Text(
                'De acuerdo',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkColor: Colors.green,
              onOkButtonPressed: () async {
                //validate if networf conection exist
                try {
                  //validating internet conection
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    print('connected');

                    showRewardedAd(); //show ad
                    //Navigator.pop(context); //close dialog
                  }
                  //if doesnt exist conection, then show toast to advert
                } on SocketException catch (_) {
                  //toast no conection exist
                  Fluttertoast.showToast(
                    msg:
                        "No estas conectado a internet.\nUsa Wi-Fi o datos moviles.", // message
                    toastLength: Toast.LENGTH_LONG, // length
                    gravity: ToastGravity.CENTER, // location
                  );
                }
                Navigator.pop(context);
              },
              onCancelButtonPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }

  Future<void> showDialogMonedasObtenidas() async {
    //Read all coins saved
    SharedPreferences coinsPrefs = await SharedPreferences.getInstance();

    int actualCoins = coinsPrefs.getInt('cursinCoinsSHP') ?? 2;

    String img =
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiCyyAMG25ddLINbUdES8PpLm8mI2BWnyJIryDtqzXzJKGHYQggIjwYpEZJUqC45nqSvS1D2hiNmMpRjbHHoMsyo7ygWnYXWHEPsNp0Y3xVPgpnLwOWTc7e7kCO0MZMCVL3R4TH_HIERMx_rzHBtv7RYWTsoR2JyKyU6AaKNIdeTLHwCGrvbPcRQw/w320-h240/coins.gif';
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
              image: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
              ),
              title: Text(
                '¡Enhorabuena!',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              description: actualCoins < 12
                  ? Text(
                      'Has conseguido 2 monedas más.',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    )
                  : Text(
                      'Has eliminado los anuncios que se muestran antes de ir a un curso',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
              buttonOkText: const Text(
                'De acuerdo',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkColor: Colors.green,
              onOkButtonPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }

  Future<void> showDialogCanjearMonedas() async {
    //Read all coins saved
    SharedPreferences coinsPrefs = await SharedPreferences.getInstance();

    int actualCoins = coinsPrefs.getInt('cursinCoinsSHP') ?? 2;

    String img =
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiCyyAMG25ddLINbUdES8PpLm8mI2BWnyJIryDtqzXzJKGHYQggIjwYpEZJUqC45nqSvS1D2hiNmMpRjbHHoMsyo7ygWnYXWHEPsNp0Y3xVPgpnLwOWTc7e7kCO0MZMCVL3R4TH_HIERMx_rzHBtv7RYWTsoR2JyKyU6AaKNIdeTLHwCGrvbPcRQw/w320-h240/coins.gif';
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: NetworkGiffDialog(
              image: CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
              ),
              title: actualCoins < 12
                  ? Text('¡Oops!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))
                  : Text(
                      '¡Enhorabuena!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
              description: actualCoins < 12
                  ? Text(
                      'Necesitas al menos 12 monedas para eliminar los anuncios.',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    )
                  : Text(
                      'Has eliminado los anuncios que se muestran antes de ir a un curso.',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
              buttonOkText: const Text(
                'De acuerdo',
                style: TextStyle(color: Colors.white),
              ),
              buttonOkColor: Colors.green,
              onOkButtonPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) => Container(),
    );
  }
}
