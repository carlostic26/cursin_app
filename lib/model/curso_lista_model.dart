class curso {
  final String title;
  final String entidad;
  final String categoria;
  final String emision;
  final String imgcourse;
  final String urlcourse;
  final String idioma;
  final String duracion;
  final String description;


  curso({
    required this.title,
    required this.entidad,
    required this.categoria,
    required this.emision,
    required this.imgcourse,
    required this.urlcourse,
    required this.idioma,
    required this.duracion,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'entidad': entidad,
      'categoria': categoria,
      'emision': emision,
      'imgcourse': imgcourse,
      'urlcourse': urlcourse,
      'idioma': idioma,
      'duracion': duracion,
      'description': description,
    };
  }

  curso.fromMap(Map<String, dynamic> res)
      : title = res["title"],
        entidad = res["entidad"],
        categoria = res["categoria"],
        emision = res["emision"],
        imgcourse = res["imgcourse"],
        urlcourse = res["urlcourse"],
        idioma = res["idioma"],
        duracion = res["duracion"],
        description = res["description"];

  @override
  String toString() {
    return 'curso{title: $title, entidad: $entidad, categoria: $categoria, emision: $emision, imgcourse: $imgcourse, urlcourse: $urlcourse, idioma: $idioma, duracion: $duracion, description: $description}';
  }
}
