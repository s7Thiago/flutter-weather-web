import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/mock.dart';
import '../styles/global.dart';
import '../core/list_provider.dart';
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
        child: ListView.builder(
          itemCount: MockData.listItems.length,
          itemBuilder: (ctx, index) {
            return FrontListItemWidget(
              size: size,
              index: index,
            );
          },
        ),
      ),
    );
  }
}
