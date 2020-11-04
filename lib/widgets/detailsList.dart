import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import '../core/list_provider.dart';
import '../core/weather/weather_provider.dart';
import '../styles/global.dart';
import '../utils/mock.dart';

class DetailsList extends StatelessWidget {
  final Size size;

  const DetailsList({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context, listen: true);
    final wProvider = Provider.of<WeatherProvider>(context, listen: true);
    final currentIndex = listProvider.currentIndex;
    final currentScroll = listProvider.currentScroll;

    return Material(
      color: GlobalStyles.detailsBackground,
      borderRadius: BorderRadius.only(
        topLeft:
            Radius.circular(currentIndex == 0 || currentScroll > 50 ? 0 : 40),
      ),
      child: FutureBuilder(
        future: wProvider.content,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return currentIndex == 0
                ? _TodayWeatherDetails(
                    data: snapshot.data,
                  )
                : _ForecastDetails(data: snapshot.data, index: currentIndex);
          } else {
            return Center(
              child: Text(
                'Nada recebido',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            );
          }
        },
      ),
    );
  }
}

class _TodayWeatherDetails extends StatelessWidget {
  final data;

  _TodayWeatherDetails({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      color: GlobalStyles.detailsBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data['results']['temp']}',
                          style: TextStyle(fontSize: 150, color: Colors.white),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 35),
                            Text(
                              'ºC',
                              style: TextStyle(
                                  fontSize: 70, color: Colors.deepPurple),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      '${data['results']['description']}',
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              Container(
                height: 150,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Feather.cloud_rain, color: Colors.white),
                        SizedBox(width: 30),
                        Text(
                          '${data['results']['forecast'][0]['min'] * 5.28}% Precipitação',
                          style: GlobalStyles.weatherInfo,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Feather.wind, color: Colors.white),
                        SizedBox(width: 30),
                        Text(
                          '${data['results']['wind_speedy']} Vento',
                          style: GlobalStyles.weatherInfo,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Feather.droplet, color: Colors.white),
                        SizedBox(width: 30),
                        Text(
                          '${data['results']['humidity']}% Umidade',
                          style: GlobalStyles.weatherInfo,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipOval(
                child: Image.network(
                  MockData.weatherImages[data['results']['description']],
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  color: Colors.deepPurple,
                  colorBlendMode: BlendMode.color,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                width: 450,
                child: Text(
                  '${MockData.frases[int.parse(data['results']['wind_speedy'].split(' ')[0])]}',
                  style: TextStyle(
                    color: "#8A57C2".toColor(),
                    fontSize: 25,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class _ForecastDetails extends StatelessWidget {
  final data;
  final int index;

  const _ForecastDetails({
    Key key,
    @required this.data,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      color: GlobalStyles.detailsBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '>${data['results']['forecast'][index]['max']}',
                      style: TextStyle(fontSize: 130, color: Colors.white),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 35),
                        Text(
                          'ºC',
                          style:
                              TextStyle(fontSize: 50, color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    Text(
                      '   <${data['results']['forecast'][index]['min']}',
                      style: TextStyle(fontSize: 130, color: Colors.white),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 35),
                        Text(
                          'ºC',
                          style:
                              TextStyle(fontSize: 50, color: Colors.deepPurple),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Text(
                '  ${data['results']['forecast'][index]['description']}',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipOval(
                child: Image.network(
                  MockData.weatherImages[data['results']['forecast'][index]
                      ['description']],
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  color: Colors.deepPurple,
                  colorBlendMode: BlendMode.color,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                width: 450,
                child: Text(
                  '${MockData.frases[int.parse(data['results']['wind_speedy'].split(' ')[0])]}',
                  style: TextStyle(
                    color: "#8A57C2".toColor(),
                    fontSize: 25,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
