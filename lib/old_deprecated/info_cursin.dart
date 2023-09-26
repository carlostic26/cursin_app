import 'package:carousel_slider/carousel_slider.dart';
import 'package:cursin/screens/infoScreens/info_app.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class infoApp2 extends StatefulWidget {
  @override
  _infoApp2State createState() => _infoApp2State();
}

class _infoApp2State extends State<infoApp2> {
  int _currentAviso = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                text: 'Siempre ',
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
                text: '\n\nLa app se',
              ),
              TextSpan(
                text: ' actualiza ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'constantemente, añadiendo',
              ),
              TextSpan(
                text: ' nuevos cursos ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'para que siempre tengas la posibilidad de',
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
                text: ' pagar nada.',
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
                text: 'Esta app',
              ),
              TextSpan(
                text: ' no es ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'una plataforma que produce los cursos gratiso.\n\n',
              ),
              TextSpan(
                text: 'Su objetivo es buscar, indexar,',
              ),
              TextSpan(
                text: ' recopilar y',
              ),
              TextSpan(
                text: ' organizar ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'los diferentes accesos a cursos online gratuitos de',
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
          '⚠️No se recopilan datos⚠️',
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
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
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
                    text: 'me servirá como ',
                  ),
                  TextSpan(
                    text: 'herramienta',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' para',
                  ),
                  TextSpan(
                    text: ' encontrar cursos ',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'online',
                  ),
                  TextSpan(
                    text: ' gratuitos ',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'cuando lo necesite.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 3, 60, 90)),
              ),
              child: Text('Finalizar'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => infoApp(context)),
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
          height: MediaQuery.of(context).size.height * 0.50,
          child: Column(
            children: [
              Expanded(
                child: CarouselSlider(
                  items: _avisos,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.5,
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicators(),
              ),
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
}
