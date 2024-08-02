import 'package:flutter/material.dart';

import '../config.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /* ========= Attendance Route ============= */

      /* ========= No Route view ============= */
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(body: Center(child: Text('No route defined')));
        });
    }
  }
}
