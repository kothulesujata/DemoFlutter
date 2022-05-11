import 'package:demoapi/page/add_reading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 16.0 + kToolbarHeight + MediaQuery.of(context).padding.top,
              left: 16.0,
              right: 16.0,
              bottom: 16.0 + kBottomNavigationBarHeight,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddReading(),
                            ),
                          );
                        },
                        child: Card(
                            child: Center(
                              child: Container(
                                  height: 50,
                                  width: 100,
                                  child:
                                      Center(child: Text(' Add new reading'))),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                            child: Center(
                              child: Container(
                                  height: 50,
                                  width: 100,
                                  child: Center(
                                      child: Text('View readings history'))),
                            ),
                            clipBehavior: Clip.antiAlias,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0))),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
