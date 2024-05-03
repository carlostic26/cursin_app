import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/infrastructure/localdb/cursos_db.dart';
import 'package:cursin/screens/detail_course.dart';
import 'package:cursin/screens/drawer/drawer_options/search_courses.dart';
import 'package:flutter/material.dart';
import '../../../infrastructure/localdb/cursos_PROG_db.dart';
import '../../../infrastructure/localdb/cursos_TIC_db.dart';
import '../../screens.dart';

class UltimosCursosLista extends StatefulWidget {
  @override
  State<UltimosCursosLista> createState() => _UltimosCursosListaState();
}

const int maxAttempts = 3;

class _UltimosCursosListaState extends State<UltimosCursosLista> {
  late DatabaseHandlerGen handler;
  Future<List<curso>>? _curso;

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
      //print('Unable to get height of anchored banner.');
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
              // When the ad is loaded, get the ad size and use it to set
              // the height of the ad container.
              _anchoredAdaptiveAd = ad as BannerAd;
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          //print('Anchored adaptive banner failedToLoad: $error');
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

  bool? darkTheme = true;

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
    super.initState();
    getSharedThemePrefs();
    //_loadAdaptativeAd();
    handler = DatabaseHandlerGen();
    handler.initializeDB().whenComplete(() async {
      setState(() {
        //_curso = getList();
        _curso = getAllListCourses();
      });
    });
  }

  void onClickedNotifications(String? payload) {
    Restart.restartApp();
  }

  Future<List<curso>> getList() async {
    return await handler.course();
  }

  Future<List<curso>> getAllListCourses() async {
    List<curso> courses = [];

    // Buscar en la base de datos de Programación
    DatabaseProgHandler handlerProg = DatabaseProgHandler();
    courses.addAll(await handlerProg.todos());

    // Buscar en la base de datos genérica
    DatabaseHandlerGen handler = DatabaseHandlerGen();
    courses.addAll(await handler.course());

    DatabaseTICHandler handlerTIC = DatabaseTICHandler();
    courses.addAll(await handlerTIC.todos());

    // ...

    // Eliminar duplicados
    courses = uniqueCourseList(courses);

    // Desordenar la lista de cursos
    courses.shuffle();

    return courses;
  }

  List<curso> uniqueCourseList(List<curso> courses) {
    var uniqueCourses = <curso>[];

    for (var course in courses) {
      if (!uniqueCourses.any((element) =>
          element.title == course.title &&
          element.entidad == course.entidad /* y otros campos relevantes */)) {
        uniqueCourses.add(course);
      }
    }

    return uniqueCourses;
  }

  Future<void> _onRefresh() async {
    setState(() {
      _curso = getList();
    });
  }

  bool welcomShowed = true;

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
        title: Text(
          "Últimos cursos",
          style: TextStyle(
            color: darkTheme == false ? Colors.grey[850] : Colors.white,
            fontSize: 16.0,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
              icon: Icon(Icons.search),
              onPressed: () {
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
      body: FutureBuilder<List<curso>>(
        future: _curso,
        builder: (BuildContext context, AsyncSnapshot<List<curso>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
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
                                color: darkTheme == true
                                    ? Colors.grey[850]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                child: new Row(
                                  children: <Widget>[
                                    //IMAGEN DEL CURSO
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.5, 0.5, 0.0, 0.5),
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
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              )),
                                        ),
                                        // ICONO EN LA ESQUINA SUPERIOR DERECHA
                                        Positioned(
                                          top: 3,
                                          right: 0,
                                          child: ClipOval(
                                            child: Container(
                                              color: Color.fromARGB(0, 0, 0, 0),
                                              child: CachedNetworkImage(
                                                imageUrl: items[index]
                                                            .emision ==
                                                        'Con certificado gratis'
                                                    ? 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRLFEHYVoLlL4hmFrf_qEamOxDChdKy-7qYGmeT_ca1X62LuytAVqc2gXWDemQpOe1Kf-2FUQElVYx8583Kk12sN7siuSabRY-iDCDfAqdW9mZEWQF-EAcsAhLM08leySmOYu6T-SgxuswHvxjcXgEdT8vWGcQgi1dQ_zcUhXoGhW4eg--sG1-tWyg/s1600/0623.png'
                                                    : 'https://blogger.googleusercontent.com/img/a/AVvXsEjHD0pCtfjYChXbmlmbbZ-xHsf0EH1Jfzx2j7utG-3_3Rz5UvftUT9SfxAJ8iw3R59mQtN6pwk7iY6M0OO9I3eMzLqzIQeCIbBWoA6U3GtuVh1UWsHYANbPPKQWHmd41p3lAmXGexXG62eEtmmbdsldbmRyemO2B1zp4SrCslPg8wvxd9PbHWaFbA',
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
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
                                              8.0, 0, 1.0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                items[index].title,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: darkTheme == false
                                                      ? Colors.grey[450]
                                                      : Colors.white,
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .blue),
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
                                                                  color: darkTheme ==
                                                                              true &&
                                                                          items[index].emision ==
                                                                              'Con certificado gratis'
                                                                      ? Colors
                                                                          .greenAccent
                                                                      : darkTheme == false &&
                                                                              items[index].emision ==
                                                                                  'Con certificado gratis'
                                                                          ? Color.fromARGB(
                                                                              255,
                                                                              1,
                                                                              77,
                                                                              40)
                                                                          : darkTheme == false || darkTheme == true && items[index].emision != 'Con certificado gratis'
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
      drawer: drawerCursin(
        context: context,
        darkTheme: darkTheme!,
      ),
    );
  }
}
