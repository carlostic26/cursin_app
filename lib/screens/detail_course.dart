import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/screens.dart';
import 'package:cursin/screens/option_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class CourseDetail extends StatefulWidget {
  curso td;

  CourseDetail({required this.td});

  late String puntoPartida;
  late String catProvino;

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

const int maxAttempts = 3;

//clase que muestra una pantalla con toda la informacion y detalles del curso que el usuario desea ver
class _CourseDetailState extends State<CourseDetail> {
  //late DatabaseHandler handler;

  //is a bool that contains when user enter in a course to show ad, if user back, then ad will not showed again by the same course.
  late bool adForCourse;
  bool _isVisible = true;
  late Timer _timer; // Declarar la variable timer aquí

  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      _loadAdaptativeAd();
      createInterstitialAd();
    }
  }

  CursinAdsIds cursinAds = CursinAdsIds();
  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  //initializing intersticial ad
  InterstitialAd? interstitialAd;
  int interstitialAttempts = 0;

  //initializing reward ad
  RewardedAd? rewardedAd;
  int rewardedAdAttempts = 0;

//Creating interstitial
  //not used for the moment
  void createInterstitialAd() {
    InterstitialAd.load(
        // ignore: deprecated_member_use
        adUnitId: cursinAds.interstitial_adUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAttempts = 0;
        }, onAdFailedToLoad: (error) {
          interstitialAttempts++;
          interstitialAd = null;
          // print( '-------------------\n\n\n - failed to load interstitial:\n ${error.message}');

          if (interstitialAttempts <= maxAttempts) {
            createInterstitialAd();
          }
        }));
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      //print('trying to show before loading');
      enterAcces++;

      if (enterAcces < 2) {
        Fluttertoast.showToast(
          msg: "Intentalo de nuevo", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
        );
        createInterstitialAd();
        Navigator.pop(context); //close dialog
      } else if (enterAcces >= 2 && enterAcces < 4) {
        Fluttertoast.showToast(
          msg:
              "Tu telefono no cargó el anuncio.\nVuelve a intentarlo.", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
        );
        createInterstitialAd();
        //Navigator.pop(context); //close dialog
      } else if (enterAcces == 4) {
        Fluttertoast.showToast(
          msg:
              "Necesitas buena conexión. Cambiate a un Wi-Fi más cercano\nIntenta de nuevo.", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
        );
        createInterstitialAd();
        Navigator.pop(context);
      } else if (enterAcces == 5) {
        Fluttertoast.showToast(
          msg:
              "No cuentas con buena conexión o estás usando algun bloqueador. Es necesario que tu teléfono cargue los anuncios.", // message
          toastLength: Toast.LENGTH_LONG, // length
          gravity: ToastGravity.CENTER, // location
        );
      } else if (enterAcces > 5) {
        //si definitivamente no ha cargado despues de 5 intentos, se genera un random al 50% para ingresar

        int number = 0;
        var rng = Random();
        number = rng.nextInt(2); // 50%
        //print("numero aleatorio es: " + number.toString());

        if (number == 1) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  courseOption(
                nameCourse: widget.td.title,
                urlCourse: widget.td.urlcourse,
                imgCourse: widget.td.imgcourse,
                nombreEntidad: widget.td.entidad,
              ),
              transitionDuration:
                  Duration(milliseconds: 500), // Duración de la transición
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => CourseDetail(
                        td: widget.td,
                      )));
        }
        enterAcces = 0;
      }

      _showDialogProblemAds(context);

      return;
    }

    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        //onAdShowedFullScreenContent: (ad) => print('ad showed $ad'),

        //when ad went closes
        onAdDismissedFullScreenContent: (ad) async {
      //set recent course acces, load actual last course
      SharedPreferences lastCourse = await SharedPreferences.getInstance();
      lastCourse.setString('lastCourse', widget.td.title);

      //open screen to select option how to see course
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => courseOption(
                nameCourse: widget.td.title,
                urlCourse: widget.td.urlcourse,
                imgCourse: widget.td.imgcourse,
                nombreEntidad: widget.td.entidad,
              )));

      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      //print('failed to show the ad $ad');
    });

    interstitialAd!.show();
    interstitialAd = null;
  }

  String getCoursesStringShP = "";
  String validadorCursoGuardado = "Guardar curso";
  bool click = false;

  Future<void> getSharedPrefs() async {
    SharedPreferences cursosFavString = await SharedPreferences.getInstance();

    String? coursesFavorites = cursosFavString.getString('coursesFavorites');

    if (coursesFavorites != null) {
      setState(() {
        getCoursesStringShP = coursesFavorites;
      });
    } else {
      // Aquí puedes manejar el caso en que no se obtenga un valor válido
      // Puedes mostrar un aviso, asignar un valor por defecto, o realizar cualquier otra acción necesaria.
    }
  }

  int enterAcces = 0;

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
    super.initState();
    //es necesario inicializar el sharedpreferences tema, para que la variable book darkTheme esté inicializada como la recepcion del valor del sharedpreferences
    getSharedThemePrefs();
    adForCourse = false;
    //load ads
    createInterstitialAd();
    //_loadAdaptativeAd();
    //createRewardedAd();
    getSharedPrefs();
    TimerLuzTablaInfo();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int randNum = 0;
  bool _isAdLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded) {
      _loadAdaptativeAd();
      _isAdLoaded = true;
    }

    return Scaffold(
      backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
        title: Text(
          widget.td.title,
          style: TextStyle(
            color: darkTheme == false ? Colors.grey[850] : Colors.white,
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
              icon: Icon(Icons.share_outlined),
              onPressed: () {
                shareCourse();
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          //vertical: 10,
          horizontal: 8,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),

              Stack(children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(
                        1.0, 1.0, 0.0, 1.0), //borde de la imagen
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.td.imgcourse,
                        width: 400.0,
                        height: 210.0,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          color: Colors.green,
                        )),
                        placeholderFadeInDuration: Duration(milliseconds: 200),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
                // ICONO EN LA ESQUINA SUPERIOR DERECHA
                Positioned(
                  top: 8,
                  right: 3,
                  child: ClipRect(
                    child: Container(
                      color: Color.fromARGB(0, 0, 0, 0),
                      child: CachedNetworkImage(
                        imageUrl: widget.td.emision == 'Con certificado gratis'
                            ? 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjRLFEHYVoLlL4hmFrf_qEamOxDChdKy-7qYGmeT_ca1X62LuytAVqc2gXWDemQpOe1Kf-2FUQElVYx8583Kk12sN7siuSabRY-iDCDfAqdW9mZEWQF-EAcsAhLM08leySmOYu6T-SgxuswHvxjcXgEdT8vWGcQgi1dQ_zcUhXoGhW4eg--sG1-tWyg/s1600/0623.png'
                            : 'https://blogger.googleusercontent.com/img/a/AVvXsEjHD0pCtfjYChXbmlmbbZ-xHsf0EH1Jfzx2j7utG-3_3Rz5UvftUT9SfxAJ8iw3R59mQtN6pwk7iY6M0OO9I3eMzLqzIQeCIbBWoA6U3GtuVh1UWsHYANbPPKQWHmd41p3lAmXGexXG62eEtmmbdsldbmRyemO2B1zp4SrCslPg8wvxd9PbHWaFbA',
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 30,
              ),

              //NOMBRE CURSO
              Text(widget.td.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: darkTheme == true ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),

              SizedBox(
                height: 20,
              ),

              //WidgetTablaInfo(darkTheme: darkTheme, widget: widget),

              AnimatedContainer(
                duration: Duration(milliseconds: 200), // Duración más larga
                decoration: BoxDecoration(
                  color: _isVisible
                      ? Color.fromARGB(90, 117, 117, 117)
                      : Colors.transparent, // Cambiar a transparente
                  borderRadius: BorderRadius.circular(
                      10.0), // Ajusta el valor según lo desees
                ),
                child: WidgetTablaInfo(darkTheme: darkTheme, widget: widget),
              ),

              SizedBox(
                height: 15,
              ),

              //BOTON COMPARTOR CURSP

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          click = !click;
                        });
                        sendSharedPreferences();
                      },
                      icon: Icon(
                        getCoursesStringShP.contains(widget.td.title) == true ||
                                click == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 30.0,
                      ),
                      color: getCoursesStringShP.contains(widget.td.title) ==
                                  true ||
                              click == true
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: IconButton(
                        onPressed: () {
                          shareCourse();
                        },
                        icon: Icon(
                          Icons.share,
                          size: 30.0,
                        ),
                        color: Colors.grey,
                      )),
                  Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: IconButton(
                        onPressed: () {
                          _showDialogToReportProblem(context);
                        },
                        icon: Icon(
                          Icons.bug_report,
                          size: 30,
                        ),
                        color: Colors.grey,
                      )),
                ],
              ),

              SizedBox(
                height: 30,
              ),

              // DESCRIPCION Y DETALLES
              Column(
                children: [
                  RichText(
                      text: TextSpan(
                    text: "Detalles",
                    style: new TextStyle(
                      fontSize: 18.0,
                      color: darkTheme == true ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(50, 138, 138, 138),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                          child: RichText(
                            text: TextSpan(
                                text: descriptionFix(),
                                style: TextStyle(
                                    color: darkTheme == true
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ])),
                ],
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: () async {
                      //Read all coins saved
                      SharedPreferences coinsPrefs =
                          await SharedPreferences.getInstance();

                      int actualCoins =
                          coinsPrefs.getInt('cursinCoinsSHP') ?? 2;

                      //data that ask if the last acces to course is the same course in the moment:
                      SharedPreferences lastCourse =
                          await SharedPreferences.getInstance();
                      lastCourse.getString('lastCourse');

                      if (actualCoins >= 12 ||
                          widget.td.title ==
                              lastCourse.getString('lastCourse')) {
                        //Navigator.pop(context); //close dialog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => courseOption(
                                    nameCourse: widget.td.title,
                                    urlCourse: widget.td.urlcourse,
                                    imgCourse: widget.td.imgcourse,
                                    nombreEntidad: widget.td.entidad,
                                  )),
                        );
                      } else {
                        //show dialog saying that ads keep service of the app
                        showDialogCourse(
                            context,
                            widget.td.imgcourse,
                            widget.td.title,
                            widget.td.entidad,
                            widget.td.urlcourse);

                        //PARA LIVES DE TIKTOK
                        /*Navigator.pop(context); //close dialog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => courseOption(
                                    nameCourse: widget.td.title,
                                    urlCourse: widget.td.urlcourse,
                                    imgCourse: widget.td.imgcourse,
                                    nombreEntidad: widget.td.entidad,
                                  )),
                        );
                        */
                      }
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Ir al curso',
                      style: TextStyle(color: Colors.white),
                    ), // <-- Text
                  ),
                ),
              ),

              SizedBox(
                height: 50,
              ),
            ],
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

  Future<void> _loadAdaptativeAd() async {
    if (_isAdLoaded) {
      return;
    }

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      //print('Unable to get height of anchored banner.');
      return;
    }

    BannerAd loadedAd = BannerAd(
      adUnitId: cursinAds.banner_adUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded =
                true; // Set _isLoaded to true only when ad is loaded successfully.
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );

    try {
      await loadedAd.load();
    } catch (e) {
      //print('Error loading anchored adaptive banner: $e');
      loadedAd.dispose();
    }
  }

  List messageMail = ["", "", "", "", ""];
  late bool valPagCaida = false;
  late bool valPagCaida2 = false;
  late bool valPagCaida3 = false;
  late bool valPagCaida4 = false;
  late bool valPagCaida5 = false;

  bool errorLinkCaido = false,
      errorNoAds = false,
      errorCursoIncorrecto = false,
      errorNoPlayVideo = false,
      errorPideCobro = false;

  Future _mailto() async {
    final mailtoLink = Mailto(
      to: ['cursinapp@gmail.com'],
      cc: [''],
      subject: 'Reporte de falla de un curso',
      body: "Hola. Quiero reportar un problema del " +
          widget.td.title +
          " emitido por " +
          widget.td.entidad +
          "\n" +
          messageMail[0] +
          messageMail[1] +
          messageMail[2] +
          messageMail[3] +
          messageMail[4],
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  _showDialogToReportProblem(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(// StatefulBuilder
              builder: (context, setState) {
            return SimpleDialog(children: [
              Text(
                "¿Qué ha ocurrido?\n",
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 1,
              ),
              CheckboxListTile(
                  title: Text(
                    "Acceso caído al curso, no carga información y/o sale en blanco.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida),
                  onChanged: (valPagCaida) => setState(() {
                        if (!errorLinkCaido) {
                          messageMail[0] =
                              ("\n- Acceso caído al curso, no carga información y/o sale en blanco.\n");
                          errorLinkCaido = true;
                        } else {
                          messageMail[0] = "";
                          errorLinkCaido = false;
                        }
                        this.valPagCaida = valPagCaida!;
                      })),
              CheckboxListTile(
                  title: Text(
                    "Mi telefono no carga los anuncios.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida2),
                  onChanged: (val) => setState(() {
                        if (!errorNoAds) {
                          messageMail[1] =
                              ("\n- Mi telefono no carga los anuncios.\n");
                          errorNoAds = true;
                        } else {
                          messageMail[1] = "";
                          errorNoAds = false;
                        }
                        this.valPagCaida2 = val!;
                      })),
              CheckboxListTile(
                  title: Text(
                    "Algunos videos no se reproducen.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida3),
                  onChanged: (val) => setState(() {
                        if (!errorNoPlayVideo) {
                          messageMail[2] =
                              ("\n- Algunos videos no se reproducen.");
                          errorNoPlayVideo = true;
                        } else {
                          messageMail[2] = "";
                          errorNoPlayVideo = false;
                        }
                        this.valPagCaida3 = val!;
                      })),
              CheckboxListTile(
                  title: Text(
                    "El curso no corresponde al presentado en Cursin.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida4),
                  onChanged: (val) => setState(() {
                        if (!errorCursoIncorrecto) {
                          messageMail[3] =
                              ("\n- El curso no corresponde al presentado en Cursin.\n");
                          errorCursoIncorrecto = true;
                        } else {
                          messageMail[3] = "";
                          errorCursoIncorrecto = false;
                        }
                        this.valPagCaida4 = val!;
                      })),
              CheckboxListTile(
                  title: Text(
                    "Me están cobrando el acceso al curso.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida5),
                  onChanged: (val) => setState(() {
                        if (!errorPideCobro) {
                          messageMail[4] =
                              ("\n- Me están cobrando el acceso al curso.\n\nAdjunto capture de pantalla como evidencia para que lo quiten de la app Cursin lo mas pronto.");
                          errorPideCobro = true;
                        } else {
                          messageMail[4] = "";
                          errorPideCobro = false;
                        }
                        this.valPagCaida5 = val!;
                      })),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      'Reportar',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () {
                      if (errorNoAds) {
                        Navigator.pop(context);
                        _showDialogProblemAds(context);
                      } else if (errorNoPlayVideo) {
                        //Muestra dialogo de problemas reproducir video de un curso
                        Navigator.pop(context);
                        _showDialogVideoNoCarga(context);
                      } else {
                        _mailto();
                      }
                    }),
              ),
            ]);
          });
        });
  }

  void showDialogCourse(
      BuildContext context, String img, title, entidad, urlcourse) {
    showPlatformDialog(
      context: context,
      androidBarrierDismissible: true,
      builder: (_) => BasicDialogAlert(
        content: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '👀 Antes de ir...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 10),
              Text(
                'Puedes tomar este curso dentro o fuera de la app y reanudarlo cuando quieras. Aprovéchalo y disfrútalo. ' +
                    '\n\nVerás un pequeño anuncio para seguir mejorando la app Cursin 🕓',
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('Quitar anuncios',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => deleteAnunScreen()),
                  );
                },
              ),
              SizedBox(width: 20),
              TextButton(
                child: const Text('Continuar',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
                onPressed: () async {
                  try {
                    final result = await InternetAddress.lookup('google.com');
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      showInterstitialAd();
                      Navigator.pop(context);
                    }
                  } on SocketException catch (_) {
                    Fluttertoast.showToast(
                      msg:
                          "No estás conectado a internet.\nConéctate a Wi-Fi o datos móviles.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void shareCourse() {
    Share.share(widget.td.title +
        " - Incluye CERTIFICADO de finalización 🎖️" +
        "\n\nAprende todo y mejora tu conocimiento académico o profesional de forma gratuita con el " +
        widget.td.title +
        " ofrecido por " +
        widget.td.entidad +
        ", disponible ahora en la App Cursin." +
        "\n\nDisfruta de este y otros cursos gratis más en la app Cursin. Pásalo a ese amigo que tanto lo necesita y aprovecha la App porque subimos cursos nuevos gratuitos todas las semanas! 🥳" +
        "\n\nDescargar app: https://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }

//this method fix the not jump line, adding a \n
  descriptionFix() {
    String description = widget.td.description;

    String newDescription = description.replaceAll("+", "\n");

    return newDescription;
  }

  void _showDialogProblemAds(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "No cargan los anuncios",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'En algunos teléfonos la carga de ciertos componentes suele tardarse más que en otros, dependiendo del tipo de smartphone que tengas y el país en donde estés. \n\n' +
                          'Te recomendamos 4 posibles soluciones: \n\n' +
                          '1. No ingreses tan rápido a los cursos cuando recien abras la app. Esto no le daria tiempo a tu telefono de cargar todos los componentes necesarios para funcionar.\n\n' +
                          '2. Verifica tu conexión a internet. Los cursos funcionan solo si tienes conexión a internet, cambiate a WiFi si no puedes entrar con datos móviles.\n\n' +
                          '3. Corrige tu DNS de conexion para que no bloquee los anuncios, ya que estos son necesarios para que Cursin pueda seguir existiendo.\n\n' +
                          '4. Intenta volver abrir el curso 3 o 4 veces más. \n\n' +
                          '5. Vuelve en un par de horas.',
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
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
                        'Entiendo',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                      onPressed: () => {
                            Navigator.pop(context),
                          }),
                ),
              ]);
        });
  }

  int randomNumber() {
    int number = 0;
    var rng = Random();
    number = rng.nextInt(4);
    return number;
  }

  void _showDialogVideoNoCarga(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Problemas al entrar",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Puede que algunos videos de los cursos emitidos por Teachlr o Capacitate no se puedan reproducir correctamente dentro de Cursin.\n' +
                          '\nAunque el anterior problema no siempre ocurre, te recomendamos una posible solución: \n\n' +
                          '- Una vez accedas al curso dentro de Cursin, toca los tres puntos verticales ubicados en la parte superior derecha de la pantalla.\n\n' +
                          '- Encontrarás una opción llamada "Abrir con el navegador", la cual te permitira abrir el curso en tu navegador favorito y continuar con tu proceso sin problemas.',
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
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
                        'Entiendo',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                      onPressed: () => {
                            Navigator.pop(context),
                          }),
                ),
              ]);
        });
  }

  Future<void> sendSharedPreferences() async {
    SharedPreferences cursosFavString = await SharedPreferences.getInstance();
    String? getCoursesStringShP = cursosFavString.getString('coursesFavorites');

    //elimina la palabra 'curso de' de ese string
    final newTitle = widget.td.title;

    //No se efectúa el registro si ya existe el titulo en el ShP
    if (getCoursesStringShP?.contains(widget.td.title) == true) {
      //elimina el curso guardado
      final value = getCoursesStringShP;
      final newValue = value?.replaceAll(widget.td.title,
          ""); //reemplaza todo titulo que contenga el titulo de curso, por un sin espacio

      //sending new script titles
      cursosFavString.setString('coursesFavorites', newValue.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text('Curso eliminado de Favoritos'),
              SizedBox(width: 8),
              GestureDetector(
                child: Text(
                  'Ver cursos',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CoursesFavs()),
                  );
                },
              ),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      //print("value de cadena sin el curso: $newValue");
    } else {
      //si el shP está vacio, agrega entonces el primer curso titulo
      if (getCoursesStringShP == null) {
        //se envia por primera vez el primer script de titulo
        cursosFavString.setString('coursesFavorites', newTitle);

        //muestra mensaje
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Text('Curso guardado en Favoritos'),
                SizedBox(width: 8),
                GestureDetector(
                  child: Text(
                    'Ver cursos',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CoursesFavs()),
                    );
                  },
                ),
              ],
            ),
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        //sino, quiere decir que ya tiene titulos y pasa a concatenar
        String? oldCoursesString = getCoursesStringShP;
        String newCoursesString = oldCoursesString + "," + newTitle;

        //sending new script titles
        cursosFavString.setString('coursesFavorites', newCoursesString);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Text('Curso guardado en Favoritos'),
                SizedBox(width: 8),
                GestureDetector(
                  child: Text(
                    'Ver cursos',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CoursesFavs()),
                    );
                  },
                ),
              ],
            ),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void TimerLuzTablaInfo() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });

    Timer(Duration(seconds: 3), () {
      _timer.cancel();
      setState(() {
        _isVisible = false;
      });
    });
  }
}

