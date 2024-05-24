import 'package:cursin/infrastructure/models/curso_model.dart';

/* 
  Domain/repositories
  NOTE: Aqui se define el dataSource PERO no se implementa por eso es abstract

  */

abstract class CourseDatasource {
  Future<List<curso>> getFavoriteCoursesByUser(
      dynamic handler, dynamic progHandler, dynamic ticHandler);

  Future<List<curso>> getAllCourses(
      dynamic handler, dynamic progHandler, dynamic ticHandler);
}
