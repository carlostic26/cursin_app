import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/infrastructure/localdb/cursos_PROG_db.dart';
import 'package:cursin/infrastructure/localdb/cursos_TIC_db.dart';
import 'package:cursin/infrastructure/localdb/cursos_db.dart';
import 'package:cursin/screens/drawer/drawer_options/tutoriales.dart';
import 'package:cursin/screens/launch/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../screens.dart';

class HomeCategoriasSelectCards extends StatefulWidget {
  @override
  _HomeCategoriasSelectCardsState createState() =>
      _HomeCategoriasSelectCardsState();
}

class _HomeCategoriasSelectCardsState extends State<HomeCategoriasSelectCards> {
  final Map<String, String> categoryIcons = {
    'iconTIC':
        'https://blogger.googleusercontent.com/img/a/AVvXsEgZvTUOAyqkyiMrhGo705qIOtrPnABJdDecuUxSCoPDiLUHK8jW-3A64a6fxgiQh8VwbnIe8pASe_JaUYRjEVSK3lD3JskBrL06_OkXuEXJMeAF3O01sdFK2t4Vx5VteDcy_-qNkoWUNu4Czq9rm4fGAKqMzBFN69W26VIEsnWYEUFq-OD1ScneHA',
    'iconDesarrollo':
        'https://blogger.googleusercontent.com/img/a/AVvXsEh0SajSu7l9CJ_J9NporoCQbv3qoorL9Wd66VaqZrPTp5VlflQC6t_Mnlz1hRvcegfWHn3k1UBWyoAbCNLZXkv6QtqCSprHVDomUQ-Z5SJKg4eo1ANjv8kXEVv4JR7Hx9ukn0njzEi_QaIz_9JE0gybQAVxmZETkfHaNHBaYDTA9jeo7ac-G0d-kw',
    'iconFinanzas':
        'https://blogger.googleusercontent.com/img/a/AVvXsEhrfptcDX-_0shy7o4BojG3GOnOYSgZPhbFj65nNRvfOYeG4XzV_qBtm7iYp5MSPvIwAf0NfBdc0N_P3zWhKMcPKRmp_1ihfWzofpGxBMjQti_KQBtbO1pZRjiCAxBEP6V-aTeXzh6NmZcCI-NLYUrjoppsRrFF2b5_dTbCilRYgGd0_VCCOW0ZKw',
    'iconIdiomas':
        'https://blogger.googleusercontent.com/img/a/AVvXsEiMv6dyP-RTQ-sTsLOPOJeWUmoJL2w5Htu7cZ-aPyd8j0lfd_BHw7kTU6QOefDOZEhR86sVZg04KazTLkCQ8UV4j2aKwrn-YXHHRsw8jqb5UXyQ1BYK0FemkVAYRVGtmHMMWdNo5S9LLJiZQC10bLJ8LJJVDUhsDvPfmD_BWximseKMQHc6wGW8Dg',
    'iconDatos':
        'https://blogger.googleusercontent.com/img/a/AVvXsEgsMsv7XUu4HKTVEbwXih5ooUBy_iF3wLRkcG_Oe0UeGxuHrRuCUhlmg2P9VeAKNd_FbtP7qEAbAn_RKVXcjwTNVo9BN-uQsAGz_F3GA4pyP79o12nF8fqbOnlciFV_elSEHgM401Zxq7WmqHgtv7Qvww7MttM_foCqkB6C10d0rE1T663MFgpFfw',
    'iconIA':
        'https://blogger.googleusercontent.com/img/a/AVvXsEgG2IVguqFlEQ-OVn1X5Q0VckZ1oQNFy0-S4fAPUhb3GCEqhYczLDz8P5j_cGcyLPar_ecNiGdMYsICVZhUJv1jSY7cHmXRbuN5CJH3pyvo82MlbPhGuCf146NBL6lSYaouVYI9d-4pIBAC7EhVGTkxYQp9IlSg8nuiXg3Af8gILfhVkWjaJOGjww',
    'iconArtes':
        'https://blogger.googleusercontent.com/img/a/AVvXsEjMZ1Nmgf-ABTeVWEerCWgcHyeE8-uP1hMQ2T5EMBJOAI6iuK2egcWvy5LOZmflKPbmlKZEUu9DbxgiRA5KGlSZhKi6Ztnayc78aYKubhjRHhfJSOUciFVJqzsxkvZW47Sa9EEGMdRHmAnYsQ8hDy3ulQd4vrRtvdT_WRjdwtuUlgeGG_PmU15FyA',
    'iconCrypto':
        'https://blogger.googleusercontent.com/img/a/AVvXsEgqhBEuq6zbNxb6Q8oV_AvucsSPFzz4G3hzRWS2JMtNddVJmbq5PLx45DsE9B-mAS2PYjVEnP0CPrcwpaK-Gkgzo7HdRFNehLyUYAITdo4wdzZlOwoE1BxnZT-mFe49pcEMznyhc9iiurMDmz3KvzJ87EfJi4JqHBv1nQCaIdByoSk3zxRaC5qtlQ',
    'iconSalud':
        'https://blogger.googleusercontent.com/img/a/AVvXsEjiUEkHtphXqv72-WBPEklj1X8sNAv0oELam2VaVlP_nI18zqMcjqIEaLcdILGaUIP7OABZUbcCxukZPwTgaWd6qLFVhs-yueCqR6lGNz7rKJXakWBSG0IcFipsA5Q7jm4da7JO2fb9TKoSKQSdr1282FvOWz_2RZO5vHqOZSFg2b3PcP3LRLLTTg',
    'iconSociales':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhOxzdPvQmbvR6Ne1uY5nsNG5mg2gDumFs2ZbtAEpkuhtxHiPAoHH2aqYIol2tz4KDJDyCftFTzLcAY2N7-6EyLpGC_BkaW36tAwgvmpzR1GjqYrTXqHXJzuAhGjdftPg1PA2ul3WI7jSfADJR8L3NRde2zE18jo78B1F6_LokyAovJM2M421R32w/s320/ic_juridic.png',
    'iconOtros':
        'https://blogger.googleusercontent.com/img/a/AVvXsEihOBewFfDe4bw6qK04Y0UOZFsptxkYp4FWpbtpb2ubOXFd8sjRNd4U9_nJIXMjL3hgDnNVIzHJBF7HLQCpdwlOTIAppQP0D5CksjiP_AsaOXQzYEdTtaKTXS05VIJa1nWTZR8NSIftFGKXAdJNS0LMbQaypHF5IumaweHyAA49XPzqPje13yEjeA',
    'iconProfesionales':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjEWBzWA8LWZZ2pbDA3ELOoosbk2QdHbndyisznwq4hvjghsGhzrBTdYSXqDYdoMbgiwyxBw6XhsqTmVzM8pCINBvkMAs4or9yruwQSjYHwHOdm2Rslai29NLwMlqUvMxXIy-JJOXX6MPtkJbFhepLbh1EU2Bjxhq-Fid5CsGecn_OKukkfryGQVQ/w200-h200/ic_prof.png',
    'iconCosmeticos':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiH4Z8akEdTTw_cVt-eF-j7xR3-MD0q5v17t9-yJdHcWP0VMpPItKEvcf_GbeNNZUSQGrnhTv10_XI3D90xiqzDGf5lcl9G8RkN86q3KKAJqcZNjkD2JZTesGOhqrwTE62Iw3z9AOvzI6RVwJSa0p6ZQceaYZYVAbndkhI0b36c1BJDDQ4I5j0UZA/w200-h200/ic_belleza.png',
    'iconSeguridad':
        'https://blogger.googleusercontent.com/img/a/AVvXsEhaQo9w9LvMk5tpCCNi_Nn22ODbnDO4iU-Rqb44K1PwXkNi4bnVaPsRv74wIJsAnJr3TCtvfi4c8FnhKxyp6cSy8ukNDCSKrf7EanuzTZT1IA_2CouqBXKPIMYRIUCC3-LOq_mHL_6u--OlyJfm50JZ--ulRbU6X1UoiE-eNvjbfRr1PoQrQWW5Zg',
    'iconMusica':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg0iQCaxNIb1sLVYSGh_VvoJSJaJHBB1YslVUXScAHjvMzTPsC_kNvl3SAMPLw5npCb4xYyEuk6BIHsQJcX-rF3UWanXhXGIL2ysmfXSvCCLVLMZEM2oX2-QifgjOBLTkrMn9EBlY2o7_wv53M9P0kCyvqL8eZ5MRUC9OEorJHBB-LhnQ0dRGq87g/s320/ic_musica.png',
    'iconRazonamiento':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjGt5hfanJmNfcI2-kEpsmrVVkK-CGp1iP9xIQySgO3tLp4oMUQDZuW4alHtRHmlgyB82Da5v3rV9X-OkXndR_VRJ8jMxpSgUZfGdzS2lmJRv4bCmsUqZP5DFPdXFDSk6ccQLALG9UYgfUDtMSq0_ZAKpjNWhyWGZEApj6G0sc8eg-aNAcorlhzvA/w200-h200/ic_razonamiento.png',
    'iconAgro':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjscvtCqH1aqJ7ID8S9VuacAu1iqXzDurwNeTNLMJXXMM3dBnDtC_JcBroKTrFLxBu6TWZZJvSxLHJVZcjMlSYGJ7QBa2j_haAdOMmIoHZb1ap-ZWMq0TCyX-0oAXEy1_IZnacREVAuzcTtgzI__D0vli2D7YUH5FU4jcdO3TTZk7p2O6XYb4hxnQ/w200-h200/ic_agro.png',
    'iconCocina':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEieERHURoZHdsU_HYI4ME-C3RYNu1FDx1ycQef59Mq4wOhsD9LUn2xGRt3mlFmoOofoe52wob2SrtTGAuON9imDoR6d6T3BySFfr621JyoAvtHM6I_waZ3OWsfDBMm7idmWCtcZC90xnYr61dXkZWQ9wIF4ySUhxQxhvhS9x9-PCT0IseXKZeZb-A/w200-h200/ic_cocina.png',
    'iconMarketing':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiOUodWqO38n6VFSPyLSrUeSrAtgfHfgdO895smpuYz4XW6jACMj-6P0kuxci4qVrx0YkmJsGK9xWqcWhFQuX4HjGuciEM3zfWOj3WbVilpOjJlY2k2ijXavRLsYVBGNH-ofyHIjlgbC1LOLGpURRmKmIgQLTiY3AUaJzdtJDSnjDljlKJ2s9sVkg/w200-h200/ic_marketing.png',
    'iconTrabajos':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgZtAnPksAPaF9YFv0br1QF7_MnhISyIj_zj7OSou2YRSF5nLAW9BXbZ7sN6p4bu2jUBY_0z0FtWq4Ilk_wSYmh8EZzlaaVefQ5_4kaKivaCl4Wht5ddoDQPY3mruL4ZBOfwFuRMzVxIMlOZ2tsvT6Qrxs-bqJEUT-HDyHlgaXhPoPEh6h21cru8g/w200-h200/ic_trabajos.png',
    'iconIng':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi_k3L-nZj9NBZqI9n7IIoiuKl9W8UUltqTwKXaJBQ6A4JU-BYIo6PixXbyIy6ZJfvs4qtI1YCDwmRxPjrORTrmbgLwEJTKEK1cM3FwIl8KgQ1IHtaVXqs5NBWtYZbYAKkJ8_SiRsYNVmHRK-NlwwMF4KgwhJ6Y4v68e0UA3zs7oynbeoE1JzaZcA/w200-h200/icon_ingenieria.png',
    'iconTransp':
        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjqlpJ4Wua6zioNq5ZvUVfbcmO5iGoTh7L1oxiffB8Ac-nu7n4iGZwybu98k7Rh7kTODwc73ZHmziW1KC_GjaGoAlnQIlLQZ43cPpFe1HK50pXdwnl4w8FU5aEneMwnnOJp6L1bsCThxP2wOWy2tDfwXeFBQ4sd8bUOkgnhEvXADyVWHwH2cDWQ1w/s320/ic_transp.png'
  };

