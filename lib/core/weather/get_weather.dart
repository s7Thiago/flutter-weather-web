import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> getWeather() async {
  // openWeather
  final city = 'brasilia';
  final apiKey = '46ac18ea171148cdefe8a43b88178a3c';
  final openWeatherApi =
      'http://api.openweathermap.org/data/2.5/forecast?q=$city&cnt=20&appid=$apiKey&units=metric&lang=pt_br';

  // Github
  final ghUrl =
      'https://raw.githubusercontent.com/s7Thiago/s7thiago.github.io/master/apis/weather/weather.json';

  http.Response response = await http.get(ghUrl);

  if (response.statusCode == 200) {
    // Ocorreu tudo bem
    return json.decode(response.body);
  } else {
    throw Exception('Falha ao obter dados do servidor');
  }
}
