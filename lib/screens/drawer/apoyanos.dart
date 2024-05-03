import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/screens/screens.dart';
import 'package:flutter/material.dart';

class apoyanosScreen extends StatefulWidget {
  const apoyanosScreen({super.key});

  @override
  State<apoyanosScreen> createState() => _apoyanosScreenState();
}

const int maxAttempts = 2;

class _apoyanosScreenState extends State<apoyanosScreen> {
  int enterAcces = 0;
  bool? darkTheme;

  RewardedAd? rewardedAd;
  int rewardedAdAttempts = 0;

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

  void showRewardedAd() {
    if (rewardedAd == null) {
      if (enterAcces <= 2) {
        Fluttertoast.showToast(
          msg: "¡Oops! Algo salió mal. Intentalo de nuevo.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );

        enterAcces++;
      } else {
        if (enterAcces >= 3) {
          Fluttertoast.showToast(
            msg: "Vuelve más tarde.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
        enterAcces++;
      }

      return;
    }

    rewardedAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) async {
      Fluttertoast.showToast(
        msg: "¡Gracias por tu apoyo!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      // print('failed to show the adv $ad');

      //Toast diciendo: no se han podido cargar los anuncios.\n Asegurate de tener una buena conexión a internet, volver a abrir la App o intentar abrir el curso mas tarde, cuando los anuncios estén cargados en tu telefono.
      Fluttertoast.showToast(
        msg:
            "No se han podido cargar los anuncios.\nIntentalo de nuevo en 5 segundos",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      createRewardedAd();
    });

    rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      // print('reward video ${reward.amount} ${reward.type}');
    });
    rewardedAd = null;
  }

  @override
  void initState() {
    super.initState();
    createRewardedAd();
    getSharedThemePrefs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createRewardedAd();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Apóyanos",
            style: TextStyle(
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
              fontSize: 16.0,
            ),
          ),
          centerTitle: true,
          actions: [],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    'Hemos invertido cientos de horas y esfuerzo en crear Cursin App.\n\nCon tu ayuda podemos aumentar la cantidad de cursos y categorias cada cierto tiempo, mejorando el diseño de interfaz, y respondiendo a cualquier duda por cualquiera de nuestros canales.'
                        .split('/n')
                        .map((line) => Text(line,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.justify))
                        .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.height * 0.9,
                imageUrl:
                    'https://blogger.googleusercontent.com/img/a/AVvXsEgJvHE-raNFuIaEEtwqOEWeoLpdOgzoxtSwJmEKAQhYOVaaPqfH-GWNuGJ-LhnK6jQQg_U1jff96pZ7WGbKyvh1Q7wPrGhSGVsdFyBfnVYVtVOQTKeJyrQaJgiPOMqmigH1zOSMbB9nfCVneN679beOuZv_gIxkSa1kj2czTpxSRQjfWHBFM1AnKLvc',
                placeholder: (context, url) => Container(
                  height: 30,
                  width: 35,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 1.5,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Cursin App necesita de tu ayuda para seguir existiendo. Apóyanos viendo un anuncio las veces que quieras.',
                style: TextStyle(
                    color: darkTheme == true ? Colors.white : Colors.black),
              ),
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
                    watchAd();
                  },
                  icon: Icon(
                    Icons.visibility,
                    size: 20.0,
                    color: Colors.white, // Cambia el color del ícono a blanco
                  ),
                  label: Text(
                    'Ver un anuncio',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Cambia el color del botón a verde
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Sólo te tomará unos segundos',
                style: TextStyle(
                    color: darkTheme == true ? Colors.grey : Colors.black,
                    fontSize: 9),
              ),
            )
          ],
        ));
  }

  void watchAd() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('\n\n\n\nREWARDED ATTEMP\n\n\n\n');
        showRewardedAd();
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg:
            "No estás conectado a internet.\nConéctate a Wi-Fi o datos móviles.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
