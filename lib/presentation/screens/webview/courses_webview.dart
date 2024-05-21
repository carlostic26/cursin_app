import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cursin/presentation/screens/screens.dart';
import 'package:cursin/presentation/screens/option_course.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';

class webview extends StatefulWidget {
  webview(
      {required this.nameCourse,
      required this.urlCourse,
      required this.imgCourse,
      required this.nombreEntidad});

  late String nameCourse;
  late String urlCourse;
  late String imgCourse;
  late String nombreEntidad;

  @override
  webviewState createState() => webviewState();
}

class webviewState extends State<webview> {
  bool isloaded = false;

  late WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  //final globalKey = GlobalKey<ScaffoldState>();

  String modelDevice = '';

  bool? darkTheme;

  void initState() {
    super.initState();
    getSharedThemePrefs();
    isloaded = true;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    Future.delayed(const Duration(seconds: 10), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Recuerda iniciar sesión o registrarte para ver el curso'),
          duration: const Duration(seconds: 3),
        ),
      );
    });

    Future.delayed(const Duration(seconds: 15), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Estaremos aquí para lo que necesites. <3'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
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

  Future<void> userAgentOfChrome() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"

    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    // print( 'Running on ${webBrowserInfo.userAgent}'); // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"

    setState(() {
      modelDevice = androidInfo.model!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor:
                darkTheme == true ? Colors.grey[850] : Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
              iconSize: 20,
              onPressed: () {
                _goBack(context);
              },
            ),
            title: Text(
              widget.nameCourse.toString(),
              style: TextStyle(
                  color: darkTheme == false ? Colors.grey[850] : Colors.white,
                  fontSize: 15),
            ),
            centerTitle: true,
            actions: <Widget>[
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        color: darkTheme == false
                            ? Colors.grey[850]
                            : Colors.white,
                        Icons.logout,
                        size: 20,
                      ),
                      onPressed: () {
                        showExitDialog(context);
                      }),
                  PopupMenuButton<String>(
                    color: darkTheme == false ? Colors.grey[850] : Colors.white,
                    iconSize: 20,
                    onSelected: handleClick,
                    itemBuilder: (BuildContext context) {
                      return {
                        'Compartir mediante...',
                        'Abrir con el navegador',
                        'Copiar Enlace',
                        'Descargar un archivo',
                        '¿No cargan los videos?',
                        'Tengo un problema'
                      }.map((String choice) {
                        return PopupMenuItem<String>(
                          textStyle: TextStyle(
                            color: darkTheme == true
                                ? Colors.grey[850]
                                : Colors.white,
                          ),
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ]),
        body: WebView(
          userAgent:
              //'Mozilla/5.0 (Linux; Android 9.0; $modelDevice Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Mobile Safari/537.3',
              'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.future.then((value) => _controller = value);
            _controllerCompleter.complete(webViewController);
          },
          initialUrl: widget.urlCourse.toString(),
        ),
      ),
    );
  }

  void _dialogDerscargarArchivo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //text
                  Text(
                    'Si estás intentanto descargar un archivo, te recomendamos abrir el curso con el navegador para que la descarga pueda funcionar.',
                    style: TextStyle(color: Colors.black, fontSize: 11.0),
                  ),

                  SizedBox(height: 5),

                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    child: SizedBox(
                      width: 50,
                      height: 20,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                            'Ok',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          onPressed: () => {
                                Navigator.pop(context),
                              }),
                    ),
                  ),

                  SizedBox(height: 10),
                ]),
          );
        });
  }

  void _dialogVideoNoCarga(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //img , , , , ,
                  Container(
                      height: 130,
                      padding: EdgeInsets.symmetric(
                        horizontal: 1,
                      ),
                      child: Image.asset("assets/gif_open_browser.gif")),
                  SizedBox(
                    height: 5,
                  ),
                  //text
                  Text(
                    'En caso de que no se reproduzca el video, abre el curso con el navegador',
                    style: TextStyle(color: Colors.black, fontSize: 11.0),
                  ),

                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
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
                          'Ok',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        onPressed: () => {
                              Navigator.pop(context),
                            }),
                  ),
                ]),
          );
        });
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showExitDialog(context);
      return Future.value(true);
    }
  }

  void showExitDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('¿Quieres salir de este curso?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                    //open screen to select option how to see course

                    if (widget.nombreEntidad == 'TICnoticos') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeCategoriasSelectCards()));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => courseOption(
                                nameCourse: widget.nameCourse,
                                urlCourse: widget.urlCourse,
                                imgCourse: widget.imgCourse,
                                nombreEntidad: widget.nombreEntidad,
                              )));
                    }
                  },
                  child: Text(
                    'Sip',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ));
  }

  void handleClick(String value) {
    switch (value) {
      case 'Copiar Enlace':
        copiarEnlace();
        break;
      case 'Abrir con el navegador':
        openUrl();
        break;
      case 'Compartir por':
        compartirUrl();
        break;
      case 'Descargar un archivo':
        _dialogDerscargarArchivo(context);
        break;
      case '¿No cargan los videos?':
        _dialogVideoNoCarga(context);
        break;
      case 'Tengo un problema':
        _showDialogToReportProblem(context);
        break;
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
                      if (errorNoPlayVideo) {
                        //Muestra dialogo de problemas reproducir video de un curso
                        Navigator.pop(context);
                        _dialogVideoNoCarga(context);
                      } else {
                        _mailto();
                      }
                    }),
              ),
            ]);
          });
        });
  }

  Future _mailto() async {
    final mailtoLink = Mailto(
      to: ['cursinapp@gmail.com'],
      cc: [''],
      subject: 'Reporte de falla de un curso',
      body: "Hola. Quiero reportar un problema del " +
          widget.nameCourse +
          " emitido por " +
          widget.nombreEntidad +
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

  //metodo para ejecutar el link de abrir en Chrome
  void openUrl() async {
    String url = widget.urlCourse.toString(); //antes era const
    if (await canLaunch(url)) launch(url);
  }

  void copiarEnlace() {
    Clipboard.setData(ClipboardData(text: widget.urlCourse.toString()));
    Fluttertoast.showToast(
      msg: "Enlace copiado",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void compartirUrl() {
    Share.share("Acabé de encontrar un " +
        widget.nameCourse.toString() +
        " GRATIS y CON CERTIFICADO incluido 🥳" +
        "\n\nDan acceso a este y otros cursos gratis en esta App llamada Cursin 👏🏻" +
        " Aprovechala que recién la acaban de sacar en la PlayStore 🥳👇🏼" +
        "\n\nhttps://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }
}
