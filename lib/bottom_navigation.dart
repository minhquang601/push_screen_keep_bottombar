import 'package:demo4/adapter_bloc.dart';
import 'package:demo4/main.dart';
import 'package:flutter/material.dart';

Map<TabItem, String> _tabName = {
  TabItem.home: "Home",
  TabItem.work: "Work",
  TabItem.setting: "Setting",
};
Map<TabItem, IconData> _tabIcons = {
  TabItem.home: Icons.home,
  TabItem.work: Icons.work,
  TabItem.setting: Icons.settings,
};

class BottomNavigation extends StatelessWidget {
  final AdapterBloc _bloc = AdapterBloc();
  final TabItem currentTab;

  BottomNavigation({
    Key key,
    this.currentTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab.index,
      items: [
        _buildItem(tabItem: TabItem.home),
        _buildItem(tabItem: TabItem.work),
        _buildItem(tabItem: TabItem.setting),
      ],
      onTap: (index) {
        _bloc.actionNavi.add(
          TabModel(
            tabItem: TabItem.values[index],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String _name = _tabName[tabItem];
    IconData _icon = _tabIcons[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(_icon),
      title: Text(_name),
    );
  }
}
