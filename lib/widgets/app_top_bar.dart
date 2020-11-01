import 'package:flutter/material.dart';

import '../utils/mock.dart';
import '../styles/global.dart';

class AppTopBar extends StatelessWidget {
  final Size size;

  const AppTopBar({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: size.height * .15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 100,
              color: GlobalStyles.detailsBackground,
              margin: const EdgeInsets.only(left: 16),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Los Angeles',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text('Feb, Tuesday'),
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
                child: ListTile(
                  leading: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        MockData.profileImageUrl,
                      ),
                    ),
                  ),
                  title: Text('Diego Sousa'),
                  subtitle: Text('Basic Level'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
