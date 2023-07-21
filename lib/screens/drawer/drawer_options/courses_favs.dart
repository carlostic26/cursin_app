import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/ads_ids/ads.dart';
import 'package:cursin/model/dbhelper.dart';
import 'package:cursin/screens/drawer/drawer.dart';
import 'package:cursin/screens/drawer/drawer_options/certificados.dart';
import 'package:cursin/screens/webview/courses_webview.dart';
import 'package:cursin/screens/drawer/drawer_options/categorias_select.dart';
import 'package:cursin/screens/drawer/drawer_options/search_courses.dart';
import 'package:cursin/screens/infoScreens/agradecimientos.dart';
import 'package:cursin/model/curso_lista_model.dart';
import 'package:cursin/screens/detail_course.dart';
import 'package:cursin/screens/infoScreens/info_app.dart';
import 'package:cursin/screens/drawer/drawer_options/ultimos_cursos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mailto/mailto.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursesFavs extends StatefulWidget {
  const CoursesFavs({super.key});

  @override
  State<CoursesFavs> createState() => _CoursesFavsState();
}

class _CoursesFavsState extends State<CoursesFavs> {
  late DatabaseHandler handler;
  Future<List<curso>>? _curso;

  //ads variables
  late BannerAd staticAd;
  bool staticAdLoaded = false;

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

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  bool? darkTheme1;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme1 = themePrefs.getBool('isDarkTheme');
    });
  }

  void updateDarkTheme(bool value) {
    setState(() {
      darkTheme1 = value;
    });
  }

  @override
  void initState() {
    //es necesario inicializar el sharedpreferences tema, para que la variable book darkTheme esté inicializada como la recepcion del valor del sharedpreferences
    getSharedThemePrefs();
    _loadAdaptativeAd();

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {
        _curso = getListFav();
      });
    });

    super.initState();
  }

  void onClickedNotifications(String? payload) {
    Restart.restartApp();
  }

  Future<List<curso>> getListFav() async {
    return await handler.misFavoritos();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _curso = getListFav();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Navigator.pop(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CategoriasSelectCards()),
        );
        super.dispose();
        return true;
      },
      child: Scaffold(
        backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,
        appBar: AppBar(
          title: Text(
            "Cursos guardados",
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
                        catProviene: 'sinCategoria',
                        puntoPartida: 'home',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: FutureBuilder<List<curso>>(
          future: _curso,
          builder: (BuildContext context, AsyncSnapshot<List<curso>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print('error: ${snapshot.error}');
              return Text('No tienes ningun curso guardado.');
            } else {
              var items = snapshot.data ?? <curso>[];

              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 1.0,
                  vertical: 1.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetail(
                              td: items[index],
                              puntoPartida: 'fav',
                              catProvino: 'sinCategoria',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: darkTheme1 == true
                                      ? Colors.grey[850]
                                      : Colors
                                          .white, // Your desired background color
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  child: new Row(
                                    children: <Widget>[
                                      //IMAGEN DEL CURSO
                                      Stack(
                                        children: [
                                          //IMAGEN DEL CURSO
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.5,
                                                0.5,
                                                0.0,
                                                0.5), //borde de la imagen
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    items[index].imgcourse,
                                                width: 120.0,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          // ICONO EN LA ESQUINA SUPERIOR DERECHA
                                          Positioned(
                                            top: 3,
                                            right: 0,
                                            child: ClipOval(
                                              child: Container(
                                                color:
                                                    Color.fromARGB(0, 0, 0, 0),
                                                child: CachedNetworkImage(
                                                  imageUrl: items[index]
                                                              .emision ==
                                                          'Con certificado gratis'
                                                      ? 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRLFEHYVoLlL4hmFrf_qEamOxDChdKy-7qYGmeT_ca1X62LuytAVqc2gXWDemQpOe1Kf-2FUQElVYx8583Kk12sN7siuSabRY-iDCDfAqdW9mZEWQF-EAcsAhLM08leySmOYu6T-SgxuswHvxjcXgEdT8vWGcQgi1dQ_zcUhXoGhW4eg--sG1-tWyg/s1600/0623.png'
                                                      : 'https://blogger.googleusercontent.com/img/a/AVvXsEjHD0pCtfjYChXbmlmbbZ-xHsf0EH1Jfzx2j7utG-3_3Rz5UvftUT9SfxAJ8iw3R59mQtN6pwk7iY6M0OO9I3eMzLqzIQeCIbBWoA6U3GtuVh1UWsHYANbPPKQWHmd41p3lAmXGexXG62eEtmmbdsldbmRyemO2B1zp4SrCslPg8wvxd9PbHWaFbA',
                                                  width: 30.0,
                                                  height: 30.0,
                                                  fit: BoxFit.contain,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Expanded(
                                          //para que no haya overflow
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 1.0, 1.0, 1.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  items[index].title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    //COLOR DEL TEXTO TITULO
                                                    color: Color.fromARGB(
                                                        255, 53, 164, 255),
                                                  ),
                                                ),
                                                //SizedBox(height: 2),
                                                Row(
                                                  children: [
                                                    new Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            //entidad del curso
                                                            Text(
                                                              items[index]
                                                                  .entidad,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: darkTheme1 ==
                                                                        true
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            175,
                                                                            175,
                                                                            175)
                                                                    : Colors.grey[
                                                                        850],
                                                              ),
                                                            ),

                                                            //emision
                                                            Text(
                                                                items[index]
                                                                    .emision,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontSize: 10,
                                                                    color: darkTheme1 == true && items[index].emision == 'Con certificado gratis'
                                                                        ? Colors.greenAccent
                                                                        : darkTheme1 == false && items[index].emision == 'Con certificado gratis'
                                                                            ? Color.fromARGB(255, 1, 77, 40)
                                                                            : darkTheme1 == false || darkTheme1 == true && items[index].emision != 'Con certificado gratis'
                                                                                ? Colors.grey
                                                                                : null,
                                                                    fontWeight: FontWeight.normal)),
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
        bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
            ? Container(
                color: Color.fromARGB(0, 33, 149, 243),
                width: _anchoredAdaptiveAd!.size.width.toDouble(),
                height: _anchoredAdaptiveAd!.size.height.toDouble(),
                child: AdWidget(ad: _anchoredAdaptiveAd!),
              )
            : Container(
                color: Color.fromARGB(0, 33, 149,
                    243), // Aquí se establece el color del Container
                width: _anchoredAdaptiveAd!.size.width.toDouble(),
                height: _anchoredAdaptiveAd!.size.height.toDouble(),
                child: AdWidget(ad: _anchoredAdaptiveAd!),
              ),
        drawer: drawerCursin(context: context),
      ),
    );
  }
}
