import 'package:demo4/adapter_bloc.dart';
import 'package:demo4/screen_test.dart';
import 'package:flutter/material.dart';
import 'package:demo4/main.dart';

class TabNavigatorRoutes {
  static const String home = '/';
  static const String sub_home = '/sub_home';

  static const String work = '/';
  static const String sub_work = '/sub_work';

  static const String setting = '/';
  static const String sub_setting = '/sub_setting';
}

enum TypeScreen {
  home,
  sub_home,
  work,
  sub_work,
  setting,
  sub_setting,
}

Map<TypeScreen, String> routePath = {
  TypeScreen.home: TabNavigatorRoutes.home,
  TypeScreen.sub_home: TabNavigatorRoutes.sub_home,
  TypeScreen.work: TabNavigatorRoutes.work,
  TypeScreen.sub_work: TabNavigatorRoutes.sub_work,
  TypeScreen.setting: TabNavigatorRoutes.setting,
  TypeScreen.sub_setting: TabNavigatorRoutes.sub_setting,
};

Map<TabItem, String> routePath1 = {
  TabItem.home: TabNavigatorRoutes.home,
  TabItem.work: TabNavigatorRoutes.work,
  TabItem.setting: TabNavigatorRoutes.setting,
};

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, WidgetBuilder widgetBuilder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widgetBuilder(context),
      ),
    );
  }

  void _pushType(BuildContext context, {TabModel tabModel}) {
    var routeBuilders = _routeBuilders(context)[tabModel.tabItem];

    _push(context, routeBuilders[routePath[tabModel.typeScreen]]);
  }

  Map<TabItem, Map<String, WidgetBuilder>> _routeBuilders(
          BuildContext context) =>
      {
        TabItem.home: _routeBuildersHome(context),
        TabItem.work: _routeBuildersWork(context),
        TabItem.setting: _routeBuildersSetting(context),
      };

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context)[tabItem];
    return Navigator(
      key: navigatorKey,
      initialRoute: routePath1[tabItem],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuildersHome(BuildContext context,
      {TypeScreen type}) {
    return {
      TabNavigatorRoutes.home: (context) => Home(
            onTap: (typeScreen) {
              _pushType(
                context,
                tabModel: TabModel(
                  tabItem: TabItem.home,
                  typeScreen: typeScreen,
                ),
              );
            },
          ),
      TabNavigatorRoutes.sub_home: (context) => SubHome(),
    };
  }

  Map<String, WidgetBuilder> _routeBuildersWork(BuildContext context,
      {TypeScreen type}) {
    return {
      TabNavigatorRoutes.work: (context) => Work(
            onTap: (typeScreen) {
              _pushType(
                context,
                tabModel: TabModel(
                  tabItem: TabItem.work,
                  typeScreen: typeScreen,
                ),
              );
            },
          ),
      TabNavigatorRoutes.sub_work: (context) => SubWork(),
    };
  }

  Map<String, WidgetBuilder> _routeBuildersSetting(BuildContext context,
      {TypeScreen type}) {
    return {
      TabNavigatorRoutes.setting: (context) => Setting(
            onTap: (typeScreen) {
              _pushType(
                context,
                tabModel: TabModel(
                  tabItem: TabItem.setting,
                  typeScreen: typeScreen,
                ),
              );
            },
          ),
      TabNavigatorRoutes.sub_setting: (context) => SubSetting(),
    };
  }
}
