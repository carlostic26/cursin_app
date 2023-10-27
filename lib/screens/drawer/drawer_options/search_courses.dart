// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/utils/ads_ids/ads.dart';
import 'package:cursin/model/curso_lista_model.dart';
import 'package:cursin/screens/detail_course.dart';
import 'package:cursin/infrastructure/models/localdb/cursosdb_sqflite.dart';
import 'package:cursin/screens/drawer/drawer_options/menu_categoria.dart';
import 'package:cursin/screens/drawer/drawer_options/listado_por_categoria.dart';
import 'package:cursin/screens/drawer/drawer_options/ultimos_cursos.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class searchedCourses extends StatefulWidget {
  searchedCourses(
      {required this.catProviene,
      required this.puntoPartida,
      this.palabraBusqueda});

  late String puntoPartida;
  late String catProviene;
  late String? palabraBusqueda;

  @override
  _searchedCoursesState createState() => _searchedCoursesState();
}

class _searchedCoursesState extends State<searchedCourses> {
  late DatabaseHandler handler;
  Future<List<curso>>? _todo;

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

  final TextEditingController searchController = TextEditingController();

  bool isExcecuted = false;

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

  @override
  void initState() {
    //es necesario inicializar el sharedpreferences tema, para que la variable book darkTheme esté inicializada como la recepcion del valor del sharedpreferences
    getSharedThemePrefs();

    if (widget.palabraBusqueda != null) {
      searchCourse(widget.palabraBusqueda.toString());
    }
  }

  Future<List<curso>> getListCoursesFound(query) async {
    return await handler.coursesResultQuery(query);
  }

  String courseToSearch = '';
  String contenedorString = '';

  @override
  Widget build(BuildContext context) {
    _loadAdaptativeAd();
    return WillPopScope(
      onWillPop: () async {
        //home es ultimo cursos agregados
        if (widget.puntoPartida == "home") {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => UltimosCursosLista()),
          );
        }

        if (widget.puntoPartida == "categorias_select") {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    CategoriasSelectCards()), // Categoria Select no necesita ningun argumento, ya que es la pantalla inicial
          );
        }

        if (widget.puntoPartida == "categorias") {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => categorias(
                      catProviene: widget.catProviene,
                      puntoPartida: 'search',
                    )),
          );
        }

        return true;
      },
      child: Scaffold(
        //no color backg cuz the backg is an image
        backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          title: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              searchCourse('');
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.palabraBusqueda != null &&
                      widget.palabraBusqueda.toString().isNotEmpty
                  ? widget.palabraBusqueda.toString()
                  : 'Ej: java, finanzas, inglés, excel, python',
              hintStyle: TextStyle(
                color: Color.fromARGB(130, 255, 255, 255),
                fontSize: 12,
              ),
            ),
            controller: searchController,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  searchCourse('');
                })
          ],
        ),
        body: isExcecuted
            ? searchedData()
            : Container(
                child: Center(
                  child: Text(
                    'Resultado...',
                    style: TextStyle(
                        color: darkTheme1 == true ? Colors.white : Colors.black,
                        fontSize: 15.0),
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
      ),
    );
  }

  Widget searchedData() {
    return FutureBuilder<List<curso>>(
      future: _todo,
      builder: (BuildContext context, AsyncSnapshot<List<curso>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text(
                'Error. Vuelve a ingresar.',
                style: TextStyle(
                    color: darkTheme1 == true ? Colors.white : Colors.black,
                    fontSize: 15.0),
              ),
            ),
          );
        } else {
          var items = snapshot.data ?? <curso>[];
          if (items.isEmpty) {
            // Handle case when items is empty
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'No se encontró ningún curso. \n\nAsegúrate de buscar únicamente con palabra clave. Ejemplo: php, inglés, excel, java, música...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: darkTheme1 == true ? Colors.white : Colors.black,
                        fontSize: 15.0),
                  ),
                ),
              ),
            );
          } else {
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
                            puntoPartida: 'search',
                            catProvino: widget.catProviene,
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
                                    new Container(
                                      child: Expanded(
                                        //para que no haya overflow
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 1.0, 1.0, 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                items[index].title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  //COLOR DEL TEXTO TITULO
                                                  color: Color.fromARGB(
                                                      255, 53, 164, 255),
                                                ),
                                              ),
                                              SizedBox(height: 5),

                                              //entidad del curso
                                              Text(
                                                items[index].entidad,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: darkTheme1 == true
                                                      ? Color.fromARGB(
                                                          255, 175, 175, 175)
                                                      : Colors.grey[850],
                                                ),
                                              ),

                                              //emision
                                              Text(items[index].emision,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: darkTheme1 == true &&
                                                              items[index]
                                                                      .emision ==
                                                                  'Con certificado gratis'
                                                          ? Colors.greenAccent
                                                          : darkTheme1 ==
                                                                      false &&
                                                                  items[index]
                                                                          .emision ==
                                                                      'Con certificado gratis'
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  1,
                                                                  77,
                                                                  40)
                                                              : darkTheme1 ==
                                                                          false ||
                                                                      darkTheme1 ==
                                                                              true &&
                                                                          items[index].emision !=
                                                                              'Con certificado gratis'
                                                                  ? Colors.grey
                                                                  : null,
                                                      fontWeight:
                                                          FontWeight.normal)),
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
        }
      },
    );
  }

  void searchCourse(String title) {
    if (title != '') {
      contenedorString = title;
    } else {
      contenedorString = searchController.text;
    }

    courseToSearch = contenedorString.replaceAll(" ", "");

    if (courseToSearch != '') {
      //recibe en un objeto _todo los cursos que encontró
      handler = DatabaseHandler();
      handler.initializeDB().whenComplete(() async {
        setState(() {
          //_todo contains the result of courses query
          _todo = getListCoursesFound(courseToSearch);
          isExcecuted = true;
        });
      });
    }
  }
}
