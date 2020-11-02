import 'package:flutter/material.dart';
import 'package:flutter_weater_web/core/weather/get_weather.dart';
import 'package:provider/provider.dart';

import '../core/list_provider.dart';
import '../styles/global.dart';
import '../widgets/front_list_item_widget.dart';

class FrontList extends StatelessWidget {
  final Size size;

  const FrontList({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context, listen: true);

    return Container(
      color: GlobalStyles.detailsBackground,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          listProvider.updateScroll(scrollInfo.metrics.pixels);

          return true;
        },
        child: FutureBuilder(
          future: getWeather(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
            // print('DADOS: \t\t${snapshot.data['list'].length}');

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['results']['forecast'].length,
                  itemBuilder: (ctx, index) {
                    return FrontListItemWidget(
                      size: size,
                      index: index,
                      data: snapshot.data['results']['forecast'][index],
                    );
                  });
            } else {
              return Material(
                child: Center(
                  child: Text('Nenhuma informação recebida'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
