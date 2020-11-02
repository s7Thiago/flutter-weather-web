import 'package:flutter/widgets.dart';

import './get_weather.dart';

class WeatherProvider extends ChangeNotifier {
  Future<Map> get content async => await getWeather();
}
