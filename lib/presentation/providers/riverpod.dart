import 'package:cursin/config/theme/theme_preferences.dart';
import 'package:cursin/infrastructure/datasources/local_course_datasource_impl.dart';
import 'package:cursin/infrastructure/repositories/courses_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkTheme_rp = StateProvider((ref) => false);
final maxCourses_rp = StateProvider((ref) => 879);
final isFirstBuild_rp = StateProvider((ref) => true);
final contadorFinalizado_rp = StateProvider((ref) => false);
final isButtonVisible_rp = StateProvider((ref) => false);
final buttonEnabled_rp = StateProvider((ref) => false);

// Define el proveedor para CourseRepository
final courseRepositoryProvider = Provider<CoursesRepositoryImpl>((ref) {
  return CoursesRepositoryImpl(coursesDatasource: LocalCourseDatasource());
});

final themeStateProvider = StateNotifierProvider<ThemeProvider, String>((ref) {
  final themePreference = ThemePreference();
  return ThemeProvider(themePreference.getTheme());
});

class ThemeProvider extends StateNotifier<String> {
  ThemeProvider(String initialTheme) : super(initialTheme);

  void toggleTheme() {
    state = state == 'LIGHT' ? 'DARK' : 'LIGHT';
  }
}
