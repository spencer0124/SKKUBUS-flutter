import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:skkumap/app/ui/bus_data_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:skkumap/app/ui/bus_data_detail_screen.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

class PageNavigator extends StatefulWidget {
  const PageNavigator({Key? key}) : super(key: key);

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    FirebaseAnalytics.instance.logEvent(
      name: 'select_content',
      parameters: <String, dynamic>{
        'content_type': 'screen',
        'item_id': 'screen_$index',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const BusDataScreen(),
      const BusDataScreenDetail(),
      // const BusSettingScreen(),
    ];

    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Set splash color to transparent
          highlightColor:
              Colors.transparent, // Set highlight color to transparent
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(2.6),
                child: Icon(CupertinoIcons.bus),
              ),
              label: '셔틀버스',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(CupertinoIcons.bus),
            //   label: '인자셔틀',
            // ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(2.6),
                child: Icon(CupertinoIcons.info_circle),
              ),
              label: '운행정보',
            ),
          ],
          currentIndex: _selectedIndex,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