  late DatabaseHandlerGen handler;
  late DatabaseProgHandler handlerProg;
  late DatabaseTICHandler handlerTIC;

  bool darkTheme = true;

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

  Future<Null> initializeDb() async {
    try {
      await DatabaseHandlerGen().initializeDB();
      await DatabaseProgHandler().initializeDB();
      await DatabaseTICHandler().initializeDB();
    } catch (e) {
      print('Error durante la inicialización de bases de datos de main: $e');
    }
  }

  int countFin = 0;
  int countTIC = 0;
  int countProg = 0;
  int countIdiom = 0;
  int countMark = 0;
  int countRaz = 0;
  int countSalud = 0;
  int countSeguri = 0;
  int countIng = 0;
  int countCiencia = 0;
  int countIA = 0;
  int countProf = 0;
  int countArtes = 0;
  int countCocina = 0;
  int countTrab = 0;
  int countAgro = 0;
  int counTransp = 0;
  int countCrypto = 0;
  int countMusic = 0;
  int countModa = 0;
  int countSociales = 0;

  final Map<String, int> categoryCounts = {
    'Finanzas': 0,
    'TIC': 0,
    'Programación': 0,
    'Idiomas': 0,
    'Marketing': 0,
    'Razonamiento': 0,
    'Salud': 0,
    'Seguridad': 0,
    'Ingeniería': 0,
    'Ciencia': 0,
    'IA': 0,
    'Profesionales': 0,
    'Artes': 0,
    'Cocina': 0,
    'Trabajos': 0,
    'Agro': 0,
    'Transporte': 0,
    'Crypto': 0,
    'Música': 0,
    'Moda': 0,
    'Sociales': 0,
  };

