import 'package:cursin/domain/datasources/course_datasource.dart';
import 'package:cursin/infrastructure/models/curso_model.dart';

/* 
  infrastructre/datasources

  NOTE: Se implementa, NO se define
        Esta clase de infraestructure implementa lo definido en el datasource de domain.        
        Aqui se hace la magia. Es posible cambiar las implementaciones mas adelante, por si mudamos a API, web, etc, por ahora: SQFlite

  En primera instancia necesitamos obtener los cursos favoritos locales del usuario
  Para ello, necesitamos solicitar el "HANDLER" de las 3 bd diferentes
  Luego combinamos esos 3 resultados en una sola lista a retornar

*/

class LocalCourseDatasource implements CourseDatasource {
  @override
  Future<List<curso>> getFavoriteCoursesByUser(
      dynamic handler, dynamic progHandler, dynamic ticHandler) async {
    List<curso> cursosHandler = await handler.misFavoritos();
    List<curso> cursosProgHandler = await progHandler.misFavoritos();
    List<curso> cursosTicHandler = await ticHandler.misFavoritos();

    // Combina los resultados en una sola lista
    List<curso> favoriteCourses = [
      ...cursosHandler,
      ...cursosProgHandler,
      ...cursosTicHandler,
    ];

    return favoriteCourses;
  }

  @override
  Future<List<curso>> getAllCourses(handler, progHandler, ticHandler) async {
    List<curso> coursesGen = await handler.course();
    List<curso> coursesProg = await progHandler.course();
    List<curso> coursesTic = await ticHandler.course();

    // Combina los resultados en una sola lista
    List<curso> courses = [
      ...coursesGen,
      ...coursesProg,
      ...coursesTic,
    ];

    return courses;
  }
}
