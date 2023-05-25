import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/model/dbhelper.dart';
import 'package:cursin/model/notification_api.dart';
import 'package:cursin/screens/drawer_options/certificados.dart';
import 'package:cursin/screens/courses_webview.dart';
import 'package:cursin/screens/drawer_options/categorias_select.dart';
import 'package:cursin/screens/drawer_options/search_courses.dart';
import 'package:cursin/screens/infoScreens/agradecimientos.dart';
import 'package:cursin/model/curso_lista_model.dart';
import 'package:cursin/screens/detail_course.dart';
import 'package:cursin/screens/infoScreens/info_app.dart';
import 'package:cursin/screens/drawer_options/ultimos_cursos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mailto/mailto.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursesFavs extends StatefulWidget {
  const CoursesFavs({super.key});

  @override
  State<CoursesFavs> createState() => _CoursesFavsState();
}

class _CoursesFavsState extends State<CoursesFavs> {
  late DatabaseHandler handler;
  Future<List<curso>>? _curso;

  //ads variables
  late BannerAd staticAd;
  bool staticAdLoaded = false;

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  void loadStaticBannerAd() {
    staticAd = BannerAd(
        adUnitId: //test: ca-app-pub-4336409771912215/8304641094  ||  real: ca-app-pub-4336409771912215/1019860019

            'ca-app-pub-4336409771912215/1019860019',
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            staticAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('ad failed to load ${error.message}');
        }));

    staticAd.load();
  }

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
    loadStaticBannerAd();

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {
        _curso = getListFav();
      });
    });

    //show notifications daily || PUEDE QUE ESTO NO SIRVA
    NotificationApi.init(initScheduled: true);
    listenNotifications();

    super.initState();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotifications);

  void onClickedNotifications(String? payload) {
    Restart.restartApp();
  }

  Future<List<curso>> getListFav() async {
    return await handler.misFavoritos();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _curso = getListFav();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Navigator.pop(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => CategoriasSelectCards()),
        );
        super.dispose();
        return true;
      },
      child: Scaffold(
        backgroundColor: darkTheme1 == true ? Colors.grey[850] : Colors.white,
        appBar: AppBar(
          title: Text(
            "Cursos guardados",
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
                        catProviene: 'sinCategoria',
                        puntoPartida: 'home',
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
              return Center(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: RichText(
                      text: TextSpan(
                        text: "No tienes ningún curso guardado por el momento.",
                        style: TextStyle(
                            color: darkTheme1 == true
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              var items = snapshot.data ?? <curso>[];
              if (items.length == 0) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No se encontraron cursos guardados',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                );
              }

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
                        //Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetail(
                              td: items[index],
                              puntoPartida: 'fav',
                              catProvino: 'sinCategoria',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 5, 1, 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: darkTheme1 == true
                                ? Colors.grey[850]
                                : Colors.white, // Your desired background color
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            child: new Row(
                              children: <Widget>[
                                //IMAGEN DEL CURSO
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(1.0, 1.0,
                                        0.0, 1.0), //borde de la imagen
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CachedNetworkImage(
                                        imageUrl: items[index].imgcourse,
                                        width: 120.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    )),
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
                                                        items[index].entidad,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: darkTheme1 ==
                                                                  true
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  175,
                                                                  175,
                                                                  175)
                                                              : Colors
                                                                  .grey[850],
                                                        ),
                                                      ),

                                                      //emision
                                                      Text(items[index].emision,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: darkTheme1 ==
                                                                          true &&
                                                                      items[index]
                                                                              .emision ==
                                                                          'Con certificado gratis'
                                                                  ? Colors
                                                                      .greenAccent
                                                                  : darkTheme1 ==
                                                                              false &&
                                                                          items[index].emision ==
                                                                              'Con certificado gratis'
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          1,
                                                                          77,
                                                                          40)
                                                                      : darkTheme1 == false ||
                                                                              darkTheme1 == true &&
                                                                                  items[index].emision !=
                                                                                      'Con certificado gratis'
                                                                          ? Colors
                                                                              .grey
                                                                          : null,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
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
                    );
                  },
                ),
              );
            }
          },
        ),
        bottomNavigationBar: Container(
          height: 60,
          child: Center(
            child: Column(
              children: [
                Container(
                  //load de ad and give size
                  child: AdWidget(
                    ad: staticAd,
                  ),
                  width: staticAd.size.width.toDouble(),
                  height: staticAd.size.height.toDouble(),
                  alignment: Alignment.bottomCenter,
                )
              ],
            ),
          ),
        ),
        drawer: _getDrawer(context),
      ),
    );
  }

  bool _switchValue = false;

