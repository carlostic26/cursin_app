import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/ads_ids/ads.dart';
import 'package:cursin/model/curso_lista_model.dart';
import 'package:cursin/screens/detail_course.dart';
import 'package:cursin/model/dbhelper.dart';
import 'package:cursin/screens/drawer/drawer_options/categorias_select.dart';
import 'package:cursin/screens/drawer/drawer_options/search_courses.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class categorias extends StatefulWidget {
  // se requiere recibir: 1. Nombre de categoria. 2. Pantalla de donde se proviene
  categorias({required this.catProviene, required this.puntoPartida});
  late String catProviene;
  late String puntoPartida;

  @override
  _categoriaState createState() => _categoriaState();
}

class _categoriaState extends State<categorias> {
  late DatabaseHandler handler;
  Future<List<curso>>? _curso;

  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptativeAd();
  }

  Future<void> _loadAdaptativeAd() async {
    CursinAdsIds Cursin_ads = CursinAdsIds();
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
      adUnitId: Cursin_ads.banner_adUnitId,
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

  // get email to check login sesion
  String email = "";
  var children;

  late bool tapFav;

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

    _loadAdaptativeAd();
    tapFav = false;

    switch (widget.catProviene) {
      case "Transporte":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListTransporte();
            });
          });
        }
        break;
      case "Ingenieria":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListIngenieria();
            });
          });
        }
        break;
      case "Trabajos Varios":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListTrabajosVarios();
            });
          });
        }
        break;

      case "Cocina y alimentos":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListCocina();
            });
          });
        }
        break;

      case "Agropecuario":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListAgropecuario();
            });
          });
        }
        break;

      case "Marketing":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListMarketing();
            });
          });
        }
        break;

      case "Razonamiento":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListRazonamiento();
            });
          });
        }
        break;

      case "Belleza":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListBelleza();
            });
          });
        }
        break;

      case "Artes":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListArtes();
            });
          });
        }
        break;

      case "Finanzas":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListFinanzas();
            });
          });
        }
        break;

      case "Salud":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListSalud();
            });
          });
        }
        break;

      case "Idiomas":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListIdiomas();
            });
          });
        }
        break;

      case "Programacion":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListProgramacion();
            });

            SharedPreferences prefs = await SharedPreferences.getInstance();
          });
        }
        break;

      case "TIC":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListIT();
            });
          });
        }
        break;

      case "Profesionales":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListProfesionales();
            });
          });
        }
        break;

      case "Ciberseguridad":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListSeguridadInformatica();
            });
          });
        }
        break;

      case "Sociales":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListSociales();
            });
          });
        }
        break;

      case "Crypto":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListCrypto();
            });
          });
        }
        break;

      case "IA":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListIA();
            });
          });
        }
        break;

      case "musica":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListMusica();
            });
          });
        }
        break;

      case "Ciencia y Análisis de Datos":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListDatos();
            });
          });
        }
        break;

      case "Otros":
        {
          handler = DatabaseHandler();
          handler.initializeDB().whenComplete(() async {
            setState(() {
              _curso = getListOtros();
            });
          });
        }
        break;
    }

    super.initState();
  }

  //Methods that receive the list select from dbhelper

  Future<List<curso>> getListTransporte() async {
    return await handler.categoriaTransporte();
  }

  Future<List<curso>> getListIngenieria() async {
    return await handler.categoriaIngenieria();
  }

  Future<List<curso>> getListTrabajosVarios() async {
    return await handler.categoriaTrabajos();
  }

  Future<List<curso>> getListCocina() async {
    return await handler.categoriaCocina();
  }

  Future<List<curso>> getListAgropecuario() async {
    return await handler.categoriaAgropecuario();
  }

  Future<List<curso>> getListMarketing() async {
    return await handler.categoriaMarketing();
  }

  Future<List<curso>> getListRazonamiento() async {
    return await handler.categoriaRazonamiento();
  }

  Future<List<curso>> getListBelleza() async {
    return await handler.categoriaBelleza();
  }

  Future<List<curso>> getListArtes() async {
    return await handler.categoriaArtes();
  }

  Future<List<curso>> getListFinanzas() async {
    return await handler.categoriaFinanzas();
  }

  Future<List<curso>> getListSalud() async {
    return await handler.categoriaSalud();
  }

  Future<List<curso>> getListIdiomas() async {
    return await handler.categoriaIdiomas();
  }

  Future<List<curso>> getListProgramacion() async {
    return await handler.categoriaProgramacion();
  }

  Future<List<curso>> getListIT() async {
    return await handler.categoriaTIC();
  }

  Future<List<curso>> getListProfesionales() async {
    return await handler.categoriaProfesionales();
  }

  Future<List<curso>> getListSeguridadInformatica() async {
    return await handler.categoriaSeguridadInformatica();
  }

  Future<List<curso>> getListSociales() async {
    return await handler.categoriaSociales();
  }

  Future<List<curso>> getListCrypto() async {
    return await handler.categoriaCrypto();
  }

  Future<List<curso>> getListIA() async {
    return await handler.categoriaIA();
  }

  Future<List<curso>> getListMusica() async {
    return await handler.categoriaMusica();
  }

  Future<List<curso>> getListDatos() async {
    return await handler.categoriaCienciaDatos();
  }

  Future<List<curso>> getListOtros() async {
    return await handler.categoriaOtros();
  }

  Future<void> _onRefresh() async {
    setState(() {
      //hacemos un switch para que sepa que cateogira es la que debe refrescar

      switch (widget.catProviene) {
        case "Transporte":
          {
            _curso = getListTransporte();
          }
          break;

        case "Ingenieria":
          {
            _curso = getListIngenieria();
          }
          break;
        case "Trabajos Varios":
          {
            _curso = getListTrabajosVarios();
          }
          break;

        case "Cocina y alimentos":
          {
            _curso = getListCocina();
          }
          break;

        case "Agropecuario":
          {
            _curso = getListAgropecuario();
          }
          break;

        case "Marketing":
          {
            _curso = getListMarketing();
          }
          break;

        case "Razonamiento":
          {
            _curso = getListRazonamiento();
          }
          break;

        case "Belleza":
          {
            _curso = getListBelleza();
          }
          break;

        case "Artes":
          {
            _curso = getListArtes();
          }
          break;

        case "Ciberseguridad":
          {
            _curso = getListSeguridadInformatica();
          }
          break;

        case "Finanzas":
          {
            _curso = getListFinanzas();
          }
          break;

        case "Salud":
          {
            _curso = getListSalud();
          }
          break;

        case "Idiomas":
          {
            _curso = getListIdiomas();
          }
          break;

        case "Programacion":
          {
            _curso = getListProgramacion();
          }
          break;

        case "TIC":
          {
            _curso = getListIT();
          }
          break;

        case "Profesionales":
          {
            _curso = getListProfesionales();
          }
          break;

        case "Sociales":
          {
            _curso = getListSociales();
          }
          break;

        case "Crypto":
          {
            _curso = getListCrypto();
          }
          break;

        case "IA":
          {
            _curso = getListIA();
          }
          break;

        case "musica":
          {
            _curso = getListMusica();
          }
          break;

        case "Ciencia y Análisis de Datos":
          {
            _curso = getListDatos();
          }
          break;

        case "Otros":
          {
            _curso = getListOtros();
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  CategoriasSelectCards()), // Categoria Select no necesita ningun argumento, ya que es la pantalla inicial
        );
        super.dispose();

        return true;
      },
      child: Scaffold(
        backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,
        floatingActionButton: FloatingButtonCondition(context),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                //Navigator.of(context).pop(); //SE COMENTAREA ESTA LINEA PORQUE PRODUCE ERROR AL HABER 2 RUTAS DE NAVIGATOR
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => CategoriasSelectCards()));
              }),
          title: Text(
            "" + widget.catProviene,
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
                        catProviene: widget.catProviene,
                        puntoPartida: 'categorias',
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
                              //enviamos 3 parametros que nos lo pide el Course Detail, ya que,
                              //1. Es el index de curso.
                              //2. nombre de pantalla actual
                              //3. Que categoria estamos
                              td: items[index],
                              puntoPartida: "categorias",
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
      ),
    );
  }

  void _showDialogDigitalizados(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sigue a Digitalizados",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Aprende e infórmate de blockchain y cryptomonedas de una manera entretenida con Digitalizados',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ]),
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Seguir',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      //when user press "ok" dismiss dialog
                      onPressed: () {
                        Navigator.pop(context);
                        launch(
                            'https://youtube.com/channel/UC6MAaY6M7EqWkMIp_uAlEJg');
                      }),
                )
              ]);
        });
  }

  // ignore: non_constant_identifier_names
  FloatingButtonCondition(BuildContext context) {
    if (widget.catProviene == "Crypto") {
      return FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => _showDialogDigitalizados(context));
    } else {
      return null;

      /* FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showDialogAddCourse(context)); */
    }
  }
}
