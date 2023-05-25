class favs {
  final int id;
  final String title;
  final String entidad;
  final String categoria;
  final String emision;
  final String imgcourse;
  final String urlcourse;
  final String description;

  favs({
    required this.id,
    required this.title,
    required this.entidad,
    required this.categoria,
    required this.emision,
    required this.imgcourse,
    required this.urlcourse,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'entidad': entidad,
      'categoria': categoria,
      'emision': emision,
      'imgcourse': imgcourse,
      'urlcourse': urlcourse,
      'description': description,
    };
  }

  favs.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        entidad = res["entidad"],
        categoria = res["categoria"],
        emision = res["emision"],
        imgcourse = res["imgcourse"],
        urlcourse = res["urlcourse"],
        description = res["description"];

  @override
  String toString() {
    return 'todo{id: $id, title: $title, entidad: $entidad, categoria: $categoria, emision: $emision, imgcourse: $imgcourse, urlcourse: $urlcourse, description: $description}';
  }
}
