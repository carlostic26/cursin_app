import 'package:cursin/domain/localdb/cursos_PROG_db.dart';
import 'package:cursin/domain/localdb/cursos_TIC_db.dart';
import 'package:cursin/domain/localdb/cursos_db.dart';
import 'package:cursin/presentation/screens/screens.dart';
import '../../domain/repositories/course_repository.dart';

// A este provider no le interesa que va a hacer el origen de datos, ni el como.
// Sin importar si mis origenes de datos (bd) sean localStorage o por API,
// El codigo será el mismo porque no es codigo logico-tecnico

class DiscoverProvider extends ChangeNotifier {
  final CourseRepository courseRepository;

  bool initialLoading = true;
  List<curso> courses = [];

  DiscoverProvider({required this.courseRepository});

  //Instancio las 3 bd de este proyecto
  late DatabaseHandlerGen handler;
  late DatabaseProgHandler progHandler;
  late DatabaseTICHandler ticHandler;

  //Obtengo todos los cursos de las 3 bd y los cargo a la lista "courses" de la linea 13
  Future<void> loadCourses() async {
    final newCourses =
        await courseRepository.getAllCourses(handler, progHandler, ticHandler);

    courses.addAll(newCourses);
    initialLoading = false;
    notifyListeners();
  }
}
