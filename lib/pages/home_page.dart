import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/frontList.dart';
import '../widgets/detailsList.dart';
import '../widgets/app_top_bar.dart';
import '../core/list_provider.dart';
import '../core/weather/weather_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTopBar(size: size),
          Container(
            height: size.height * .85,
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => ListProvider()),
                ChangeNotifierProvider(create: (_) => WeatherProvider()),
              ],
              child: Row(
                children: [
                  Expanded(flex: 1, child: FrontList(size: size)),
                  Expanded(flex: 3, child: DetailsList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
