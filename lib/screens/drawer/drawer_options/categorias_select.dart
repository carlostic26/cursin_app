// ignore_for_file: deprecated_member_use
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/screens/drawer/drawer.dart';
import 'package:cursin/screens/drawer/drawer_options/certificados.dart';
import 'dart:math';
import 'package:cursin/screens/drawer/drawer_options/courses_favs.dart';
import 'package:cursin/screens/courses_webview.dart';
import 'package:cursin/screens/drawer/drawer_options/delete_anun.dart';
import 'package:cursin/screens/infoScreens/agradecimientos.dart';
import 'package:cursin/model/curso_lista_model.dart';
import 'package:cursin/screens/drawer/drawer_options/categorias_showing.dart';
import 'package:cursin/model/dbhelper.dart';
import 'package:cursin/screens/infoScreens/info_app.dart';
import 'package:cursin/screens/drawer/drawer_options/ultimos_cursos.dart';
import 'package:cursin/screens/drawer/drawer_options/search_courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:giff_dialog/giff_dialog.dart';

class CategoriasSelectCards extends StatefulWidget {
  @override
  _CategoriasSelectCardsState createState() => _CategoriasSelectCardsState();
}

class _CategoriasSelectCardsState extends State<CategoriasSelectCards> {
  // img from net to icons category

