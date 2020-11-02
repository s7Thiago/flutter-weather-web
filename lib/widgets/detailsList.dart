import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import '../core/list_provider.dart';
import '../core/weather/weather_provider.dart';
import '../styles/global.dart';

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
            Radius.circular(currentIndex == 0 || currentScroll > 50 ? 0 : 25),
      ),
      child: FutureBuilder(
        future: wProvider.content,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return currentIndex == 0
                ? _TodayWeatherForecastDetails()
                : Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                    ),
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        currentIndex == 0
                            ? snapshot.data['results']['city']
                            : snapshot.data['results']['forecast'][currentIndex]
                                ['description'],
                        style: TextStyle(
                          fontSize: 75,
                          color: "white".toColor(),
                        ),
                      ),
                    ),
                  );
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

class _TodayWeatherForecastDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      color: GlobalStyles.detailsBackground,
      child: Row(
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
                          '15',
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
                      '     12:35, Chuva leve',
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('90% Precipitation', style: GlobalStyles.weatherInfo),
                    Text('17 Km/h Wind', style: GlobalStyles.weatherInfo),
                    Text('30% Humidity', style: GlobalStyles.weatherInfo),
                  ],
                ),
              ),
            ],
          ),
          Column(),
        ],
      ),
    );
  }
}
