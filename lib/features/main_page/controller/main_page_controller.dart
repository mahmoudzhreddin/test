import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../core/utils/shared_storage.dart';

class MainPageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  CollectionReference? collectionReference;
  sendPoitnToFireStroe() {
    collectionReference = FirebaseFirestore.instance.collection('users');
    collectionReference!
        .doc(SharedStorage.getUserId())
        .collection('myHealthPoint')
        .add({
      'countHealthPoint': SharedStorage.getHealthPoint(),
      'date': '${Jiffy(DateTime.now()).dateTime}'
    });
  }
}
