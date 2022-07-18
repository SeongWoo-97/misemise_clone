import 'package:flutter/material.dart';
import 'package:misemise_clone/Class/StationOnMapProvider.dart';
import 'package:misemise_clone/Screen/Map/LabMap.dart';
import 'package:misemise_clone/Screen/Map/MiseMiseMap.dart';
import 'package:misemise_clone/Screen/Map/NullSchool.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late PersistentTabController _controller;
  late bool _hideNavBar;
  Color? color = Colors.purpleAccent;
  int selectedIndex = 0;
  List<Widget> _screens = [MiseMiseMap(), LabMap(), NullSchool()];
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          '미세미세 지도',
          style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.grey,
                size: 28,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close,
                color: Colors.grey,
                size: 28,
              )),
        ],
      ),
      body: IndexedStack(index: selectedIndex,children: _screens),
      bottomNavigationBar: Container(
        height: 64,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: InkWell(
                child: Column(
                  children: [
                    selectedIndex == 0
                        ? Divider(
                            color: Color(0xFF00BFA5),
                            indent: 10,
                            endIndent: 10,
                            thickness: 2,
                            height: 2,
                          )
                        : Divider(
                            thickness: 1.5,
                            height: 2,
                            color: Colors.transparent,
                          ),
                    SizedBox(height: 20),
                    Text(
                      '미세미세 먼지',
                      style: TextStyle(
                        color: selectedIndex == 0 ? Color(0xFF00BFA5) : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
              ),
            ),
            Flexible(
              child: InkWell(
                child: Column(
                  children: [
                    selectedIndex == 1
                        ? Divider(
                            color: Color(0xFF00BFA5),
                            indent: 10,
                            endIndent: 10,
                            thickness: 2,
                            height: 2,
                          )
                        : Divider(
                            thickness: 1.5,
                            height: 2,
                            color: Colors.transparent,
                          ),
                    SizedBox(height: 20),
                    Text(
                      '안양대연구소',
                      style: TextStyle(
                        color: selectedIndex == 1 ? Color(0xFF00BFA5) : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
              ),
            ),
            Flexible(
              child: InkWell(
                child: Column(
                  children: [
                    selectedIndex == 2
                        ? Divider(
                            color: Color(0xFF00BFA5),
                            indent: 10,
                            endIndent: 10,
                            thickness: 2,
                            height: 2,
                          )
                        : Divider(
                            thickness: 1.5,
                            height: 2,
                            color: Colors.transparent,
                          ),
                    SizedBox(height: 20),
                    Text(
                      '널스쿨',
                      style: TextStyle(
                        color: selectedIndex == 2 ? Color(0xFF00BFA5) : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
