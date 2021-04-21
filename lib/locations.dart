import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class HomeLocation extends BeamLocation {
  HomeLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/*'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    print('*');
    return [
      BeamPage(
        key: ValueKey('home'),
        child: HomePage(beamState: state),
      ),
    ];
  }
}

class SampleLocation extends BeamLocation {
  final String title;
  final String blueprint;

  SampleLocation(BeamState state,
      {required this.title, required this.blueprint})
      : super(state);

  @override
  List<String> get pathBlueprints => [blueprint];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    print(state.uri.path);
    String? id = state.pathParameters.containsKey('id')
        ? state.pathParameters['id']
        : null;
    return [
      BeamPage(
        key: ValueKey(title),
        child: SamplePage(
          title: title,
        ),
      ),
      if (id != null)
        BeamPage(
          key: ValueKey('$title-$id'),
          child: SampleDetailsPage(id: id),
        ),
    ];
  }
}

class SamplePage extends StatelessWidget {
  final String title;
  SamplePage({required this.title}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Center(
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline1,
              ),
              Expanded(child: FittedBox(child: FlutterLogo())),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Beamer.of(context).beamToNamed('/feed/123');
                    },
                    child: Text('FeedDetail'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Beamer.of(context).parent?.beamToNamed('/warnings/456');
                    },
                    child: Text('WarningDetail'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class SampleDetailsPage extends StatelessWidget {
  final String id;
  SampleDetailsPage({required this.id}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Center(
          child: Column(
            children: [
              Text(
                "Aye, here be content $id!",
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ));
  }
}
