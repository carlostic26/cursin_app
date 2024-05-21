import 'package:cursin/infrastructure/models/curso_model.dart';

abstract class CourseDatasource {
  Future<List<curso>> getFavoriteCoursesByUser(
      dynamic handler, dynamic progHandler, dynamic ticHandler);

  Future<List<curso>> getAllCourses(
      dynamic handler, dynamic progHandler, dynamic ticHandler);
}
