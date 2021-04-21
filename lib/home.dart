import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beamer_example/locations.dart';

class HomePage extends StatefulWidget {
  final BeamState beamState;

  HomePage({Key? key, required this.beamState}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomBarConfig> _bottomBarConfigs = [
    BottomBarConfig(
      matcher: 'feed',
      location: (state) =>
          SampleLocation(state, title: 'Feed', blueprint: '/feed/:id'),
      label: 'Feed',
      icon: Icons.article,
    ),
    BottomBarConfig(
      matcher: 'warnings',
      location: (state) =>
          SampleLocation(state, title: 'Warnings', blueprint: '/warnings/:id'),
      label: 'Warnings',
      icon: Icons.new_releases,
    ),
    BottomBarConfig(
      matcher: 'search',
      location: (state) =>
          SampleLocation(state, title: 'Search', blueprint: '/search/:id'),
      label: 'Search',
      icon: Icons.search,
    ),
    BottomBarConfig(
      matcher: 'settings',
      location: (state) =>
          SampleLocation(state, title: 'Settings', blueprint: '/settings/:id'),
      label: 'Settings',
      icon: Icons.settings,
    ),
  ];

  PageController _pageController = PageController(initialPage: 0);
  int _currentBottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    print('init');
    for (var index = 0; index < _bottomBarConfigs.length; index++) {
      if (widget.beamState.uri.path
          .contains(_bottomBarConfigs[index].matcher)) {
        _currentBottomNavIndex = index;
        _pageController = PageController(initialPage: _currentBottomNavIndex);
        break;
      }
    }
  }

  void _onPageChange(int index) {
    print('_onPageChange');
    print(widget.beamState.uri);
    setState(() => _currentBottomNavIndex = index);
    _bottomBarConfigs[_currentBottomNavIndex].updateRoute();
  }

  void _onBottomNavChange(int index) {
    print('_onBottomNavChange');
    _onPageChange(index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChange,
        children: _bottomBarConfigs
            .map((config) => Beamer(routerDelegate: config.delegate))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentBottomNavIndex,
        items: _bottomBarConfigs.map((config) => config.navItem).toList(),
        onTap: _onBottomNavChange,
      ),
    );
  }
}

class BottomBarConfig {
  late BeamerRouterDelegate<BeamState> delegate;
  late BottomNavigationBarItem navItem;
  final LocationBuilder location;
  final String matcher;
  final String label;
  final IconData icon;

  BottomBarConfig(
      {required this.matcher,
      required this.location,
      required this.label,
      required this.icon}) {
    this.delegate = BeamerRouterDelegate(locationBuilder: this.location);
    this.navItem =
        BottomNavigationBarItem(label: this.label, icon: Icon(this.icon));
  }

  void updateRoute() {
    this.delegate.parent?.updateRouteInformation(
          this.delegate.currentLocation.state.uri,
        );
  }
}
