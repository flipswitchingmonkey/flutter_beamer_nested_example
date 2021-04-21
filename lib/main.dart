import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'locations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate: BeamerRouterDelegate(
        initialPath: '/',
        locationBuilder: (state) => BeamerLocationBuilder(
          beamLocations: [
            HomeLocation(state),
          ],
        ).call(state),
      ),
    );
  }
}
