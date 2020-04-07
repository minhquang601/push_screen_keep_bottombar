import 'dart:async';

import 'package:demo4/main.dart';
import 'package:demo4/tab_navigator.dart';

class TabModel {
   final TabItem tabItem;
   final TypeScreen typeScreen;

  TabModel({this.tabItem, this.typeScreen});

}

class AdapterBloc {
  AdapterBloc._();

  static final AdapterBloc instance = AdapterBloc._();

  factory AdapterBloc() => instance;

  StreamController<TabModel> _actionController = StreamController<TabModel>();
  StreamSink<TabModel> get actionNavi => _actionController.sink;

  StreamController<TabItem> _tabItemController = StreamController<TabItem>.broadcast();
  StreamSink<TabItem> get _tabItemSink => _tabItemController.sink;
  Stream<TabItem> get getTabItem => _tabItemController.stream;

  StreamController<TabModel> _pathController = StreamController<TabModel>.broadcast();
  StreamSink<TabModel> get _pathSink => _pathController.sink;
  Stream<TabModel> get pathItem => _pathController.stream;

  void registerListener() {
    _actionController.stream.listen(_handleNavigator);
  }

  void _handleNavigator(TabModel tabModel) {
    _tabItemSink.add(tabModel.tabItem);
    if (tabModel.typeScreen != null) _pathSink.add(tabModel);
  }
  
  void dispose() {
    _actionController.close();
    _tabItemController.close();
    _pathController.close();
  }
}
