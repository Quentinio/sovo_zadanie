import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../main/controllers/main_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {



  final HomeController homeController = Get.put(HomeController());
  MainController get mainController => Get.put(MainController());


  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {


    final String title = "SOVO Zadanie";
    String name = mainController.user.value!.name;
    name = name.split(' ').first;
    String points = mainController.user.value!.points.toString();



    _deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    _deviceWidth = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: () {
                  mainController.logout();
                },
                child: const Icon(Icons.logout)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("Hi $name",
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start),
            ),
            RichText(
                text:  TextSpan(
                    text: 'You have ',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500
                    ),
                    children: [
                      TextSpan(
                        text: points,
                        style: const TextStyle(
                          color: Color(0xff20f3b4),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const TextSpan(
                          text: ' points',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          )
                      )
                    ]
                ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: homeController.incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


