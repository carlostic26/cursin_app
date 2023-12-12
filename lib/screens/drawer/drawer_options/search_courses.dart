import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/infrastructure/models/localdb/cursos_PROG_db.dart';
import 'package:cursin/infrastructure/models/localdb/cursos_TIC_db.dart';
import 'package:cursin/screens/detail_course.dart';
import 'package:flutter/material.dart';
import '../../../screens.dart';

// ignore: must_be_immutable
class searchedCourses extends StatefulWidget {
  searchedCourses({this.palabraBusqueda});

  late String? palabraBusqueda;

  @override
  _searchedCoursesState createState() => _searchedCoursesState();
}

class _searchedCoursesState extends State<searchedCourses> {
  late DatabaseHandler handler;
  late DatabaseTICHandler handlerTIC;
  late DatabaseProgHandler handlerProg;

  // otras bd como DatabaseTICHandler()
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
      adUnitId: cursinAds.banner_adUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
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

  bool? darkTheme;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme = themePrefs.getBool('isDarkTheme');
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedThemePrefs();

    if (widget.palabraBusqueda != null) {
      searchCourse(widget.palabraBusqueda.toString());
    }
  }

  Future<List<curso>> getListCoursesFound(query) async {
    return await handler.coursesResultQueryGeneric(query);
  }

  Future<List<curso>> getAllListCoursesFound(query) async {
    List<curso> courses = [];

    // Buscar en la base de datos genérica
    DatabaseHandler handler = DatabaseHandler();
    courses.addAll(await handler.coursesResultQueryGeneric(query));

    // Buscar en la base de datos de Programación
    DatabaseProgHandler handlerProg = DatabaseProgHandler();
    courses.addAll(await handlerProg.coursesResultQueryProg(query));

    DatabaseTICHandler handlerTIC = DatabaseTICHandler();
    courses.addAll(await handlerTIC.coursesResultQueryTIC(query));

    // ...

    // Eliminar duplicados
    courses = uniqueCourseList(courses);

    return courses;
  }

  /*
    TODO: Del search de unir la lista, hacer lo mismo para la busqueda en lista categoria

  */

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

  String courseToSearch = '';
  String contenedorString = '';

  @override
  Widget build(BuildContext context) {
    _loadAdaptativeAd();
    return Scaffold(
      backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back), // Icono del botón de hamburguesa
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),

        iconTheme: IconThemeData(
          color: darkTheme == false ? Colors.grey[850] : Colors.white,
        ), // Cambia el color del botón

        title: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            searchCourse(value);
          },
          style: TextStyle(
            color: darkTheme == false
                ? Colors.grey[450]
                : Color.fromARGB(150, 255, 255, 255),
          ),
          decoration: InputDecoration(
            hintText: widget.palabraBusqueda != null &&
                    widget.palabraBusqueda.toString().isNotEmpty
                ? widget.palabraBusqueda.toString()
                : 'Ej: sql, finanzas, inglés, excel, python',
            hintStyle: TextStyle(
              color: darkTheme == true ? Colors.grey : Colors.grey[850],
              fontSize: 12,
            ),
          ),
          controller: searchController,
        ),

        centerTitle: true,
        actions: [
          IconButton(
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
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
                      color: darkTheme == true ? Colors.white : Colors.black,
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
          print('Error en FutureBuilder de bd: ${snapshot.error}');
          return Container(
            child: Center(
              child: Text(
                'Error. Vuelve a ingresar.',
                style: TextStyle(
                    color: darkTheme == true ? Colors.white : Colors.black,
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
                    'No se encontró ningún curso. \n\nAsegúrate de buscar únicamente con palabra clave. \nEjemplo: redes, sql, php, inglés, excel, java, música...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: darkTheme == true ? Colors.white : Colors.black,
                        fontSize: 12.0),
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
                                                  color: darkTheme == true
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
                                                      color: darkTheme ==
                                                                  true &&
                                                              items[index]
                                                                      .emision ==
                                                                  'Con certificado gratis'
                                                          ? Colors.greenAccent
                                                          : darkTheme ==
                                                                      false &&
                                                                  items[index]
                                                                          .emision ==
                                                                      'Con certificado gratis'
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  1,
                                                                  77,
                                                                  40)
                                                              : darkTheme ==
                                                                          false ||
                                                                      darkTheme ==
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
          _todo = getAllListCoursesFound(courseToSearch);
          isExcecuted = true;
        });
      });
    }
  }
}
