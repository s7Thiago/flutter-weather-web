import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import '../styles/global.dart';
import '../utils/mock.dart';
import '../core/list_provider.dart';

class DetailsList extends StatelessWidget {
  final Size size;

  const DetailsList({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context, listen: true);
    final currentIndex = listProvider.currentIndex;
    final currentScroll = listProvider.currentScroll;

    return Material(
      color: GlobalStyles.detailsBackground,
      borderRadius: BorderRadius.only(
        topLeft:
            Radius.circular(currentIndex == 0 || currentScroll > 50 ? 0 : 25),
      ),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
        height: double.infinity,
        alignment: Alignment.center,
        child: Center(
          child: Text(
            MockData.itemDetails[listProvider.currentIndex],
            style: TextStyle(
              fontSize: 75,
              color: "white".toColor(),
            ),
          ),
        ),
      ),
    );
  }
}
