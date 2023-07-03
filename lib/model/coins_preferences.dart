import 'package:shared_preferences/shared_preferences.dart';

class CoinsPreference {
  int coinsOperate = 0;
  int sumCoins = 0;

  Future<int> getCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('coins') ?? 12;
  }

  setCoins(int coinsShp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Obtener el valor actual del contador
    int currentCoins = await getCoins();

    // Sumar el valor actual del contador con el nuevo valor
    int newCoins = currentCoins + coinsShp;

    // Guardar el nuevo valor del contador en SharedPreferences
    prefs.setInt('coins', newCoins);
  }
}
