import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';
import 'package:scaffold_factory_example/sample/sample_placeholder.dart';

class SampleBottomNavigationBar extends StatefulWidget {
  @override
  _SampleBottomNavigationBarState createState() =>
      new _SampleBottomNavigationBarState();
}

class _SampleBottomNavigationBarState extends State<SampleBottomNavigationBar>
    implements ScaffoldFactoryBehaviors {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  int _currentIndex = 0;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.deepOrange,
    accentColor: Colors.indigoAccent,
  );
  final _bodyChildren = [
    SamplePlaceholder(Colors.lightBlue, "Home Screen"),
    SamplePlaceholder(Colors.orange, "Messages Screen"),
    SamplePlaceholder(Colors.green, "Profile Screen")
  ];

  @override
  void initState() {
    super.initState();
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;

    _scaffoldFactory.bottomNavigationBar = _buildBottomNavigationBar();

    return _scaffoldFactory.build(_bodyChildren[_currentIndex]);
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(
      scaffoldKey: _scaffoldKey,
      materialPalette: _sampleColorPalette,
    );
    _scaffoldFactory.scaffoldFactoryBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: true,
      floatingActionButtonVisibility: false,
      bottomNavigationBarVisibility: true,
      appBar: _scaffoldFactory.buildAppBar(
        titleVisibility: true,
        leadingVisibility: true,
        tabBarVisibility: false,
        titleWidget: const Text('Navigation Bar Configuration'),
        backgroundColor: _scaffoldFactory.colorPalette.primaryColor,
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => this.onBackButtonPressed(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return _scaffoldFactory.buildBottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          title: Text('Messages'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
      currentIndex: _currentIndex,
      color: _scaffoldFactory.colorPalette.accentColor,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  @override
  void onBackButtonPressed() {
    print("Scaffold Factory => onBackButtonPressed()");
    Navigator.of(_scaffoldKey.currentContext).pop();
  }

  @override
  void onFloatingActionButtonPressed() {
    print("Scaffold Factory => onFloatingActionButtonPressed()");
  }

  @override
  Future onEventBusMessageReceived(event) async {
    print("ScaffoldFactory: Event Received");
  }
}
