import 'package:demo4/adapter_bloc.dart';
import 'package:demo4/bottom_navigation.dart';
import 'package:demo4/tab_navigator.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

enum TabItem { home, work, setting }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TabItem _currentTab = TabItem.home;
  final navigatorKey = GlobalKey<NavigatorState>();
AdapterBloc _bloc = AdapterBloc()..registerListener();

  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.work: GlobalKey<NavigatorState>(),
    TabItem.setting: GlobalKey<NavigatorState>(),
  };
   void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } 
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != TabItem.home) {
            _selectTab(TabItem.home);
            return false;
          }
        }

        return isFirstRouteInCurrentTab;
      },
      child: StreamBuilder<TabItem>(
        initialData: TabItem.home,
        stream: _bloc.getTabItem,
        builder: (context, snapshot) {
          _currentTab = snapshot.data;
          return Scaffold(
            body: Stack(
              children: <Widget>[
                _buildOffstageNavigator(TabItem.home),
                _buildOffstageNavigator(TabItem.work),
                _buildOffstageNavigator(TabItem.setting),
              ],
            ),
            bottomNavigationBar: BottomNavigation(
              currentTab: _currentTab,
            ),
          );
        }
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
