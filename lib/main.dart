import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{


  var lastPosition = 0.0;
  var random = new Random();

  AnimationController animationController;

  double getRandomNumber(){
    var lastPosition = random.nextDouble();
    return lastPosition;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    spinTheBottle();
  }
  spinTheBottle(){
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 1)
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset("assets/floor.jpg",
              fit: BoxFit.fill,),
          ),
          Center(
            child: Container(
              child: RotationTransition(
                turns: Tween(begin: lastPosition,end: getRandomNumber()).animate(
                  new CurvedAnimation(parent: animationController, curve: Curves.linear)
                ),
                child: GestureDetector(
                  onTap: (){
                    if(animationController.isCompleted){
                      setState(() {
                        spinTheBottle();
                      });
                    }
                  },
                  child: Image.asset("assets/bottle.png",
                  width: 250,height: 250,),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}