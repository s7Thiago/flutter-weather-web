import 'package:flutter/material.dart';

import './pages/home_page.dart';
import './utils/routes.dart';

main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.HOME : (_) => HomePage()
      },
    );
  }
}
