import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/bottom_navigation.dart';
import 'package:nested_navigation_demo_flutter/searchpage.dart';
;

class AppRoutes {
  static const String root = '/';
  static const String searchpage = '/searchpage';
}

class RouteState {
  RouteState({this.name: AppRoutes.root});
  String name;
  final navigatorKey = GlobalKey<NavigatorState>();
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> with NavigatorObserver {

  TabItem currentTab = TabItem.bookfeed;
  Map<TabItem, RouteState> routes = {
    TabItem.bookfeed: RouteState(),
    TabItem.barcordreader: RouteState(),
    TabItem.profile: RouteState(),
  };

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  void _push() async {
    print('push ${TabHelper.description(currentTab)}');
    routes[currentTab].name = AppRoutes.searchpage;
    await routes[currentTab].navigatorKey.currentState.pushNamed(AppRoutes.searchpage);
    routes[currentTab].name = AppRoutes.root;
    print('pop ${TabHelper.description(currentTab)}');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        currentTab: currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildBody() {
    return MaterialApp(
      navigatorKey: routes[currentTab].navigatorKey,
      navigatorObservers: [ this ],
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: routes[currentTab].name,
      routes: {
        AppRoutes.root: (context) => SearchPage(
          color: Colors.grey,
          title: TabHelper.description(currentTab),
          onPush: _push,
        ),

      },
    );
  }
}
