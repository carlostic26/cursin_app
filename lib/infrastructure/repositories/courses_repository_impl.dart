import 'package:cursin/domain/datasources/course_datasource.dart';
import 'package:cursin/domain/repositories/course_repository.dart';
import 'package:cursin/infrastructure/models/curso_model.dart';

/*
  infrastructure/repositories

  NOTE: Se implementa, NO se define
        Esta clase implementa lo definido en model/repositories

        implements = usa interfaz
        extendes = hereda todo
*/

class CoursesRepository implements CourseRepository {
  final CourseDatasource coursesDatasource;
  CoursesRepository({required this.coursesDatasource});

  @override
  Future<List<curso>> getFavoriteCoursesByUser(
      handler, progHandler, ticHandler) {
    try {
      return coursesDatasource.getFavoriteCoursesByUser(
          handler, progHandler, ticHandler);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<curso>> getAllCourses(handler, progHandler, ticHandler) {
    try {
      return coursesDatasource.getAllCourses(handler, progHandler, ticHandler);
    } catch (e) {
      return [];
    }
  }
}
