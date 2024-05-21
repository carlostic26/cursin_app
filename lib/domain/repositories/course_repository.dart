import 'package:cursin/infrastructure/models/curso_model.dart';

/* 
  Domain/repositories
  NOTE: Aqui se define el repositorio PERO no se implementa por eso es abstract
  
  Para este caso, se trata de getAllCourses a extraccion de los cursos de las 3 bd
  puede no ser dynamic, mientras busco que tipo de dato es handler

 */

abstract class CourseRepository {
  Future<List<curso>> getFavoriteCoursesByUser(
      dynamic handler, dynamic progHandler, dynamic ticHandler);

  Future<List<curso>> getAllCourses(
      dynamic handler, dynamic progHandler, dynamic ticHandler);
}
