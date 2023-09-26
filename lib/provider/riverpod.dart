import 'package:cursin/controller/theme_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkTheme_rp = StateProvider((ref) => false);
final maxCourses_rp = StateProvider((ref) => 856);
final isFirstBuild_rp = StateProvider((ref) => true);
final contadorFinalizado_rp = StateProvider((ref) => false);
final isButtonVisible_rp = StateProvider((ref) => false);
final buttonEnabled_rp = StateProvider((ref) => false);

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