class WidgetTablaInfo extends StatelessWidget {
  const WidgetTablaInfo(
      {super.key, required this.darkTheme, required this.widget});

  final bool? darkTheme;
  final CourseDetail widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //IDIOMA
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Center(
                child: RichText(
                    text: TextSpan(
                  text: "🗣️ Idioma:",
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: darkTheme == true ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(widget.td.idioma,
                    style: TextStyle(
                        color: darkTheme == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
        Divider(
          color: darkTheme == true ? Colors.grey : Colors.black,
        ),

        //ENTIDAD

        Row(
          children: [
            Expanded(
              child: Center(
                child: RichText(
                    text: TextSpan(
                  text: "🏢 Entidad:",
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: darkTheme == true ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(widget.td.entidad,
                    style: TextStyle(
                        color: darkTheme == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
        Divider(
          color: darkTheme == true ? Colors.grey : Colors.black,
        ),

        //CATEGORIA

        Row(
          children: [
            Expanded(
              child: Center(
                child: RichText(
                    text: TextSpan(
                  text: "🗂️ Categoría:",
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: darkTheme == true ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(widget.td.categoria,
                    style: TextStyle(
                        color: darkTheme == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
        Divider(
          color: darkTheme == true ? Colors.grey : Colors.black,
        ),

        //DURACIÓN

        Row(
          children: [
            Expanded(
              child: Center(
                child: RichText(
                    text: TextSpan(
                  text: "🕑 Duración:",
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: darkTheme == true ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(widget.td.duracion,
                    style: TextStyle(
                        color: darkTheme == true ? Colors.white : Colors.black,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
        Divider(
          color: darkTheme == true ? Colors.grey : Colors.black,
        ),

        //TIPO DE EMISION

        Row(
          children: [
            Expanded(
              child: Center(
                  child: RichText(
                      text: TextSpan(
                text: "🎖️ Tipo de emisión:",
                style: new TextStyle(
                  fontSize: 15.0,
                  color: darkTheme == true ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ))),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.td.emision,
                  style: TextStyle(
                      color: darkTheme == true &&
                              widget.td.emision == 'Con certificado gratis'
                          ? Colors.green
                          : darkTheme == false &&
                                  widget.td.emision == 'Con certificado gratis'
                              ? Colors.green
                              : darkTheme == false ||
                                      darkTheme == true &&
                                          widget.td.emision !=
                                              'Con certificado gratis'
                                  ? Colors.grey
                                  : null,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),

        Divider(
          color: darkTheme == true ? Colors.grey : Colors.black,
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => certificadosScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Ver certificados',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