  String iconTIC =
      'https://blogger.googleusercontent.com/img/a/AVvXsEgZvTUOAyqkyiMrhGo705qIOtrPnABJdDecuUxSCoPDiLUHK8jW-3A64a6fxgiQh8VwbnIe8pASe_JaUYRjEVSK3lD3JskBrL06_OkXuEXJMeAF3O01sdFK2t4Vx5VteDcy_-qNkoWUNu4Czq9rm4fGAKqMzBFN69W26VIEsnWYEUFq-OD1ScneHA';
  String iconDesarroolo =
      'https://blogger.googleusercontent.com/img/a/AVvXsEh0SajSu7l9CJ_J9NporoCQbv3qoorL9Wd66VaqZrPTp5VlflQC6t_Mnlz1hRvcegfWHn3k1UBWyoAbCNLZXkv6QtqCSprHVDomUQ-Z5SJKg4eo1ANjv8kXEVv4JR7Hx9ukn0njzEi_QaIz_9JE0gybQAVxmZETkfHaNHBaYDTA9jeo7ac-G0d-kw';
  String iconFinanzas =
      'https://blogger.googleusercontent.com/img/a/AVvXsEhrfptcDX-_0shy7o4BojG3GOnOYSgZPhbFj65nNRvfOYeG4XzV_qBtm7iYp5MSPvIwAf0NfBdc0N_P3zWhKMcPKRmp_1ihfWzofpGxBMjQti_KQBtbO1pZRjiCAxBEP6V-aTeXzh6NmZcCI-NLYUrjoppsRrFF2b5_dTbCilRYgGd0_VCCOW0ZKw';
  String iconIdiomas =
      'https://blogger.googleusercontent.com/img/a/AVvXsEiMv6dyP-RTQ-sTsLOPOJeWUmoJL2w5Htu7cZ-aPyd8j0lfd_BHw7kTU6QOefDOZEhR86sVZg04KazTLkCQ8UV4j2aKwrn-YXHHRsw8jqb5UXyQ1BYK0FemkVAYRVGtmHMMWdNo5S9LLJiZQC10bLJ8LJJVDUhsDvPfmD_BWximseKMQHc6wGW8Dg';
  String iconDatos =
      'https://blogger.googleusercontent.com/img/a/AVvXsEgsMsv7XUu4HKTVEbwXih5ooUBy_iF3wLRkcG_Oe0UeGxuHrRuCUhlmg2P9VeAKNd_FbtP7qEAbAn_RKVXcjwTNVo9BN-uQsAGz_F3GA4pyP79o12nF8fqbOnlciFV_elSEHgM401Zxq7WmqHgtv7Qvww7MttM_foCqkB6C10d0rE1T663MFgpFfw';
  String iconIA =
      'https://blogger.googleusercontent.com/img/a/AVvXsEgG2IVguqFlEQ-OVn1X5Q0VckZ1oQNFy0-S4fAPUhb3GCEqhYczLDz8P5j_cGcyLPar_ecNiGdMYsICVZhUJv1jSY7cHmXRbuN5CJH3pyvo82MlbPhGuCf146NBL6lSYaouVYI9d-4pIBAC7EhVGTkxYQp9IlSg8nuiXg3Af8gILfhVkWjaJOGjww';
  String iconArtes =
      'https://blogger.googleusercontent.com/img/a/AVvXsEjMZ1Nmgf-ABTeVWEerCWgcHyeE8-uP1hMQ2T5EMBJOAI6iuK2egcWvy5LOZmflKPbmlKZEUu9DbxgiRA5KGlSZhKi6Ztnayc78aYKubhjRHhfJSOUciFVJqzsxkvZW47Sa9EEGMdRHmAnYsQ8hDy3ulQd4vrRtvdT_WRjdwtuUlgeGG_PmU15FyA';
  String iconCrypto =
      'https://blogger.googleusercontent.com/img/a/AVvXsEgqhBEuq6zbNxb6Q8oV_AvucsSPFzz4G3hzRWS2JMtNddVJmbq5PLx45DsE9B-mAS2PYjVEnP0CPrcwpaK-Gkgzo7HdRFNehLyUYAITdo4wdzZlOwoE1BxnZT-mFe49pcEMznyhc9iiurMDmz3KvzJ87EfJi4JqHBv1nQCaIdByoSk3zxRaC5qtlQ';
  String iconSalud =
      'https://blogger.googleusercontent.com/img/a/AVvXsEjiUEkHtphXqv72-WBPEklj1X8sNAv0oELam2VaVlP_nI18zqMcjqIEaLcdILGaUIP7OABZUbcCxukZPwTgaWd6qLFVhs-yueCqR6lGNz7rKJXakWBSG0IcFipsA5Q7jm4da7JO2fb9TKoSKQSdr1282FvOWz_2RZO5vHqOZSFg2b3PcP3LRLLTTg';
  String iconSociales =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhOxzdPvQmbvR6Ne1uY5nsNG5mg2gDumFs2ZbtAEpkuhtxHiPAoHH2aqYIol2tz4KDJDyCftFTzLcAY2N7-6EyLpGC_BkaW36tAwgvmpzR1GjqYrTXqHXJzuAhGjdftPg1PA2ul3WI7jSfADJR8L3NRde2zE18jo78B1F6_LokyAovJM2M421R32w/s320/ic_juridic.png';
  String iconOtros =
      'https://blogger.googleusercontent.com/img/a/AVvXsEihOBewFfDe4bw6qK04Y0UOZFsptxkYp4FWpbtpb2ubOXFd8sjRNd4U9_nJIXMjL3hgDnNVIzHJBF7HLQCpdwlOTIAppQP0D5CksjiP_AsaOXQzYEdTtaKTXS05VIJa1nWTZR8NSIftFGKXAdJNS0LMbQaypHF5IumaweHyAA49XPzqPje13yEjeA';
  String iconProfesionales =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEWBzWA8LWZZ2pbDA3ELOoosbk2QdHbndyisznwq4hvjghsGhzrBTdYSXqDYdoMbgiwyxBw6XhsqTmVzM8pCINBvkMAs4or9yruwQSjYHwHOdm2Rslai29NLwMlqUvMxXIy-JJOXX6MPtkJbFhepLbh1EU2Bjxhq-Fid5CsGecn_OKukkfryGQVQ/w200-h200/ic_prof.png';
  String iconCosmeticos =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiH4Z8akEdTTw_cVt-eF-j7xR3-MD0q5v17t9-yJdHcWP0VMpPItKEvcf_GbeNNZUSQGrnhTv10_XI3D90xiqzDGf5lcl9G8RkN86q3KKAJqcZNjkD2JZTesGOhqrwTE62Iw3z9AOvzI6RVwJSa0p6ZQceaYZYVAbndkhI0b36c1BJDDQ4I5j0UZA/w200-h200/ic_belleza.png';
  String iconSeguridad =
      'https://blogger.googleusercontent.com/img/a/AVvXsEhaQo9w9LvMk5tpCCNi_Nn22ODbnDO4iU-Rqb44K1PwXkNi4bnVaPsRv74wIJsAnJr3TCtvfi4c8FnhKxyp6cSy8ukNDCSKrf7EanuzTZT1IA_2CouqBXKPIMYRIUCC3-LOq_mHL_6u--OlyJfm50JZ--ulRbU6X1UoiE-eNvjbfRr1PoQrQWW5Zg';
  String iconMusica =
      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg0iQCaxNIb1sLVYSGh_VvoJSJaJHBB1YslVUXScAHjvMzTPsC_kNvl3SAMPLw5npCb4xYyEuk6BIHsQJcX-rF3UWanXhXGIL2ysmfXSvCCLVLMZEM2oX2-QifgjOBLTkrMn9EBlY2o7_wv53M9P0kCyvqL8eZ5MRUC9OEorJHBB-LhnQ0dRGq87g/s320/ic_musica.png";
  String iconRazonamiento =
      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjGt5hfanJmNfcI2-kEpsmrVVkK-CGp1iP9xIQySgO3tLp4oMUQDZuW4alHtRHmlgyB82Da5v3rV9X-OkXndR_VRJ8jMxpSgUZfGdzS2lmJRv4bCmsUqZP5DFPdXFDSk6ccQLALG9UYgfUDtMSq0_ZAKpjNWhyWGZEApj6G0sc8eg-aNAcorlhzvA/w200-h200/ic_razonamiento.png";
  String iconAgro =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjscvtCqH1aqJ7ID8S9VuacAu1iqXzDurwNeTNLMJXXMM3dBnDtC_JcBroKTrFLxBu6TWZZJvSxLHJVZcjMlSYGJ7QBa2j_haAdOMmIoHZb1ap-ZWMq0TCyX-0oAXEy1_IZnacREVAuzcTtgzI__D0vli2D7YUH5FU4jcdO3TTZk7p2O6XYb4hxnQ/w200-h200/ic_agro.png';
  String iconCocina =
      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEieERHURoZHdsU_HYI4ME-C3RYNu1FDx1ycQef59Mq4wOhsD9LUn2xGRt3mlFmoOofoe52wob2SrtTGAuON9imDoR6d6T3BySFfr621JyoAvtHM6I_waZ3OWsfDBMm7idmWCtcZC90xnYr61dXkZWQ9wIF4ySUhxQxhvhS9x9-PCT0IseXKZeZb-A/w200-h200/ic_cocina.png";
  String iconMarketing =
      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiOUodWqO38n6VFSPyLSrUeSrAtgfHfgdO895smpuYz4XW6jACMj-6P0kuxci4qVrx0YkmJsGK9xWqcWhFQuX4HjGuciEM3zfWOj3WbVilpOjJlY2k2ijXavRLsYVBGNH-ofyHIjlgbC1LOLGpURRmKmIgQLTiY3AUaJzdtJDSnjDljlKJ2s9sVkg/w200-h200/ic_marketing.png";
  String iconTrabajos =
      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgZtAnPksAPaF9YFv0br1QF7_MnhISyIj_zj7OSou2YRSF5nLAW9BXbZ7sN6p4bu2jUBY_0z0FtWq4Ilk_wSYmh8EZzlaaVefQ5_4kaKivaCl4Wht5ddoDQPY3mruL4ZBOfwFuRMzVxIMlOZ2tsvT6Qrxs-bqJEUT-HDyHlgaXhPoPEh6h21cru8g/w200-h200/ic_trabajos.png";
  String iconIng =
      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi_k3L-nZj9NBZqI9n7IIoiuKl9W8UUltqTwKXaJBQ6A4JU-BYIo6PixXbyIy6ZJfvs4qtI1YCDwmRxPjrORTrmbgLwEJTKEK1cM3FwIl8KgQ1IHtaVXqs5NBWtYZbYAKkJ8_SiRsYNVmHRK-NlwwMF4KgwhJ6Y4v68e0UA3zs7oynbeoE1JzaZcA/w200-h200/icon_ingenieria.png";
  String iconTransp =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjqlpJ4Wua6zioNq5ZvUVfbcmO5iGoTh7L1oxiffB8Ac-nu7n4iGZwybu98k7Rh7kTODwc73ZHmziW1KC_GjaGoAlnQIlLQZ43cPpFe1HK50pXdwnl4w8FU5aEneMwnnOJp6L1bsCThxP2wOWy2tDfwXeFBQ4sd8bUOkgnhEvXADyVWHwH2cDWQ1w/s320/ic_transp.png';
  late DatabaseHandler handler;
  // ignore: unused_field
  List<curso>? _cat;

