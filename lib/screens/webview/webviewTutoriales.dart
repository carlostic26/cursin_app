import 'dart:async';
import 'package:cursin/screens/drawer/drawer_options/categorias_select.dart';
import 'package:cursin/screens/drawer/drawer_options/noticias_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cursin/screens/course_option.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:device_info_plus/device_info_plus.dart';

class webviewTutoScreen extends StatefulWidget {
  @override
  webviewTutoScreenState createState() => webviewTutoScreenState();
}

class webviewTutoScreenState extends State<webviewTutoScreen> {
  bool isloaded = false;

  late WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  //final globalKey = GlobalKey<ScaffoldState>();

  String modelDevice = '';
  String urlYoutube =
      'https://www.youtube.com/playlist?list=PLrCQaitBpNfdxsH5lRsCSah2TJ9aaxlCm';

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
      onWillPop: () => _goBack(),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 20,
              onPressed: () {
                _goBack();
              },
            ),
            title: Text(
              'Tutoriales Cursin',
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
                        Navigator.pop(context);
                      }),
                  PopupMenuButton<String>(
                    iconSize: 20,
                    onSelected: handleClick,
                    itemBuilder: (BuildContext context) {
                      return {'Copiar Enlace', 'Abrir con el navegador'}
                          .map((String choice) {
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
          initialUrl: urlYoutube,
        ),
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
    }
  }

  //metodo para ejecutar el link de abrir en Chrome
  void openUrl() async {
    String url = urlYoutube; //antes era const
    if (await canLaunch(url)) launch(url);
  }

  void copiarEnlace() {
    Clipboard.setData(ClipboardData(text: urlYoutube));
    Fluttertoast.showToast(
      msg: "Enlace copiado", // message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.BOTTOM, // location
    );
  }

  _goBack() {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CategoriasSelectCards(),
      ),
    );
  }
}
