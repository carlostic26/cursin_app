import 'package:cached_network_image/cached_network_image.dart';
import 'package:cursin/screens/drawer/drawer_options/home_menu_categoria.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo(
      '¿Qué es Cursin?',
      'Es una app tipo buscador, que sirve para encontrar cientos de cursos online gratuitos de diferentes sitios de internet y/o plataformas educativas ' +
          'como Google, IBM, Microsoft, Cisco, ONU, hp, Unicef, Meta, Kaggle, intel entre otras.\n\nDichas plataformas pueden emitir certificados de finalización sin costo, después de completar el curso.',
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiY6afS3X7LodjovbD14vTA3uGM-1cwgvofGWJ1VjPMhifTXV0ALdosXkvrzw5m1BxsyjqFe2QIs2Y8EsFDyeGx7qKYHBOXBNBNWR-IZwOSNmuGQjhbeVYl-CL-pJcIbhiIg1GUsyn__OEjAXN_0hySv-WjOYcK65EbU2M4q2vvKWyxE2S141NiGiql/s320/img_1.png'),
  SlideInfo(
      '¿Por qué tenerlo?',
      'Porque ya no tendrás que pagar por conocimiento. Siempre vas a necesitar cursos gratis para tu conocimiento, Curriculum Vitae (CV), Hoja de Vida (HV) o LinkedIn. \n\nLa app se actualiza constantemente con cursos nuevos para que siempre tengas las ganas de aprender lo que sea sin tener que pagar por ello.',
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEghS0bE8X8cQrq14x3g7QwwkKNnRP-9LK9llefhe9z68s3aMkntzM2cTReEBNg6vJj35joc-hqSvWyIrt_eIvuiM9bGWHYELPHNNX-EwIdvtgYuWWOuM4xFGuRXytpB9W_85SpehRgoqAVfNOsWzbUjyYmzzXMHq8vwXRTrQMIutIYnXmO0VTpNWXne/s320/img3.png'),
  SlideInfo(
      'Cursin no emite cursos',
      'Esta app no es una plataforma que produce los cursos gratis. Cursin solo busca, indexa, recopila y organiza los diferentes accesos a cursos online gratuitos de toda la web.',
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg9Gev-CSgANqqGD-9F881ORTI3Ovgy8BZqboQryVt39IcGiSVHHVtcuW6RaZYrlbvr8c7o07T87vKbXgkG1QXDSEQ2zEwDtpvBF_jp93FD8vRM0VL0bCTecmgyf3bf1EJ4_JnXg7yqBUipCFyFWeuZw3hL_QQ17_w4rbx8cCAxfatFg7W3uWyRpagl/w400-h246/img4.png'),

  SlideInfo(
      'Tampoco se recopilan datos',
      'Sientete seguro. Esta app no fue creada para recopilar datos o información. Tampoco se solicitan registros de sesión dentro de la app. \n\nLos registros de sesión o inicio de sesión son directamente dentro de los cursos que emiten las diferentes plataformas.',
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhZM7LggUWHiysqmEK8NlSN3PTiifx0dY_9yeQj73rmJGOKzWvc2hjVbu4hoA64uJs3tjEx3X_d6ArDZwvIK3OEyP0CK4qScgEyUvbW9IUK2_booN26v5sl6uvP4TBZ_8k2t6tXw2Wb6_LIv44QutI__nSoXLZ8ZTG17C89IHfLPfwzYpOTEaMeu99V/w400-h246/img5.png'),

//checkbox
  SlideInfo(
      'Comprendo que...',
      'Cursin es un buscador de cursos y no es dueño de ellos. \n\nAunque todos los cursos son gratis, algunos pocos pueden no emitir diplomas o certificados. \n\nCursin se actualiza constantemente para avisarme cuando hay cursos nuevos. \n\nCursin me servirá como herramienta para encontrar cursos online gratis cuando lo necesite.',
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiqMAKKMpgeugG5DtqGLdUlYqIimMoi6KCbn12CsnIYB0JGbWT3Zc3MmASM16eETFiESLLKq-ZqWC4kmZHtKeMQAafD0p0w4j8CfwAfRimQEksLVYpWg5ms0FDOI2DWPWiSsDFWIcJ9eVT6QHi4J0wFAt9n89JP1G0RzbHFNHumaIaH52rkrb-_-c0l/w400-h246/img6.png'),
];

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController pageviewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();
    pageviewController.addListener(() {
      final page = pageviewController.page ?? 0;

      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
    });

    initTheme();
  }

  Future<void> initTheme() async {
    SharedPreferences themePrefs = await SharedPreferences.getInstance();
    themePrefs.setBool('isDarkTheme', true);
  }

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        children: [
          PageView(
            controller: pageviewController, // Agregamos el controlador
            physics: const BouncingScrollPhysics(),
            children: slides
                .map((slideData) => _Slide(
                      title: slideData.title,
                      caption: slideData.caption,
                      imageUrl: slideData.imageUrl,
                    ))
                .toList(),
          ),
          // Aquí agregamos la condición if para mostrar el botón de comenzar
          if (endReached)
            Positioned(
                bottom: 30,
                right: 30,
                child: ElevatedButton(
                  onPressed: () {
                    guardarPrimerAcceso();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => HomeCategoriasSelectCards()),
                    );
                  },
                  child: const Text(
                    'Comenzar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Cambia el color de fondo a verde
                  ),
                ))
        ],
      ),
    );
  }
}

void guardarPrimerAcceso() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? primerAcceso = prefs.getBool('primerAcceso');
  if (primerAcceso == null || primerAcceso == true) {
    await prefs.setBool('primerAcceso', false);
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide(
      {required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    final size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  width: size.width * 0.7,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      width: 50, // Ajusta este valor a tu necesidad
                      height: 50, // Ajusta este valor a tu necesidad
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(caption,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
