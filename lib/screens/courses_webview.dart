import 'dart:async';
import 'package:cursin/screens/drawer/drawer_options/categorias_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cursin/screens/course_option.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void initState() {
    super.initState();
    isloaded = true;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<void> userAgentOfChrome() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"

    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    print(
        'Running on ${webBrowserInfo.userAgent}'); // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"

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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 20,
              onPressed: () {
                _goBack(context);
              },
            ),
            title: Text(
              widget.nameCourse.toString(),
              style: TextStyle(fontSize: 15),
            ),
            centerTitle: true,
            actions: <Widget>[
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                      ),
                      onPressed: () {
                        showExitDialog(context);
                      }),
                  PopupMenuButton<String>(
                    iconSize: 20,
                    onSelected: handleClick,
                    itemBuilder: (BuildContext context) {
                      return {
                        'Compartir mediante...',
                        'Abrir con el navegador',
                        'Copiar Enlace',
                        'Descargar un archivo',
                        '¿No cargan los videos?'
                      }.map((String choice) {
                        return PopupMenuItem<String>(
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
              'Mozilla/5.0 (Linux; Android 9.0; $modelDevice Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Mobile Safari/537.3',
          //'Mozilla/5.0 (Linux; Android 9.0; Build/N2G48H; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/68.0.3440.70 Mobile Safari/537.36',
          //'Mozilla/5.0 (Linux; Android 9.0; $modelDevice Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Mobile Safari/537.3',
//Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36

          //    Web userAgent: $_webUserAgent
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
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                    //open screen to select option how to see course

                    if (widget.nombreEntidad == 'TICnoticos') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoriasSelectCards()));
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
                  child: Text('Sip'),
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
    }
  }

  //metodo para ejecutar el link de abrir en Chrome
  void openUrl() async {
    String url = widget.urlCourse.toString(); //antes era const
    if (await canLaunch(url)) launch(url);
  }

  void copiarEnlace() {
    Clipboard.setData(ClipboardData(text: widget.urlCourse.toString()));
    Fluttertoast.showToast(
      msg: "Enlace copiado", // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.BOTTOM, // location
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

/* 

//code 2
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_user_agentx/flutter_user_agent.dart';
import 'dart:io';
import 'package:cursin/screens/course_option.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:device_info_plus/device_info_plus.dart';

class webview extends StatefulWidget {
  webview(
      {required this.nameCourse,
      required this.urlCourse,
      required this.imgCourse});

  late String nameCourse;
  late String urlCourse;
  late String imgCourse;

  @override
  webviewState createState() => webviewState();
}

class webviewState extends State<webview> {
  bool isloaded = false;

  late WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  //final globalKey = GlobalKey<ScaffoldState>();

  String _userAgent = '<unknown>';
  String _webUserAgent = '<unknown>';

  String browserUserAgent = '';

  void initState() {
    initUserAgentState();
    super.initState();
    isloaded = true;
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<void> userAgentOfChrome() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"

    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"

    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    print(
        'Running on ${webBrowserInfo.userAgent}'); // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"

    setState(() {
      browserUserAgent = webBrowserInfo.userAgent!;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initUserAgentState() async {
    String userAgent, webViewUserAgent;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
      await FlutterUserAgent.init();
      webViewUserAgent = FlutterUserAgent.webViewUserAgent!;
      print('''
          applicationVersion => ${FlutterUserAgent.getProperty('applicationVersion')}
          systemName         => ${FlutterUserAgent.getProperty('systemName')}
          userAgent          => $userAgent
          webViewUserAgent   => $webViewUserAgent
          packageUserAgent   => ${FlutterUserAgent.getProperty('packageUserAgent')}
                ''');
    } on PlatformException {
      userAgent = webViewUserAgent = '<error>';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _userAgent = userAgent;
      _webUserAgent = webViewUserAgent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 20,
              onPressed: () {
                _goBack(context);
              },
            ),
            title: Text(
              widget.nameCourse.toString(),
              style: TextStyle(fontSize: 15),
            ),
            centerTitle: true,
            actions: <Widget>[
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                      ),
                      onPressed: () {
                        showExitDialog(context);
                      }),
                  PopupMenuButton<String>(
                    iconSize: 20,
                    onSelected: handleClick,
                    itemBuilder: (BuildContext context) {
                      return {
                        'Compartir mediante...',
                        'Abrir con el navegador',
                        'Copiar Enlace'
                      }.map((String choice) {
                        return PopupMenuItem<String>(
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
          userAgent: 'Mozilla/5.0 (Linux; Android 9.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Mobile Safari/537.3',
          

          //'Mozilla/5.0 (Linux; Android 9.0; Build/N2G48H; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/68.0.3440.70 Mobile Safari/537.36',
          //    Device userAgent: $_userAgent
          //    Web userAgent: $_webUserAgent
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


//
//ORIGINAL CODE 
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class webview extends StatelessWidget {
  late String nameCourse, urlCourse;
  bool isloaded = false;

  webview({required this.nameCourse, required this.urlCourse});
  final globalKey = GlobalKey<ScaffoldState>();

  void initState() {
    isloaded = true;
  }

  late WebViewController controllerGlobal;

/*   Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      print("onwill goback");
      controllerGlobal.goBack();
    } 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No back history item")),
      );
      return Future.value(false);
    
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(nameCourse.toString()),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Compartir mediante...',
                  'Abrir con el navegador',
                  'Copiar Enlace'
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ]),
      body: WebView(
        userAgent: "random",
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: urlCourse.toString(),
      ),
    );
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
    }
  }

  //metodo para ejecutar el link de abrir en Chrome
  void openUrl() async {
    String url = urlCourse.toString(); //antes era const
    if (await canLaunch(url)) launch(url);
  }

  void copiarEnlace() {
    Clipboard.setData(ClipboardData(text: urlCourse.toString()));
    Fluttertoast.showToast(
      msg: "Enlace copiado", // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.BOTTOM, // location
    );
  }

  void compartirUrl() {
    Share.share("Acabé de encontrar un " +
        nameCourse.toString() +
        " GRATIS y CON CERTIFICADO incluido 🥳" +
        "\n\nDan acceso a este y otros cursos gratis en esta App llamada Cursin 👏🏻" +
        " Aprovechala que recién la acaban de sacar en la PlayStore 🥳👇🏼" +
        "\n\nhttps://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }
}
*/

/*
//CON LA SEGUNDA ITERACION
import 'package:flutter/services.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class webview extends StatelessWidget {
  late String nameCourse, urlCourse;
  bool isloaded = false;

  webview({required this.nameCourse, required this.urlCourse});
  final globalKey = GlobalKey<ScaffoldState>();

  void initState() {
    isloaded = true;
  }

  late WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
        appBar: AppBar(
            title: Text(nameCourse.toString()),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Compartir mediante...',
                    'Abrir con el navegador',
                    'Copiar Enlace'
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ]),
        body: WebView(
          userAgent: "random",
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: urlCourse.toString(),
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Do you want to exit'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text('Yes'),
                  ),
                ],
              ));
      return Future.value(true);
    }
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
    }
  }

  //metodo para ejecutar el link de abrir en Chrome
  void openUrl() async {
    String url = urlCourse.toString(); //antes era const
    if (await canLaunch(url)) launch(url);
  }

  void copiarEnlace() {
    Clipboard.setData(ClipboardData(text: urlCourse.toString()));
    Fluttertoast.showToast(
      msg: "Enlace copiado", // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.BOTTOM, // location
    );
  }

  void compartirUrl() {
    Share.share("Acabé de encontrar un " +
        nameCourse.toString() +
        " GRATIS y CON CERTIFICADO incluido 🥳" +
        "\n\nDan acceso a este y otros cursos gratis en esta App llamada Cursin 👏🏻" +
        " Aprovechala que recién la acaban de sacar en la PlayStore 🥳👇🏼" +
        "\n\nhttps://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }
}

*/
