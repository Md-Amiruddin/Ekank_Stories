import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'models/story.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int _currentIndex=0;
  late RestartableTimer _timer;
  int noOfStoryChildren = 3;

  @override
  void initState() {
    _tabController = TabController(length: noOfStoryChildren, vsync: this, initialIndex: _currentIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
    _timer = RestartableTimer(Duration(seconds: 7), () => {
    _tabController.animateTo((_tabController.index+1) % noOfStoryChildren),
      _timer.reset(),
    });
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Function onLeftRightTapCallback = (position){
      if(position.dx >= 200.0){
        _tabController.animateTo((_tabController.index+1)%noOfStoryChildren);
        _timer.reset();
      }
      else
      {
        _tabController.animateTo((_tabController.index==0)? noOfStoryChildren-1 : _tabController.index-1);
        _timer.reset();
      }
    };

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Timer.periodic(Duration(milliseconds: 7000), (timer) {
    //       _tabController.animateTo((_tabController.index+1) % 3);
    //     });
    // });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: Text('Ekank Story'),
        ),
        body: TabBarView(
          children: [
            Story(bgColor: Colors.teal, url:'http://www.youtube.com',detectLeftRightTap: onLeftRightTapCallback),
            Story(bgColor: Colors.indigo, url:'http://www.gmail.com', detectLeftRightTap: onLeftRightTapCallback,),
            Story(bgColor: Colors.pinkAccent, url:'http://www.google.com', detectLeftRightTap: onLeftRightTapCallback,),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}