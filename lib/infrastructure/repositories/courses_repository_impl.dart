import 'package:cursin/domain/datasources/course_datasource.dart';
import 'package:cursin/domain/repositories/course_repository.dart';
import 'package:cursin/infrastructure/models/curso_model.dart';

/*
  infrastructure/repositories
  NOTE: Esta clase implementa lo definido en model/repositories

*/

class CoursesRepository implements CourseRepository {
  final CourseDatasource course_datasource;

  CoursesRepository({required this.course_datasource});

  @override
  Future<List<curso>> getFavoriteCoursesByUser(
      handler, progHandler, ticHandler) {
    throw UnimplementedError();
  }

  @override
  Future<List<curso>> getAllCourses(handler, progHandler, ticHandler) {
    throw UnimplementedError();
  }
}
