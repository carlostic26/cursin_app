import 'package:cursin/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class TutorialesScreen extends StatefulWidget {
  const TutorialesScreen({super.key});

  @override
  State<TutorialesScreen> createState() => _TutorialesScreenState();
}

class _TutorialesScreenState extends State<TutorialesScreen> {
  bool? darkTheme = false;

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
    getSharedThemePrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkTheme == true ? Colors.grey[850] : Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: darkTheme == false ? Colors.grey[850] : Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Cómo usar Cursin App",
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
              icon: Icon(Icons.search),
              onPressed: () {
                //pass to search screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => searchedCourses(),
                  ),
                );
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: VideoTutorialList(),
    );
  }
}

class VideoTutorialList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          VideoItem(
            title: 'Cómo usar Cursin App',
            videoId: '4tOMd4PnUrY',
          ),
          VideoItem(
            title: 'Buscar cursos de Idiomas en Cursin',
            videoId: 'WHbZLQQR-1E',
          ),
          VideoItem(
            title: 'Buscar cursos de JavaScript en Cursin',
            videoId: 'OhaHtM0Jjsg',
          ),
          VideoItem(
            title: 'Buscar cursos de Python en Cursin',
            videoId: 'kQOWnzSkW5o',
          ),
          VideoItem(
            title: 'Buscar cursos de Programación en Cursin',
            videoId: 'DZVj7UxU298',
          ),
          VideoItem(
            title: 'Buscar cursos de Excel en Cursin',
            videoId: 'ntFCrDEpr0U',
          ),
        ],
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final String title;
  final String videoId;

  const VideoItem({required this.title, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 200, // Ajusta la altura según tus necesidades
          child: WebView(
            initialUrl:
                'https://www.youtube.com/embed/$videoId?rel=0&autoplay=1&showinfo=0&controls=0&modestbranding=0',
            javascriptMode: JavascriptMode.unrestricted,
            userAgent:
                'Mozilla/5.0 (Linux; Android 10; Tablet; rv:68.0) Gecko/68.0 Firefox/68.0',
          ),
        ),
        Divider(),
      ],
    );
  }
}
