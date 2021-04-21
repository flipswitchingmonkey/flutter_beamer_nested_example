import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class HomeLocation extends BeamLocation {
  HomeLocation(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/*'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('home-${state.uri}'),
        child: HomePage(beamState: state),
      ),
    ];
  }
}

class FeedLocation extends BeamLocation {
  FeedLocation(
    BeamState state,
  ) : super(state);

  @override
  List<String> get pathBlueprints => ['/feed/:id'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    String? id = state.pathParameters.containsKey('id')
        ? state.pathParameters['id']
        : null;
    return [
      BeamPage(
        key: ValueKey('feed'),
        child: SamplePage(
          title: 'Feed',
        ),
      ),
      if (id != null)
        BeamPage(
          key: ValueKey('feed-$id'),
          child: SampleDetailsPage(id: id),
        ),
    ];
  }
}

class WarningsLocation extends BeamLocation {
  WarningsLocation(
    BeamState state,
  ) : super(state);

  @override
  List<String> get pathBlueprints => ['/warnings/:id'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    String? id = state.pathParameters.containsKey('id')
        ? state.pathParameters['id']
        : null;
    return [
      BeamPage(
        key: ValueKey('warnings'),
        child: SamplePage(
          title: 'Warnings',
        ),
      ),
      if (id != null)
        BeamPage(
          key: ValueKey('warnings-$id'),
          child: SampleDetailsPage(id: id),
        ),
    ];
  }
}

class SearchLocation extends BeamLocation {
  SearchLocation(
    BeamState state,
  ) : super(state);

  @override
  List<String> get pathBlueprints => ['/search'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('search'),
        child: SamplePage(
          title: 'Search',
        ),
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
                  // use beamTo/Named through the parent to navigate to _another_ nested router,
                  // via the parent's context's router
                  // this will reset the remaining router's state
                  ElevatedButton(
                    onPressed: () {
                      Beamer.of(context).parent?.beamToNamed('/feed/123');
                    },
                    child: Text('FeedDetail (via Parent)'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Beamer.of(context).parent?.beamToNamed('/warnings/456');
                    },
                    child: Text('WarningDetail (via Parent)'),
                  ),
                  // use beamTo/Named through the context to navigate to _within_ the nested router,
                  // this will not jump to the other pages BUT it keeps the state between swipes!
                  ElevatedButton(
                    onPressed: () {
                      Beamer.of(context).beamToNamed('/feed/123');
                    },
                    child: Text('FeedDetail (via Context)'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Beamer.of(context).beamToNamed('/warnings/456');
                    },
                    child: Text('WarningDetail (via Context)'),
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
        appBar: AppBar(),
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
