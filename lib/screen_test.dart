import 'package:demo4/adapter_bloc.dart';
import 'package:demo4/main.dart';
import 'package:demo4/tab_navigator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final ValueChanged<TypeScreen> onTap;

  const Home({Key key, this.onTap}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TabItem tabItem = TabItem.home;
  final AdapterBloc _bloc = AdapterBloc();
  @override
  void initState() {
    super.initState();
    _bloc.pathItem.listen((value) {
      if (value.tabItem == tabItem) {
        print("Tab model: ${value.typeScreen}");
        widget.onTap(value.typeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hàn Văn Thạo"),
      ),
      body: Center(
        child: GestureDetector(child: Text("Hàn Văn Thạo")),
      ),
    );
  }
}

class SubHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hàn Văn Thạo Fake"),
      ),
      body: Center(
        child: Text("Sub Home"),
      ),
    );
  }
}

class Work extends StatefulWidget {
  final ValueChanged<TypeScreen> onTap;

  const Work({Key key, this.onTap}) : super(key: key);

  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  final AdapterBloc _bloc = AdapterBloc();
  TabItem tabItem = TabItem.work;
  @override
  void initState() {
    super.initState();
    _bloc.pathItem.listen((value) {
      if (value.tabItem == tabItem) {
        print("Tab model: ${value.typeScreen}");
        widget.onTap(value.typeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hàn Gió Đá"),
      ),
      body: Center(
        child: GestureDetector(child: Text("Hàn Gió Đá")),
      ),
    );
  }
}

class SubWork extends StatefulWidget {
  @override
  _SubWorkState createState() => _SubWorkState();
}

class _SubWorkState extends State<SubWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hàn Gió Đá Fake"),
      ),
      body: Center(
        child: TextField(decoration: InputDecoration(
          hintText: "Test show key board"
        ),),
      ),
    );
  }
}

class Setting extends StatefulWidget {
  final ValueChanged<TypeScreen> onTap;

  const Setting({Key key, this.onTap}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TabItem tabItem = TabItem.setting;
  final AdapterBloc _bloc = AdapterBloc();
  @override
  void initState() {
    super.initState();
    _bloc.pathItem.listen((value) {
      if (value.tabItem == tabItem) {
        print("Tab model: ${value.typeScreen}");
        widget.onTap(value.typeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hàn Văn Thạo Toxic"),
      ),
      body: Center(
        child: GestureDetector(onTap: (){
           widget.onTap(TypeScreen.sub_setting);
        },child: Text("Click to me!!!!")),
      ),
    );
  }
}

class SubSetting extends StatefulWidget {
  @override
  _SubSettingState createState() => _SubSettingState();
}

class _SubSettingState extends State<SubSetting> {
  final AdapterBloc _bloc = AdapterBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hàn Văn Thạo Fair Play"),
        ),
        body: Center(
          child:
              Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _bloc.actionNavi.add(
                    TabModel(
                      tabItem: TabItem.work,
                      typeScreen: TypeScreen.sub_work,
                    ),
                  );
                },
                child: Text("Back Sub Work Screen"),
              ),
              RaisedButton(
                onPressed: () {
                  _bloc.actionNavi.add(
                    TabModel(
                      tabItem: TabItem.home,
                      typeScreen: TypeScreen.sub_home,
                    ),
                  );
                },
                child: Text("Back Sub Home Screen"),
              ),
              RaisedButton(
                onPressed: () {
 _bloc.actionNavi.add(
                    TabModel(
                      tabItem: TabItem.setting,
                      typeScreen: TypeScreen.sub_setting,
                    ),
                  );
                },
                child: Text("Next To Sub Setting"),
              ),
            ],
          ),
        ));
  }
}
