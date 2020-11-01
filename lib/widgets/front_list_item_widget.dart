import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import '../styles/global.dart';
import '../core/list_provider.dart';
import '../utils/mock.dart';

class FrontListItemWidget extends StatelessWidget {
  final Size size;
  final int index;

  const FrontListItemWidget({
    Key key,
    @required this.size,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context, listen: true);
    final radius = size.height * .07;

    return GestureDetector(
      onTap: () {
        listProvider.updateIndex(index);
        print('INDEX: $index');
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
          child: Text(
            MockData.listItems[index],
            style: TextStyle(
              fontSize: 65,
              color: listProvider.currentIndex == index
                  ? "white".toColor()
                  : Colors.black12,
            ),
          ),
        ),
      ),
    );
  }
}
