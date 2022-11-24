import 'package:cloud_firestore/cloud_firestore.dart';
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
    String uid = mainController.user.value!.uid;
    name = name.split(' ').first;
    int points = mainController.user.value!.points;
    CollectionReference todos = FirebaseFirestore.instance
        .collection('todo')
        .doc(uid)
        .collection('todo list');

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
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
        child: Form(
          key: homeController.todoFormKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text("Hi $name",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
              RichText(
                text: TextSpan(
                    text: 'You have ',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                          text: points.toString(),
                          style: const TextStyle(
                              color: Color(0xff20f3b4),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text: ' points',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500))
                    ]),
              ),
              SizedBox(height: _deviceHeight * 0.1),
              StreamBuilder(
                  stream: todos.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onLongPress: () {
                                String todo = snapshot.data?.docs[index]['text'];
                                String todoID = snapshot.data?.docs[index]['id'];
                                _editTodoDialog(context, todo, todoID);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Center(
                                    child: Text(
                                  snapshot.data?.docs[index]['text'],
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
                                )),
                              ),
                            ),
                          );
                        });
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _editTodoDialog(BuildContext context, String init, String id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children:  [
                const Text('Create new todo task'),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                       controller.removeTodo(id);
                    },
                    child: Icon(Icons.delete))
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Color(0xff20f3b4),
                    onSaved: (todo) => homeController.saveTodoText(todo!),
                    initialValue: init,
                    decoration: const InputDecoration(
                      hintText: "new todo",
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      homeController.addTodo(homeController.todoFormKey);
                    },
                    child: Container(
                      color: Color(0xff20f3b4),
                      height: 50,
                      width: _deviceWidth * 0.8,
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create new todo task'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Color(0xff20f3b4),
                    onSaved: (todo) {
                      homeController.saveTodoText(todo!);
                    },
                    decoration: const InputDecoration(
                      hintText: "new todo",
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      homeController.addTodo(homeController.todoFormKey);
                      homeController.incrementCounter();
                    },
                    child: Container(
                      color: Color(0xff20f3b4),
                      height: 50,
                      width: _deviceWidth * 0.8,
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
