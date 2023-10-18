import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EntidadesScreen extends StatelessWidget {
  final List<String> imageList = [
    // Agrega aquí tus URLs de imagen
    'https://cdn.icon-icons.com/icons2/730/PNG/512/google_icon-icons.com_62798.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwIVcqPansx3h5CDgYvond1crW5Q-LxIibxlByeJlpsQIAd7m6gwSMR5jCyo8E7gtB0Pw&usqp=CAU',
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid de Imágenes'),
      ),
      body: GridView.builder(
        itemCount: imageList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // ajusta esto según tus necesidades
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print('Tocaste la imagen ${index + 1}');
            },
            child: CachedNetworkImage(
              imageUrl: imageList[index],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
