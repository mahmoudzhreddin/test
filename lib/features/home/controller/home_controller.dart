import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:footsteps/core/utils/shared_storage.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pedometer/pedometer.dart';

class HomeController extends GetxController {
  StreamSubscription<int>? _subscription;

  RxInt _todaySteps = 0.obs;
  get todaySteps => _todaySteps.value;
  set todaySteps(value) => _todaySteps.value = value;

  RxInt _healthPoint = 0.obs;
  get healthPoint => _healthPoint.value;
  set healthPoint(value) => _healthPoint.value = value;

  CollectionReference? collectionReference;
  @override
  void onInit() {
    super.onInit();
    healthPoint =
        SharedStorage.hasHealthPoint() ? SharedStorage.getHealthPoint() : 0;
    startListening();
  }
  //Function To Start Listener For The Footsteps The User
  void startListening() {
    var _subscription = Pedometer.stepCountStream.listen(
      (event) => getTodaySteps(event.steps),
      onError: _onError,
      onDone: _onDone,
      cancelOnError: true,
    );
  }

  void stopListening() {
    _subscription!.cancel();
  }

  void _onDone() => print("Finished pedometer tracking");
  void _onError(error) => print("Flutter Pedometer Error: $error");

  int? tempHealthPoint = 0;
  //Account Count Of The Footsteps And Storing Of The Health Point In FireStore With The Date Of Now
  Future<int> getTodaySteps(int value) async {
    int? savedStepsCountKey = 999999;
    int? savedStepsCount =
        SharedStorage.box.hasData(savedStepsCountKey.toString())
            ? SharedStorage.box.read(savedStepsCountKey.toString())
            : 0;

    int todayDayNo = Jiffy(DateTime.now()).date;
    if (value < savedStepsCount!) {
      savedStepsCount = 0;
      SharedStorage.box.write(savedStepsCountKey.toString(), savedStepsCount);
    }

    int? lastDaySavedKey = 888888;
    int? lastDaySaved = SharedStorage.box.hasData(lastDaySavedKey.toString())
        ? SharedStorage.box.read(lastDaySavedKey.toString())
        : 0;
    if (lastDaySaved! < todayDayNo) {
      lastDaySaved = todayDayNo;
      savedStepsCount = value;
      SharedStorage.box.write(lastDaySavedKey.toString(), lastDaySaved);
      SharedStorage.box.write(savedStepsCountKey.toString(), savedStepsCount);
    }

    todaySteps = value - savedStepsCount;
    tempHealthPoint = (todaySteps / 100).toInt();
      if (SharedStorage.getHealthPoint() < tempHealthPoint!) {
        healthPoint = tempHealthPoint!;
        SharedStorage.writeHealthPoint(healthPoint);
        collectionReference = FirebaseFirestore.instance.collection('users');
        collectionReference!
            .doc(SharedStorage.getUserId())
            .collection('myHealthPoint')
            .add({
          'countHealthPoint': healthPoint,
          'date': '${Jiffy(DateTime.now()).dateTime}'
        });
        // update({
        //   'myHealthPoint': healthPoint,
        //   "data":""
        // });
      }
    SharedStorage.box.write(todayDayNo.toString(), todaySteps);
    return todaySteps!;
  }
}
