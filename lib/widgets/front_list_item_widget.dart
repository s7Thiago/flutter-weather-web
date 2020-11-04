import 'package:flutter/material.dart';
import 'package:flutter_weater_web/utils/mock.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import '../core/list_provider.dart';
import '../styles/global.dart';
import '../utils/utils.dart';

class FrontListItemWidget extends StatelessWidget with Utils {
  final Size size;
  final int index;
  final Map data;

  const FrontListItemWidget({
    Key key,
    @required this.size,
    this.index,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context, listen: true);
    final radius = 60;

    return GestureDetector(
      onTap: () {
        listProvider.updateIndex(index);
      },
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(listProvider.currentIndex < index &&
                    index == listProvider.currentIndex + 1
                ? radius
                : 0),
            bottomRight: Radius.circular(listProvider.currentIndex > index &&
                    index == listProvider.currentIndex - 1
                ? radius
                : 0),
          ),
        ),
        color: listProvider.currentIndex == index
            ? GlobalStyles.detailsBackground
            : Colors.white,
        child: Container(
          height: 210,
          padding: const EdgeInsets.symmetric(vertical: 35),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                '${data['date'].split('/')[0]} ${MockData.listItems[int.parse(data['date'].split('/')[1])].substring(0, 3)}',
                style: TextStyle(
                  fontSize: listProvider.currentIndex == index ? 50 : 45,
                  color: listProvider.currentIndex == index
                      ? "white".toColor()
                      : Colors.black12,
                  fontWeight: listProvider.currentIndex == index
                      ? FontWeight.w500
                      : FontWeight.normal,
                ),
              ),
              Text(
                index == 0 ? 'Hoje' : '${data['weekday']}',
                style: TextStyle(
                  fontSize: 25,
                  color: listProvider.currentIndex == index
                      ? "white".toColor()
                      : Colors.black12,
                  fontWeight: listProvider.currentIndex == index
                      ? FontWeight.w300
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