  @override
  initState() {
    super.initState();

    getSharedThemePrefs();
    loadCountCourses();
    //newVersionApp();
    initializeDb();
  }

  Future<void> loadCountCourses() async {
    final resultFin = await searchCountCoursesByCategory("Finanzas");
    setState(() {
      categoryCounts['Finanzas'] = resultFin;
    });

    final resultTICGlob = await searchCountCoursesByCategory("TIC");
    final resultTIC = await searchCountCoursesByTIC();
    setState(() {
      categoryCounts['TIC'] = resultTIC + resultTICGlob;
    });

    final resultProgGlob = await searchCountCoursesByCategory("Programación");
    final resultProg = await searchCountCoursesByProg();
    setState(() {
      categoryCounts['Programación'] = resultProg + resultProgGlob;
    });

    final resultIdio = await searchCountCoursesByCategory("Idiomas");
    setState(() {
      categoryCounts['Idiomas'] = resultIdio;
    });

    final resultMark = await searchCountCoursesByCategory("Marketing");
    setState(() {
      categoryCounts['Marketing'] = resultMark;
    });

    final resultRaz = await searchCountCoursesByCategory("Razonamiento");
    setState(() {
      categoryCounts['Razonamiento'] = resultRaz;
    });

    final resultCib = await searchCountCoursesByCategory("Ciberseguridad");
    setState(() {
      categoryCounts['Ciberseguridad'] = resultCib;
    });

    final resultIng = await searchCountCoursesByCategory("Ingenieria");
    setState(() {
      categoryCounts['Ingenieria'] = resultIng;
    });

    final resultDatos = await searchCountCoursesByCategory("Datos");
    setState(() {
      categoryCounts['Datos'] = resultDatos;
    });

    final resultIA = await searchCountCoursesByCategory("IA");
    setState(() {
      categoryCounts['IA'] = resultIA;
    });

    final resultProf = await searchCountCoursesByCategory("Profesionales");
    setState(() {
      categoryCounts['Profesionales'] = resultProf;
    });

    final resultArt = await searchCountCoursesByCategory("Artes");
    setState(() {
      categoryCounts['Artes'] = resultArt;
    });

    final resultCoc = await searchCountCoursesByCategory("Cocina y alimentos");
    setState(() {
      categoryCounts['Cocina y alimentos'] = resultCoc;
    });

    final resultTrab = await searchCountCoursesByCategory("Trabajos Varios");
    setState(() {
      categoryCounts['Trabajos Varios'] = resultTrab;
    });

    final resultAgro = await searchCountCoursesByCategory("Agropecuario");
    setState(() {
      categoryCounts['Agropecuario'] = resultAgro;
    });

    final resultTrans = await searchCountCoursesByCategory("Transporte");
    setState(() {
      categoryCounts['Transporte'] = resultTrans;
    });

    final resultCryp = await searchCountCoursesByCategory("Crypto");
    setState(() {
      categoryCounts['Crypto'] = resultCryp;
    });

    final resultBell = await searchCountCoursesByCategory("Belleza");
    setState(() {
      categoryCounts['Belleza'] = resultBell;
    });

    final resultSalud = await searchCountCoursesByCategory("Salud");
    setState(() {
      categoryCounts['Salud'] = resultSalud;
    });

    final resultSoc = await searchCountCoursesByCategory("Sociales");
    setState(() {
      categoryCounts['Sociales'] = resultSoc;
    });

    final resultMusic = await searchCountCoursesByCategory("Musica");
    setState(() {
      categoryCounts['Musica'] = resultMusic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        iconTheme: IconThemeData(
          color: darkTheme == false ? Colors.grey[850] : Colors.white,
        ), // Cambia el color del botón

        title: Text(
          "Categorias",
          style: TextStyle(
            color: darkTheme == false ? Colors.grey[850] : Colors.white,
            fontSize: 16.0, /*fontWeight: FontWeight.bold*/
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 1),
        child: _listViewCategoryWidget(),
      ),
      drawer: drawerCursin(
        context: context,
        darkTheme: darkTheme,
      ),
    );
  }

  Widget saludoWidget() {
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;
    String palabraBusqueda = '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Hey! ¿Qué vamos a estudiar hoy?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Explorar cursos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color:
                          darkTheme == false ? Colors.grey[450] : Colors.white,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => (TutorialesScreen())));
                    },
                    icon: Icon(
                      Icons.ondemand_video,
                      size: 35.0,
                      color: Colors.grey,
                    ),
                    label: Text(''),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      'Tutorial',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: sizeWidth * 0.95,
            child: Row(
              children: [
                Container(
                  height: sizeHeight * 0.05,
                  width: 5.0,
                  color: Color.fromARGB(255, 84, 84, 84),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: TextField(
                      onSubmitted: (value) {
                        searchCourse(value);
                      },
                      onChanged: (text) {
                        palabraBusqueda = text;
                      },
                      style: TextStyle(
                        color: darkTheme == false
                            ? Colors.grey[450]
                            : Color.fromARGB(150, 255, 255,
                                255), // Cambia este color según tus preferencias
                      ),
                      decoration: InputDecoration(
                        hintText: 'Buscar...',
                        hintStyle: TextStyle(
                          color: darkTheme == false
                              ? Colors.grey[450]
                              : Color.fromARGB(150, 255, 255, 255),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: darkTheme == false
                                ? Colors.grey[450]
                                : Color.fromARGB(150, 255, 255, 255),
                          ),
                          onPressed: () {
                            searchCourse(palabraBusqueda);
                          },
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listViewCategoryWidget() {
    return ListView(
      children: [
        //¡Hey! ¿Qué vamos a estudiar hoy?
        saludoWidget(),

        SizedBox(
          height: 30,
        ),

        // Programación
        buildCategoryWidget(
          title: 'DESARROLLO Y PROGRAMACIÓN',
          imageUrl: categoryIcons['iconDesarrollo'],
          count: '${categoryCounts['Programación']}',
          description:
              'Cursos gratis sobre desarrollo de software, programación, lenguajes, entre otros.',
          category: 'Programacion',
        ),

        // Finanzas
        buildCategoryWidget(
          title: 'FINANZAS Y NEGOCIOS',
          imageUrl: categoryIcons['iconFinanzas'],
          count: '${categoryCounts['Finanzas']}',
          description:
              'Cursos gratis relacionados al mundo de las finanzas, la contabilidad, los negocios y la administración',
          category: 'Finanzas',
        ),

        // TIC
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'INFORMÁTICA Y TIC',
          imageUrl: categoryIcons['iconTIC'],
          count: '${categoryCounts['TIC']}',
          description:
              'Cursos gratis relacionados a las TIC, electrónica, redes, telecomunicaciones ofimática e informática en general.',
          category: 'TIC',
        ),

        // Idiomas
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'IDIOMAS Y LENGUAJES',
          imageUrl: categoryIcons['iconIdiomas'],
          count: '${categoryCounts['Idiomas']}',
          description:
              'Cursos gratis sobre Inglés, Japonés, Koreano, Ortografía y demás idiomas',
          category: 'Idiomas',
        ),

        //IA
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'INTELIGENCIA ARTIFICIAL',
          imageUrl: categoryIcons['iconIA'],
          count: '${categoryCounts['IA']}',
          description:
              'Cursos gratis relacionados al mundo de la inteligencia artificial, redes neuronales, deep learning, machine learning, etc...',
          category: 'IA',
        ),

        // Profesionales
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'FORMACIÓN PROFESIONAL',
          imageUrl: categoryIcons['iconProfesionales'],
          count: '${categoryCounts['Profesionales']}',
          description:
              'Cursos gratis relacionados con el mejoramiento y crecimiento del perfil profesional',
          category: 'Profesionales',
        ),

        // Marketing Digital
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'MARKETING DIGITAL',
          imageUrl: categoryIcons['iconMarketing'],
          count: '${categoryCounts['Marketing']}',
          description:
              'Cursos gratis relacionados con la promoción, publicidad, ventas en línea y marketing en general',
          category: 'Marketing',
        ),

        // Razonamiento Cuantitativo
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'RAZONAMIENTO CUANTITATIVO',
          imageUrl: categoryIcons['iconRazonamiento'],
          count: '${categoryCounts['Razonamiento']}',
          description:
              'Cursos gratis sobre números, cálculo, análisis numéricos, estadística, entre otros',
          category: 'Razonamiento',
        ),

        // Salud
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'SALUD Y BIENESTAR',
          imageUrl: categoryIcons['iconSalud'],
          count: '${categoryCounts['Salud']}',
          description:
              'Cursos gratis sobre el área del bienestar y la salud como medicina, psicología, nutrición, cuidados, entre otros',
          category: 'Salud',
        ),

        // Seguridad Informática
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'SEGURIDAD INFORMÁTICA',
          imageUrl: categoryIcons['iconSeguridad'],
          count: '${categoryCounts['Ciberseguridad']}',
          description:
              'Cursos gratis relacionados con el hacking ético, seguridad en redes, seguridad informática en general',
          category: 'Ciberseguridad',
        ),

        // Trabajos Varios
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'TRABAJOS VARIOS',
          imageUrl: categoryIcons['iconTrabajos'],
          count: '${categoryCounts['Trabajos Varios']}',
          description:
              'Cursos gratis relacionados con trabajos que no requieren una educación formal como limpiador, bodeguero, auxiliar, panadero, voluntario, paseador y más.',
          category: 'Trabajos Varios',
        ),
        // Ingeniería
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'INGENIERIA',
          imageUrl: categoryIcons['iconIng'],
          count: '${categoryCounts['Ingenieria']}',
          description:
              'Cursos gratis relacionados con la ingeniería civil, ingeniería mecánica, ingeniería industrial, ingeniería mecatrónica y afines.',
          category: 'Ingenieria',
        ),

        // Ciencia y Análisis de Datos
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'CIENCIA Y ANÁLISIS DE DATOS',
          imageUrl: categoryIcons['iconDatos'],
          count: '${categoryCounts['Ciencia y Análisis de Datos']}',
          description:
              'Cursos gratis desde básico a avanzado sobre tecnologías, modelos, lenguajes y librerías.',
          category: 'Ciencia y Análisis de Datos',
        ),

        // Música
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'MÚSICA',
          imageUrl: categoryIcons['iconMusica'],
          count: '${categoryCounts['Musica']}',
          description:
              'Cursos gratis sobre instrumentos musicales, géneros, canto, teoría musical, técnica de instrumentos, interpretación, composición, entre otros...',
          category: 'musica',
        ),

        // Cocina y Alimentos
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'COCINA Y ALIMENTOS',
          imageUrl: categoryIcons['iconCocina'],
          count: '${categoryCounts['Cocina y alimentos']}',
          description:
              'Cursos gratis sobre nutrición, alimentos y gastronomía, incluyendo técnicas de cocina, repostería, panadería, cocina internacional, entre otros...',
          category: 'Cocina y alimentos',
        ),

        // Transporte
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'TRANSPORTE',
          imageUrl: categoryIcons['iconTransp'],
          count: '${categoryCounts['Transporte']}',
          description:
              'Cursos gratuitos relacionados con la conducción de vehículos: moto, carro, transporte de carga, transporte en general y más.',
          category: 'Transporte',
        ),

        // Agropecuario
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'AGROPECUARIO',
          imageUrl: categoryIcons['iconAgro'],
          count: '${categoryCounts['Agropecuario']}',
          description:
              'Cursos gratuitos relacionados con el sector agrícola y pecuario, incluyendo agricultura, ganadería, horticultura, piscicultura, apicultura, jardinería, entre otros...',
          category: 'Agropecuario',
        ),

        // Artes
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'ARTES',
          imageUrl: categoryIcons['iconArtes'],
          count: '${categoryCounts['Artes']}',
          description:
              'Cursos gratuitos relacionados con el diseño gráfico, dibujo, literatura, actuación y arte en general, incluyendo pintura, escultura, fotografía, historia del arte, entre otros...',
          category: 'Artes',
        ),

        // Crypto y Trading
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'CRYPTO Y TRADING',
          imageUrl: categoryIcons['iconCrypto'],
          count: '${categoryCounts['Crypto']}',
          description:
              'Cursos gratis relacionados al mundo de las Criptomonedas, el blockchain y demás tecnologías de la web3',
          category: 'Crypto',
        ),

        // Sociales, Sociedades y Jurídicas
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'SOCIALES, SOCIEDADES Y JURÍDICAS',
          imageUrl: categoryIcons['iconSociales'],
          count: '${categoryCounts['Sociales']}',
          description:
              'Cursos gratis sobre derecho, sociedad, leyes, trabajo social, sociología, política, entre otros...',
          category: 'Sociales',
        ),

        // Moda y Belleza
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'MODA Y BELLEZA',
          imageUrl: categoryIcons['iconCosmeticos'],
          count: '${categoryCounts['Belleza']}',
          description:
              'Cursos gratis relacionados con el cuidado de la piel, tatuajes, peluquería, manicura, barbería, pedicura, dermatología, entre otros...',
          category: 'Belleza',
        ),

        // Otros
        SizedBox(height: 3),
        buildCategoryWidget(
          title: 'OTROS CURSOS ...',
          imageUrl: categoryIcons['iconOtros'],
          count: '+800',
          description:
              'Aquí podrás encontrar los cursos que aún no tienen categoría debido al bajo número registrados',
          category: 'Otros',
        ),
      ],
    );
  }

  Widget buildCategoryWidget({
    required String title,
    required String? imageUrl,
    required String count,
    required String description,
    required String category,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: darkTheme == true ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          setLocalNotification(category);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => categorias(
                catProviene: category,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 90.0,
                height: 90.0,
                child: Stack(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl.toString(),
                        width: 90.0,
                        height: 90.0,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 1,
                      left: 2,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueGrey,
                        ),
                        child: Text(
                          count,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.0), // Espacio entre la imagen y el contenido
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: darkTheme == false
                            ? Colors.grey[450]
                            : Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: darkTheme == true
                            ? const Color.fromARGB(255, 191, 191, 191)
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.navigate_next,
                color: darkTheme == false ? Colors.grey[450] : Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> searchCountCoursesByCategory(String category) async {
    final databaseHandlerGen = DatabaseHandlerGen();

    final totalCoursesInCategory =
        await databaseHandlerGen.getTotalCoursesInCategory(category);

    return totalCoursesInCategory;
  }

  Future<int> searchCountCoursesByProg() async {
    final databaseHandlerProg = DatabaseProgHandler();

    final totalCoursesProg = await databaseHandlerProg.getTotalCoursesProg();

    return totalCoursesProg;
  }

  Future<int> searchCountCoursesByTIC() async {
    final databaseHandlerTIC = DatabaseTICHandler();

    final totalCoursesProg = await databaseHandlerTIC.getTotalCoursesTIC();

    return totalCoursesProg;
  }

  void setLocalNotification(String category) async {
    await getOneRandomCourse(category);
  }

  getOneRandomCourse(String category) async {
    final databaseHandlerGen = DatabaseHandlerGen();
    final totalCoursesInCategory =
        await databaseHandlerGen.getTotalCoursesInCategory(category);

    if (totalCoursesInCategory > 0) {
      final randomCourse = await databaseHandlerGen.getRandomCourse(category);
      if (randomCourse != null) {
        sendNotification(randomCourse.title, randomCourse.categoria,
            randomCourse.emision, randomCourse.entidad);
      }
      return totalCoursesInCategory;
    }
  }

  void sendNotification(name, categoria, emision, entidad) async {
    final LocalNotifications localNotifications = LocalNotifications();

    // Genera un número aleatorio entre 1 y 3 (ambos inclusive).
    final random = Random();
    final randomNumber = random.nextInt(3) + 1; // Genera números entre 1 y 3.
    //print('randomNumber: $randomNumber');

    String title = '$name por $entidad';
    String body =
        'Un nuevo curso gratis que necesitas, está $emision. Entra y búscalo.';

    // Define la probabilidad de mostrar la notificación (33% de probabilidad).
    if (randomNumber == 1) {
      await Future.delayed(const Duration(minutes: 2)); // Espera 2 minutos

      await localNotifications.showLocalNotification(
        id: 13,
        title: title,
        body: body,
        data: '',
      );
    } else if (randomNumber == 2) {
      await Future.delayed(const Duration(minutes: 8)); // Espera 2 minutos

      await localNotifications.showLocalNotification(
        id: 13,
        title: title,
        body: body,
        data: '',
      );
    } else if (randomNumber == 3) {
      await Future.delayed(const Duration(hours: 24));

      await localNotifications.showLocalNotification(
        id: 13,
        title: title,
        body: body,
        data: '',
      );
    }
  }

  void searchCourse(palabraBusqueda) {
    if (palabraBusqueda.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => searchedCourses(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => searchedCourses(
            palabraBusqueda: palabraBusqueda,
          ),
        ),
      );
    }
  }
}