//NAVIGATION DRAWER
  Widget _getDrawer(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: darkTheme1 == true ? Colors.grey[850] : Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Usuario Cursin",
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                "Bienvenido",
                style: TextStyle(color: Colors.white),
              ),
              currentAccountPicture: Image.asset('assets/logo_icon.png'),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage('assets/blue_background.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              child: Row(
                children: [
                  Transform.scale(
                    scale: 0.6,
                    child: CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                          //update to sharedPreferences and set new theme
                          updatingTheme();
                        });
                      },
                      activeColor: Colors.grey,
                      trackColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 1, 1),
                    child: Text(
                        darkTheme1 == true
                            ? 'Activar modo claro'
                            : 'Activar modo oscuro',
                        style: TextStyle(
                          color: darkTheme1 == true
                              ? Colors.white
                              : Colors.grey[850],
                        )),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text("Buscar un curso",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.search,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {GoSearchCourses(context)},
            ),
            ListTile(
                title: Text("Últimos cursos agregados",
                    style: TextStyle(
                        color: darkTheme1 == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.date_range,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => UltimosCursosLista()));
                }),
            ListTile(
              title: Text("Certificados",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.workspace_premium,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => //aqui al tocar item de lista se pasa a su respectiva pantalla de editar
                            //que puede ser reemplazada por la de INFO CURSO en completos
                            certificadosScreen(),
                  ),
                ),
              },
            ),
            ListTile(
              title: Text("Categorías",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.category,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => CategoriasSelectCards()))
              },
            ),
            ListTile(
                title: Text("Mis Favoritos",
                    style: TextStyle(
                        color: darkTheme1 == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.favorite,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () => {
                      Navigator.pop(context),
                    }),
            ListTile(
                title: Text("Problemas al entrar a un curso",
                    style: TextStyle(
                        color: darkTheme1 == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.sentiment_very_dissatisfied_sharp,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  _showDialogBugCursok(context);
                }),
            ListTile(
                title: Text("Trucos informáticos",
                    style: TextStyle(
                        color: darkTheme1 == true
                            ? Colors.white
                            : Colors.grey[850])),
                leading: Icon(
                  Icons.important_devices,
                  color: darkTheme1 == true ? Colors.white : Colors.grey[850],
                ),
                onTap: () {
                  //open webview and load list from youtube
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => webview(
                        nameCourse: 'Trucos Informáticos',
                        urlCourse:
                            'https://www.youtube.com/playlist?list=PLrCQaitBpNfe8wZbLXihPq6NzoJi1-5Gm',
                        imgCourse:
                            'https://scontent.fctg2-1.fna.fbcdn.net/v/t39.30808-6/326157095_1338018920368018_4091268538982312361_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=e3f864&_nc_eui2=AeHg160AHWJ_aFe4-mCsMuR3UjSfC_jF799SNJ8L-MXv3xQGFdU5HGaGwpuyN88KMFugo1s9P4vhthymLWrgC0Xp&_nc_ohc=VilTy-FShQYAX9Du8eV&_nc_ht=scontent.fctg2-1.fna&oh=00_AfDoBLA9_f8Ze2bpW17LTMFUt1aey7_-xUM7qz9pV3MN2w&oe=63D7AC44',
                        nombreEntidad: 'TICnoticos',
                      ),
                    ),
                  );

                  //muestra por 3 seg dialogo de carga || a los 3 segundos se cierra el dialogo
                  showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.of(context).pop(true);
                        });
                        return const Center(
                          child: const CircularProgressIndicator(),
                        );
                      });
                }),
            Divider(
              color: Colors.grey,
            ),
            Text("  Información",
                style: TextStyle(
                    color:
                        darkTheme1 == true ? Colors.white : Colors.grey[850])),
            ListTile(
              //Nombre de la app, objetivo, parrafo de uso basico, creador, linkedin de creador, etc
              title: Text("Info de la App",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.info,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {showinfo(context)},
            ),
            ListTile(
              title: Text("Reportar un problema (bug)",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.bug_report,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => _mailto(),
            ),
            ListTile(
              title: Text("Politica de privacidad",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.policy,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => launch(
                  'https://www.ticnoticos.com/2022/09/politica-cursin.html'),
            ),
            ListTile(
              title: Text("Ayúdanos a mejorar",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.feedback,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => _mejorar(),
            ),
            ListTile(
              //Nombre de la app, objetivo, parrafo de uso basico, creador, linkedin de creador, etc
              title: Text("Agradecimienos",
                  style: TextStyle(
                      color: darkTheme1 == true
                          ? Colors.white
                          : Colors.grey[850])),
              leading: Icon(
                Icons.military_tech,
                color: darkTheme1 == true ? Colors.white : Colors.grey[850],
              ),
              //at press, run the method
              onTap: () => {GoAgradecimientos(context)},
            ),
          ],
        ),
      ),
    );
  }

  _showDialogSolicitarCurso(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Solicitar Cursos",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Puedes solicitar el curso que no hayas podido encontrar en Cursin\n\nTenemos un grupo de Telegram para ello, donde podremos agendar y poner en pendiente ese curso que no has podido encontrar.\n\nAntes de solicitarlo, por favor asegurate de haber buscado muy bien en el listado de cursos dentro de las cateogrias disponibles',
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
                        'Solicitar',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                      onPressed: () => {
                            Navigator.pop(context),
                            launch('https://t.me/cursosgratisconcertificado'),
                          }),
                ),
              ]);
        });
  }

  void _showDialogBugCursok(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.only(left: 20, right: 10),
              title: Center(
                  child: Text("¿No puedes entrar a un curso?",
                      textAlign: TextAlign.center)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                height: 400,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'En algunos teléfonos la carga de anuncios suele tardarse más que en otros, dependiendo del tipo de smartphone que tengas. \n' +
                            '\nTe recomendamos 4 posibles soluciones: \n\n' +
                            '1. ¡No te aceleres! no ingreses tan rápido a los cursos cuando recien abras la app. Esto no le da tiempo a tu telefono de cargar los componentes necesarios para funcionar. Revisa varios cursos antes de entrar mientras esperas.' +
                            ' \n\n2. Verifica tu conexión a internet. Los cursos funcionan solo si tienes conexión a internet, cambiate a WiFi si no puedes entrar con datos móviles.' +
                            ' \n\n3. Corrige tu DNS de conexion para que no bloquee los anuncios, ya que estos son necesarios para que Cursin pueda seguir existiendo.' +
                            ' \n\n4. Intenta volver abrir el curso 2 o 3 veces. O vuelve en un par de minutos.',
                        style: TextStyle(color: Colors.black, fontSize: 13.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                              'Entiendo',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            //when user press "De acuerdo", it wil continue to add course dialog to pass another screen
                            onPressed: () => {
                                  Navigator.pop(context),
                                }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  void _showDialogCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      " WoW!",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Todas las categorías estarán disponibles en los próximos dias',
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ]),
              children: <Widget>[
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
                      'Ok',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () => CategoriasSelectCards(),
                  ),
                ),
              ]);
        });
  }

  void showinfo(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => infoApp(context),
      ),
    );
  }

  void GoAgradecimientos(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => agradecimientosScreen(context),
      ),
    );
  }

  void GoSearchCourses(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => searchedCourses(
          catProviene: 'sinCategoria',
          puntoPartida: 'home',
        ),
      ),
    );
  }

  Future _mailto() async {
    final mailtoLink = Mailto(
      to: ['cursinapp@gmail.com'],
      cc: [''],
      subject: 'Reporte bug de app Cursin',
      body:
          'Hola. Me aparece este bug. Seria bueno que lo revises y lo repares tan presto puedas. Adjunto capture de evidencia',
    );
    await launch('$mailtoLink');
  }

  Future _mejorar() async {
    final mailtoLink = Mailto(
      to: ['cursinapp@gmail.com'],
      cc: [''],
      subject: 'Pueden que Cursin sea mejor',
      body: 'Hola. Considero que pueden mejorar la app si ',
    );
    await launch('$mailtoLink');
  }

  void shareText() {
    Share.share(
        "Te comparto la App de Cursin, para que encuentres cursos totalmente gratis y con certificado incluido🥳" +
            "\n\nLa App recopila y sube semanalmente cursos sobre:" +
            "\n🖥️ Desarrollo Web, móvil, front, back" +
            "\n📚 Informática y TIC" +
            "\n🧬 Salud y Bienestar" +
            "\n🈵 Idiomas" +
            "\n💵 Finanzas y administración" +
            "\n⚖️ Ciencias sociales y jurídicas" +
            "\n🎓 Ingenierías" +
            "\n🎉 Mucho más..." +
            "\n\n\nBájala directamente desde la PlayStore: \nhttps://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }

  updatingTheme() async {
    //when user tap,  the values set reverse

    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    bool? darktheme2 = themePrefs.getBool('isDarkTheme');

    //if darktheme is dark, then darktheme will be light
    if (darktheme2 == true) {
      setState(() {
        themePrefs.setBool('isDarkTheme', false);
        darkTheme1 = false;
      });
    } else {
      setState(() {
        themePrefs.setBool('isDarkTheme', true);
        darkTheme1 = true;
      });
    }
  }
}
