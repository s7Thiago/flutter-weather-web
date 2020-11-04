import 'package:flutter/material.dart';

import '../styles/global.dart';
import '../utils/mock.dart';
import '../core/weather/get_weather.dart';

class AppTopBar extends StatelessWidget {
  final Size size;

  const AppTopBar({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: size.height * .15,
        child: FutureBuilder(
          future: getWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    height: double.infinity,
                    alignment: Alignment.topCenter,
                    // color: Colors.green,
                    child: Image.network(
                        'https://conceptdraw.com/a2241c3/p20/preview/640/pict--window-buttons-mac-os-x-buttons-and-segmented-controls-vector-stencils-library'),
                    margin: const EdgeInsets.only(left: 0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data['results']['city']}',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                          '${MockData.listItems[int.parse(snapshot.data['results']['date'].split('/')[1])].substring(0, 3)}, ${snapshot.data['results']['forecast'][0]['weekday']}'),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * .15,
                    height: double.infinity,
                    child: Material(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              MockData.profileImageUrl,
                            ),
                          ),
                        ),
                        title: Text('Thiago Silva'),
                        subtitle: Text('Basic Level'),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'Aguardando dados...',
                  style: TextStyle(fontSize: 50),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
