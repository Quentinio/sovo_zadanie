import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sovo_zadanie/modules/home/models/todo_model.dart';

import '../modules/main/controllers/main_controller.dart';

class TodoData {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _todoRef =
  FirebaseFirestore.instance.collection('todo');
  MainController get mainController => Get.put(MainController());




  Future<TodoModel?> todoAdd(
      {required TodoModel todoModel}) async {
      if (todoModel.text == null) {
        return null;
      } else {
        await _todoRef.doc(mainController.user.value!.uid).collection('todo list').doc(todoModel.id).set(todoModel.toJson());
        return todoModel;
      }
  }

  Future<TodoModel?> todoRemove(
      {required String todoId}) async {
        await _todoRef.doc(mainController.user.value!.uid).collection('todo list').doc(todoId).delete();
      }
  }


