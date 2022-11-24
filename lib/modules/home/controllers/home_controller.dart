import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sovo_zadanie/data/todo.dart';
import 'package:sovo_zadanie/modules/home/models/todo_model.dart';

import '../../../util/load.dart';
import '../../auth/models/user.dart';
import '../../main/controllers/main_controller.dart';



class HomeController extends GetxController {
  MainController get mainController => Get.find<MainController>();

  GlobalKey<FormState> todoFormKey = GlobalKey<FormState>();

  final count = 0.obs;
  Rx<AppUser?> user = Rx<AppUser?>(null);
  Rx<TodoData?> todo = Rx<TodoData?>(null);

  String _text = '';
  bool _done = false;
  final todoData = TodoData();


  incrementCounter() {
      count.value--;
  }

  
  void saveTodoText(String text) {
    this._text = text;
  }

  void saveTodoDone(bool done) {
    this._done = done;
  }


  Future<void> removeTodo(String id) async {
    load(Get.context!);
    await todoData.todoRemove(todoId: id);
    Get.back();
    Get.back();
  }

  Future<void> addTodo(GlobalKey<FormState> todoFormKey) async {
    try {
      if (todoFormKey.currentState!.validate()) {
        todoFormKey.currentState!.save();
        load(Get.context!);
        final todoItem = TodoModel(
          id: '${DateTime.now().millisecondsSinceEpoch}',
          text: _text,
          done: _done,
        );
        final todo = await todoData.todoAdd(
          todoModel: todoItem,
        );
        print(todo?.text);
        if (todo == null) {
          Fluttertoast.showToast(msg: 'Please fill your todo activity');
          Get.back();
        } else {
          mainController.todo.value = todo;
          Get.back();
          Get.back();
        }
      }
    } catch (e) {
      print('$e');
    }
  }

  void logout() async {
  }



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
