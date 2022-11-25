import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sovo_zadanie/data/todo.dart';
import 'package:sovo_zadanie/modules/home/models/todo_model.dart';
import 'package:sovo_zadanie/services/ad_mob_service.dart';

import '../../../data/auth.dart';
import '../../../util/load.dart';
import '../../auth/models/user.dart';
import '../../main/controllers/main_controller.dart';



class HomeController extends GetxController {
  MainController get mainController => Get.find<MainController>();



  Rx<AppUser?> user = Rx<AppUser?>(null);
  Rx<TodoData?> todo = Rx<TodoData?>(null);

  RewardedAd? _rewardedAd;
  int _rewardScore = 0;

  final todoData = TodoData();
  final authData = AuthData();

  String _todoText = '';
  bool _todoDone = false;
  int _points = 0;







  String? todoTextValidator(String todoText) {
    if (todoText.isNotEmpty) {
      return null;
    } else {
      return 'Your todo should not be empty';
    }
  }

  void saveTodoText(String todoText) {
    _todoText = todoText;
  }

  void saveTodoDone(bool todoDone) {
    _todoDone = todoDone;
  }


  Future<void> removeTodo(String id, int points) async {
    String uid = mainController.user.value!.uid;
    load(Get.context!);
    points++;
    await todoData.todoRemove(todoId: id);
    authData.editPoints(points: points, uid: uid);
    Get.back();
    Get.back();
  }

  Future<void> addTodo(GlobalKey<FormState> todoFormKey, int points) async {
    try {
      if (todoFormKey.currentState!.validate()) {
        todoFormKey.currentState!.save();
        load(Get.context!);
        points--;
        final todoItem = TodoModel(
          id: '${DateTime.now().millisecondsSinceEpoch}',
          text: _todoText,
          done: _todoDone,
        );
        authData.editPoints(points: points, uid: mainController.user.value!.uid);
        final todo = await todoData.todoAdd(
          todoModel: todoItem,
        );
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

  Future<void> editTodo(GlobalKey<FormState> todoFormKey, String id) async {
    try {
      if (todoFormKey.currentState!.validate()) {
        todoFormKey.currentState!.save();
        load(Get.context!);
        final todoItem = TodoModel(
          id: id,
          text: _todoText,
          done: _todoDone,
        );
        final todo = await todoData.todoAdd(
          todoModel: todoItem,
        );
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



  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: AdMobService.rewardedAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              _rewardedAd = ad;
              update();
            },
            onAdFailedToLoad: (error) {
              _rewardedAd = null;
            }
        )
    );
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
          print('Ad showed');
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          loadRewardedAd();
        }
      );
      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
            _points = reward.amount.toInt() - 7;
            authData.editPoints(points: _points, uid: mainController.user.value!.uid);
          }
      );
    }
    _rewardedAd = null;
  }


  void logout() async {
  }

  void disposeAds() {
    _rewardedAd?.dispose();
  }


  @override
  void onInit() {
    loadRewardedAd();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
