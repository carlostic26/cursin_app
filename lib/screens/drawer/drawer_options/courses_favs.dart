import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/model/dbhelper.dart';
import 'package:cursin/screens/drawer/drawer.dart';
import 'package:cursin/screens/drawer/drawer_options/certificados.dart';
import 'package:cursin/screens/courses_webview.dart';
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

  bool? darkTheme1;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme1 = themePrefs.getBool('isDarkTheme');
    });
  }

  @override
  void initState() {
    //es necesario inicializar el sharedpreferences tema, para que la variable book darkTheme esté inicializada como la recepcion del valor del sharedpreferences
    getSharedThemePrefs();
    loadStaticBannerAd();

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
              return Center(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: RichText(
                      text: TextSpan(
                        text: "No tienes ningún curso guardado por el momento.",
                        style: TextStyle(
                            color: darkTheme1 == true
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              var items = snapshot.data ?? <curso>[];
              if (items.length == 0) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No se encontraron cursos guardados',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                );
              }

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
                        //Navigator.pop(context);
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
                        padding: const EdgeInsets.fromLTRB(7, 5, 1, 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: darkTheme1 == true
                                ? Colors.grey[850]
                                : Colors.white, // Your desired background color
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            child: new Row(
                              children: <Widget>[
                                //IMAGEN DEL CURSO
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(1.0, 1.0,
                                        0.0, 1.0), //borde de la imagen
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CachedNetworkImage(
                                        imageUrl: items[index].imgcourse,
                                        width: 120.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    )),
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
                                                        items[index].entidad,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: darkTheme1 ==
                                                                  true
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  175,
                                                                  175,
                                                                  175)
                                                              : Colors
                                                                  .grey[850],
                                                        ),
                                                      ),

                                                      //emision
                                                      Text(items[index].emision,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: darkTheme1 ==
                                                                          true &&
                                                                      items[index]
                                                                              .emision ==
                                                                          'Con certificado gratis'
                                                                  ? Colors
                                                                      .greenAccent
                                                                  : darkTheme1 ==
                                                                              false &&
                                                                          items[index].emision ==
                                                                              'Con certificado gratis'
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          1,
                                                                          77,
                                                                          40)
                                                                      : darkTheme1 == false ||
                                                                              darkTheme1 == true &&
                                                                                  items[index].emision !=
                                                                                      'Con certificado gratis'
                                                                          ? Colors
                                                                              .grey
                                                                          : null,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
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
                    );
                  },
                ),
              );
            }
          },
        ),
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
        drawer: drawerCursin(context: context),
      ),
    );
  }
}
