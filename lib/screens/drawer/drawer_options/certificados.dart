import 'package:cursin/screens/drawer/drawer_options/carruselCertifiedWidget.dart';
import 'package:flutter/material.dart';
import '../../../screens.dart';

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

  bool? isNotifShowed;
  Color darkColor = Colors.grey[850]!;
  bool? darkTheme;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme = themePrefs.getBool('isDarkTheme');
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

    getSharedThemePrefs();
  }

  @override
  Widget build(BuildContext context) {
    _loadAdaptativeAd();
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
        iconTheme: IconThemeData(
          color: darkTheme == false ? Colors.grey[850] : Colors.white,
        ), // Cambia el color del botón

        title: Text(
          "Certificados",
          style: TextStyle(
            color: darkTheme == false ? Colors.grey[850] : Colors.white,
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
                    builder: (context) => searchedCourses(),
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
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Text(
                'Estos son algunos certificados o diplomas que puedes obtener usando Cursin App como herramienta para buscar cursos gratis online de toda internet.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: darkTheme == true ? Colors.white : Colors.grey[850],
                ),
              ),
            ),
            SizedBox(height: 10),
            carruselCertifiedScreen(),
            SizedBox(height: 40),
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
                          Text('¿Cómo reclamo mi certificado?',
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: darkTheme == true
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 10.0),
                          Text(
                              'Si en la tabla de información del curso dentro de Cursin, la emisión del certificado se encuentra marcada como "con certificado gratis" significa que no tendrás que pagar absolutamente nada por dicho diploma. En caso que sea "Sin certificado" significa que puede que no emitan ningún certificado, o que cobren por ello.\n\nCada plataforma dueña de los cursos gratis es autónoma en la manera de emitir los certificados de finalización.\n\nLa mayoria de las plataformas libera los certificados una vez se alcanza el 100% de todas las clases o lecciones que conforman el curso.\n\nDependiendo de la plataforma que emite el curso, es posible que el certificado lo envíen directamente a tu correo electronico asociado, o descargar dicho diploma directamente desde el mismo sitio. Por lo tanto, te recomendamos que abras el curso con el navegador si deseas descargar el certificado en tu dispositivo.',
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
            SizedBox(height: 40),
          ],
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
}