  bool? darkTheme1;

  Future<Null> getSharedThemePrefs() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    setState(() {
      darkTheme1 = themePrefs.getBool('isDarkTheme');
    });
  }

  @override
  // ignore: must_call_super
  void initState() {
    getSharedThemePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Back Button pressed!");
        //do nothing cuz user will not return to home last courses
        return true;
      },
      child: Scaffold(
        backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,
        appBar: AppBar(
          title: Text(
            "Todas las Categorias",
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
                          catProviene: "sinCategoria",
                          puntoPartida: 'categorias_select'),
                    ),
                  );
                },
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
              child: Column(
                children: [
                  //ADMINISTRACION Y FINANZAS
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconFinanzas,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 15.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'FINANZAS Y NEGOCIOS',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados al mundo de las finanzas, la contabilidad, los negocios y la administración',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Finanzas",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //TIC
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconTIC,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              //alignment: Alignment.center,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 15.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'INFORMÁTICA Y TIC',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados a las TIC, electrónica, redes, telecomunicaciones ofimática e informática en general.',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "TIC",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Programacion
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white, // Your desired background color

                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconDesarroolo,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 15.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DESARROLLO Y PROGRAMACIÓN',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionado con el Software, el desarrollo y la programación en varios lenguajes.',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Programacion",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //IDIOMAS
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconIdiomas,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'IDIOMAS Y LENGUAJES',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis sobre Inglés, Japonés, Koreano, Ortografía y demás idiomas',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Idiomas",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //PROFESIONALES
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconProfesionales,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'FORMACIÓN PROFESIONAL',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con el mejoramiento y crecimiento del perfil profesional',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Profesionales",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Marketing digital
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconMarketing,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'MARKETING DIGITAL',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con la promoción, publicidad, ventas en linea y marketing en general',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Marketing",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //SEGURIDAD INFORMÁTICA
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconSeguridad,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      )),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 11.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'SEGURIDAD INFORMÁTICA',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con el haking ético, seguridad en redes, seguridad informática en general',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Ciberseguridad",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Razonamiento Cuantitativo
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconRazonamiento,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'RAZONAMIENTO CUANTITATIVO',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con los números, las matematicas, el cálculo, analisis numericos, estadistica y razonamiento cuantitativo en general',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Razonamiento",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //INGENIERIA
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconIng,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'INGENIERIA',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con la ingeniería civil, ingenieria mecánica, ingenieria industrial, ingenieria mecatrónica y afines.',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Ingenieria",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Salud
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconSalud,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 15.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'SALUD Y BIENESTAR',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis sobre el área del bienestar y la salud como medicina, psicologia, nutrición, cuidados, entre otros',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Salud",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Ciencia y análisis de datos
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconDatos,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CIENCIA Y ANÁLISIS DE DATOS',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados a la ciencia análisis de datos, desde cursos introductorios hasta mas completos con lenguajes y librerías',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene:
                                                  "Ciencia y Análisis de Datos",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //INTELIGENCIA ARTIFICIAL
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconIA,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'INTELIGENCIA ARTIFICIAL',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados al mundo de la inteligencia artificial, redes neuronales, deep learning, machine learning, etc...',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "IA",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //ARTES
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconArtes,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 30.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ARTES',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con el diseño gráfico, dibujo, literatura, actuación y arte en general, incluyendo pintura, escultura, fotografía, historia del arte, entre otros...',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Artes",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //COCINA Y ALIMENTOS
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconCocina,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 11.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'COCINA Y ALIMENTOS',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con la preparación y manipulación de alimentos, la nutrición y la gastronomía, incluyendo técnicas de cocina, repostería, panadería, cocina internacional, alimentación saludable, entre otros...',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Cocina y alimentos",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //MUSICA
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconMusica,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'MÚSICA',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con los instrumentos musicales, géneros, canto y la música en general, incluyendo teoría musical, técnica de instrumentos, interpretación, composición, entre otros...',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "musica",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //SOCIALES Y JURIDICAS
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconSociales,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 11.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'SOCIALES, SOCIEDADES Y JURÍDICAS',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con el derecho, la sociedad, las leyes y el trabajo social, incluyendo derecho, sociología, trabajo social, política, entre otros...',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Sociales",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //AGRO
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconAgro,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 11.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'AGROPECUARIO',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con el sector agrícola y pecuario, incluyendo agricultura, ganadería, horticultura, piscicultura, apicultura, jardinería, entre otros...',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Agropecuario",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //TRANSPORTE
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconTransp,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 11.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'TRANSPORTE',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratuis relacionados con la conducción de vehículos: moto, carro, transporte de carga, transporte en general y más.',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Transporte",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //CRYPTO Y TRADING
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconCrypto,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CRYPTO Y TRADING',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados al mundo de las Criptomonedas, el blockchain y demás tecnologías de la web3',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Crypto",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //BELLEZA
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconCosmeticos,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 11.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'MODA Y BELLEZA',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con el cuidado de la piel, tatoo, peluqueria, manicure, barberia, pedicure, dermatologia, entre otros...',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Belleza",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //TRABAJOS VARIOS
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconTrabajos,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 16.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'TRABAJOS VARIOS',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Cursos gratis relacionados con trabajos que no requieren una educación formal como limpiador, bodeguero, auxiliar, panadero, voluntario, paseador y más.',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Trabajos Varios",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //OTHERS

                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darkTheme1 == true
                            ? Colors.grey[850]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              //PADDING OF THE IMAGE
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 8.0, 16.0, 8.0),
                              child: new Container(
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: iconOtros,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            new Container(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 30.0, 8.0),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'OTROS CURSOS ...',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Aquí podrás encontrar los cursos que aún no tienen categoria debido al bajo numero registrados',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: darkTheme1 == true
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => categorias(
                                              catProviene: "Otros",
                                              puntoPartida:
                                                  'categorias_select'),
                                        ),
                                      );
                                    },
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
          ),
        ),
        drawer: drawerCursin(
          context: context,
        ),
      ),
    );
  }
}
