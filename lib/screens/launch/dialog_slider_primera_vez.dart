import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cursin/screens/drawer/drawer_options/carruselCertifiedWidget.dart';
import 'package:cursin/screens/drawer/drawer_options/categorias_select.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDialogSlider extends StatefulWidget {
  @override
  _CustomDialogSliderState createState() => _CustomDialogSliderState();
}

//Clase que presenta visualmente un carrusel de información de primera mano para que el usuario entienda la finalidad de la app, la primera vez que la abra.

class _CustomDialogSliderState extends State<CustomDialogSlider> {
  int _currentAviso = 0;

  @override
  void initState() {
    super.initState();
    actualizarPrimerAcceso();
  }

  String cert1_google =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgCL4fwj0YocGblRpvDfgoqIfSPokBV3GthuorPTf8nUdccINVV7ZTurMYvKOmsbLDDFMYBh_w3qaSgF56YHth423P2Fo5kydxesUW32ff3x30dNFra332WXFJO8Ze3yqK61TIY4iDPx3x0Tq4UXjMwd0sg_Mf5xCi5GipxPSdGiZmbrZwMJ49A5Q/w400-h283/Comercio-electronico-min.jpg';
  String cert2_linkedin =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgjr1twZVdlY1iBO3Js6QFX6N4LiBfWFZhBX7SS1adofN8I9cc29Mx4jQK1Kw75qCkQwr0v2CzvnFn0NJY3DqJRVb1SdZjzhD7weB6068jsRWgqz3um2UCc14D-75QcT00C_MgqCCFG9fsnn6mFD-yeaY9oaclHImGy_Eqgr20TC_R14iwuhw1rtQ/w400-h309/1675821542143.png';
  String cert3_slim =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi7I2KCkhaqgKLuDDsQ7_l-XFfR9ptQwqejnKg7_1rWfKDcvIyXQ7wmn4-IeanSYkhu-Msz6aNUw1DA2ltLXbe3jRmIimBnVS2J5zATuhJ61X8EjIL4WmmDgT9l4V0GUgNH9bgZ1WYj9bgHRNZvCMo6m54TRqLEA8ocuRG5FhAxCvonMeJDPYID8w/w400-h310/1679945095.webp';
  String cert4_microsoft =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgSkc0y-2FeLVCyi4rgp0V4CX6wWbXPXUD6LTnQYJ2eIaG2t0ia81vYHIDYQrFgk5DrxRefQ6epWx_TTE5xsR8FgbGKEpM0_g7bBHWEsrJeRcs0lZtzTRII6rOsJaSq-eoQp7-_MxuiekQIWlZsJqWH43AXREHtK_jS45FUm4DtyJNtd2KrWePrnw/w400-h261/Microsoft%20Certified%20Azure%20Architect%20Expert.png';
  String cert5_hp =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgmtTRTcuxWM-1VSRT_oqtLiJu74JqQq_EQ0R84n5A6I3eyo_5QUI9VssBL13Za0WymaqI8ywmrcSL0lx5q3UR5IOvfPmMDod2OzsWGvc_f2zVW7sA3ksdj7pCChtXx3pQkx3X_7dhyjkChuaCT0m5cvJg7WMgybxmW2mhPCQY8w4FfVTmBWjrFAA/w400-h283/p1.jpg';
  String cert6_cognitive =
      'https://blogger.googleusercontent.com/img/a/AVvXsEgFk489twXrZ8AdNyCnvEV_c55Voq8m8zVZ-f1cNLcDIuaPvDa2bFD2ZisRHSfKEY2nWw25yNYSbrPWW8fkR7j7mbAAU-i6c_G99BpweQAM9gP9BJ9-seN90duYwa6J3WxgGrCQka682j8fQnxIB-whsTOjGfOoWIga2qlmrmbbobAgNRkp1SXCEA=w400-h248';
  String cert7_cisco =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgEui1Ck10AWun-D6hfY52MWMg77c0538GHW-T-7Cr7QO5mlx0FPYDJ8_32w6ixBjxjQRC2b1qjDs5YyxqXbiOj5quvOu8P7zJHhTTRUzVJ8XX9AsGxo-bcCOLS0_XKuMMiOCKi94oHuT4oyBnJsIih4HHN-3KE2WPzxIo_riXkao88OtxG3H8ffg/w400-h300/EfO76ckX0AEzadm.jpg';
  String cert8_onu =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh3ZSByqbws2XXgSCGkpofR0aYBmp-Q1YHmY1MoCXPMCcbJzUPpbb3WTYmOj3n5RYeRTnFbL3CeHZ_gt75vs-rPq5_hPkVh4X7H9TXd4xGtG1ZnaHCL6vzQ3Tr118l5EAKlD4vRvVnMs_mYg8WjWL8Kr-PgVt6_g7JDxTjrvL_o14vaKIYV7lKMOA/w400-h291/DSkxnY6VAAEnCpR.jpg';
  String cert9_ibm =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi9kevMAmisH7vkonyK76uXx_XG09L8DJ2FBDtEWGgw9OywsGlkOvy57L-mZt1_YAwlZB0Qy_hQS9DpEbtxcOGm5CejUI2dcmSrXXEMksJp78htpT57ORb6orsfbPoz0yycDHtYq_rDz7H4A1eRZoYIuN5KhGpaCHetEH4IwrPUxtPXj5xBIjwEJQ/w400-h264/1605167899868.jpg';
  String cert10_unicef =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiagh-9QfGroOBMwfqQl5zdcvVWU6XWOuDRBPJX8MJUDeFXJsZkElThRHNUEuBOmhQlTKiY7l3vKMwst95A8iLfPErVPr5hawP8Cm_RDmfRNBSyoBEKdts8vCRwWNCMiD_yx1E4-mp3mxXRxM05vVkUAQwATyH9GM1tIAaWb6rGQwg3IL1U9fsvGQ/s320/unicef.webp';
  String cert11_openbootcamp =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhoSKJk_Eeqe3OeHCwI2_mLTKg1UZFd1F04IPCM1qF19x-nL4UF-poKgI4PbQ7w_yYbg4vrBjba4I2_uAUda5AC23SKUEgCCZXl4GrW7iW_m_DyEpJQMka8IGAOyHxUbhsUV0QT5PUvuCeOwhq1skUm3P0TOwDGi6fLw5plQx_qAMDKL3s2MFTSjg/s320/openBootCamp.png';
  String cert12_intel =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhOskR9RwNSOC0qCRm-Pp81LZGOZMJYMXGLiNf87yl18p2FW42FRQzVLQDBa_l2ZZVHHurLPwMt0uz3y0DNZj1NfEl8IM1Pxn_2hDH0AQtjgkyJZ4hfvXCLw4QLJMk5HGpZ_FX8NFZ8_ZOQ0UwXmSsx0JKkj72CKbzM86-ksZMh-TvmMSQtJhfKQg/s320/intel.webp';
  String cert13_freecodecamp =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgFtX1-NXofu2m6EYZQLfGgukbUt9_US4i0AgdG4yswKLH5tj2DrD9L3FO2tvJKW0wK2YDqM1bBb-GGznarZmvg8Z9jNjFrgWHo9ch6D7qShx-EfHkMgCM_L14rUMfzazAlEtChGykX7jPvLkJRU2Mkq1r6YQ4UruhrIN0K8h79Be6_ZCecHRfHPw/s320/FreeCoodeCamp.png';
  String cert14_efset =
      'https://blogger.googleusercontent.com/img/a/AVvXsEjwe6Y_dO0y_U1JGtC32kynzgR9_ibg1kxoWtZkP7jZcYvxYiFvsW-e-eZQa43N60FgLeZ1bKOvpRnJI6YdnmK0oh0E7yov1PqcipNLEH99ezL6jTc3i3X3KiR5kKeS7W4wwDnjNNiHeu2Jju1n13osUTUlpAY9rdYZx6KvgHh_-EWj_wGAmToZIA=w338-h298';
  @override
  Widget build(BuildContext context) {
    double widthCertifiedImage = 500;

    List<Widget> _certificados = [
      Container(
        child: CachedNetworkImage(
          imageUrl: cert1_google,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert2_linkedin,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert3_slim,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert3_slim,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert4_microsoft,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert5_hp,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert6_cognitive,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert7_cisco,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert8_onu,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert9_ibm,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert10_unicef,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert11_openbootcamp,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert12_intel,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert13_freecodecamp,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
      Container(
        child: CachedNetworkImage(
          imageUrl: cert14_efset,
          width: widthCertifiedImage,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          placeholderFadeInDuration: Duration(milliseconds: 200),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
      ),
    ];

    List<Widget> _avisos = [
      Column(children: [
        SizedBox(height: 10),
        Text(
          '🤔¿Qué es Cursin?🤔',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: 'Es una app muy útil para ',
              ),
              TextSpan(
                text: 'encontrar',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' cientos de ',
              ),
              TextSpan(
                text: ' cursos',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' online',
              ),
              TextSpan(
                text: ' gratuitos',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' de diferentes sitios de internet y plataformas educativas ' +
                    'como Google, IBM, Microsoft, Cisco, ONU, hp, Unicef, Meta, Kaggle, ' +
                    'intel entre muchas otras más, con la posibilidad de obtener un',
              ),
              TextSpan(
                text: ' certificado',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' de finalización.',
              ),
            ],
          ),
        )
      ] // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
          ),
      Column(children: [
        SizedBox(height: 10),
        Text(
          '📚¿Por qué debo tenerlo?🤳🏻',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text:
                    'Porque ya no tendrás que pagar por conocimiento.\n\nPorque',
              ),
              TextSpan(
                text: ' siempre ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'vas a necesitar',
              ),
              TextSpan(
                text: ' cursos gratis. ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'para tu conocimiento, HV o LinkedIn.',
              ),
              TextSpan(
                text: '\n\nPorque la app se',
              ),
              TextSpan(
                text: ' actualiza ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'constantemente con',
              ),
              TextSpan(
                text: ' nuevos cursos ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'para que siempre tengas las ganas de',
              ),
              TextSpan(
                text: ' aprender  ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'lo que sea sin tener que',
              ),
              TextSpan(
                text: ' pagar por ello.',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ] // Agrega aquí otros widgets que quieras mostrar en el primer aviso      ],
          ),
      Column(children: [
        SizedBox(height: 10),
        Text(
          '👀Cursin no emite cursos⚠️',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: 'Cursin',
              ),
              TextSpan(
                text: ' no es ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'una plataforma que produce los cursos online.\n\n',
              ),
              TextSpan(
                text: 'Cursin busca, indexa,',
              ),
              TextSpan(
                text: ' recopila y',
              ),
              TextSpan(
                text: ' organiza ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    'los diferentes accesos a cursos online gratuitos de toda',
              ),
              TextSpan(
                text: ' la web.',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ]),
      Column(children: [
        SizedBox(height: 10),
        Text(
          'No se recopilan datos',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: 'Cursin no recopila datos ni información, y no solicitamos ningún registro.\n\n' +
                    'Los registros a los cursos son a través de las plataformas web que lo emitan.',
              ),
            ],
          ),
        )
      ]),
      Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //carrusel
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(
                child: CarouselSlider(
                  items: _certificados,
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.25,
                      autoPlayInterval: const Duration(seconds: 2),
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9),
                ),
              ),
            ),

            //SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Entiendo que',
                  ),
                  TextSpan(
                    text: ' Cursin ',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'me servirá como una buena',
                  ),
                  TextSpan(
                    text: ' herramienta',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' para',
                  ),
                  TextSpan(
                    text: ' encontrar ',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'cursos online',
                  ),
                  TextSpan(
                    text: ' gratis ',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'cuando más lo necesite.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 3, 60, 90)),
              ),
              child: Text(
                'Finalizar',
                style: TextStyle(fontSize: 13),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => CategoriasSelectCards()),
                );
              },
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 36, 53),
      body: AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.50,
          child: Column(
            children: [
              Expanded(
                child: CarouselSlider(
                  items: _avisos,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.60,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentAviso = index;
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicators(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < 5; i++) {
      indicators.add(Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentAviso == i ? Colors.green : Colors.grey,
        ),
      ));
    }
    return indicators;
  }

  void actualizarPrimerAcceso() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? primerAcceso = prefs.getBool('primerAcceso');

    if (primerAcceso = true) {
      // Si primerAcceso es true, cambiar su valor a false
      await prefs.setBool('primerAcceso', false);
    }
  }
}
