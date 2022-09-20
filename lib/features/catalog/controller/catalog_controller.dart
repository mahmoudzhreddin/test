import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:footsteps/core/utils/shared_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import '../model/catalog_model.dart';

class CatalogController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  RxBool _loadData = false.obs;
  get loadData => _loadData.value;
  set loadData(value) => _loadData.value = value;

  List<CatalogModel>? listCatalog = [];
  // Get All Catalogs From Database
  Future<void> getData() async {
    listCatalog = [];
    loadData = false;
    EasyLoading.show(status: 'loading'.tr());
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('catalog');
    QuerySnapshot querySnapshot = await collectionReference.get();
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    listDocs.forEach((element) {
      listCatalog!
          .add(CatalogModel.fromJson(element.data() as Map<String, dynamic>));
    });
    loadData = true;
    EasyLoading.showSuccess('success'.tr());
  }

  //Exchange The Healte Point of Catalog by The User And Storing The Procssing in Firestore
  buyCatalog({id, salaryPoint}) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    collectionReference
        .doc(SharedStorage.getUserId())
        .collection('myCatalog')
        .add(
      {
        'id': '$id',
        'date': '${Jiffy(DateTime.now()).dateTime}',
      },
    );
    SharedStorage.writeHealthPoint(
        SharedStorage.getHealthPoint() - salaryPoint);
    collectionReference.doc(SharedStorage.getUserId()).update(
        {'allMyHealthPoint': SharedStorage.getHealthPoint() - salaryPoint});
  }
}
