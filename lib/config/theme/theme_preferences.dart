import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const THEME_MODE = "MODE";
  SharedPreferences?
      _prefs; // Variable de instancia para almacenar las preferencias compartidas

  Future<void> initialize() async {
    _prefs = await SharedPreferences
        .getInstance(); // Obtener las preferencias compartidas una vez
  }

  Future<void> setTheme(String theme) async {
    _prefs!.setString(THEME_MODE, theme); // Guardar el tema inmediatamente
  }

  String getTheme() {
    if (_prefs == null || !_prefs!.containsKey(THEME_MODE)) {
      setTheme('LIGHT');
      return 'LIGHT';
    }
    return _prefs!.getString(THEME_MODE)!;
  }
}
