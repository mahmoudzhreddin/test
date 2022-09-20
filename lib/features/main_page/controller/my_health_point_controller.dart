import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:footsteps/features/main_page/model/my_health_point_model.dart';
import 'package:get/get.dart';

import '../../../core/utils/shared_storage.dart';

class MyHealthPointController extends GetxController {
  List<MyHealthPointModel>? listMyHealthPointCatalog = [];
  RxBool _loadData = false.obs;
  get loadData => _loadData.value;
  set loadData(value) => _loadData.value = value;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getMyHealthPoint() async {
    listMyHealthPointCatalog = [];
    loadData = false;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await collectionReference
        .doc(SharedStorage.getUserId())
        .collection('myHealthPoint')
        .get();
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    listDocs.forEach((element) {
      listMyHealthPointCatalog!.add(
          MyHealthPointModel.fromJson(element.data() as Map<String, dynamic>));
    });
    loadData = true;
  }
}
