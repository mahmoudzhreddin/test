import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:footsteps/core/utils/shared_storage.dart';
import 'package:footsteps/features/main_page/model/my_catalog_model.dart';
import 'package:get/get.dart' hide Trans;
import '../../catalog/model/catalog_model.dart';

class MyCatalogController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllCatalog();
    getMyCatalog();
  }

  RxBool _loadData = false.obs;
  get loadData => _loadData.value;
  set loadData(value) => _loadData.value = value;

  //Get All Catalogs From Database
  List<CatalogModel>? listAllCatalog = [];
  Future<void> getAllCatalog() async {
    listAllCatalog = [];
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('catalog');
    QuerySnapshot querySnapshot = await collectionReference.get();
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    listDocs.forEach((element) {
      listAllCatalog!
          .add(CatalogModel.fromJson(element.data() as Map<String, dynamic>));
    });
  }

  //Get The Catalogs Redeemed For Health Points By The User 
  List<MyCatalogModel>? listMyCatalogFireBase = [];
  List<MyCatalogModel>? listMyCatalog = [];
  Future<void> getMyCatalog() async {
    listAllCatalog = [];
    listMyCatalogFireBase = [];
    loadData = false;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await collectionReference
        .doc(SharedStorage.getUserId())
        .collection('myCatalog')
        .get();
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    listDocs.forEach((element) {
      listMyCatalogFireBase!
          .add(MyCatalogModel.fromJson(element.data() as Map<String, dynamic>));
    });
    loadData = true;
  }

  // Merging The Two Founctions Privous To Get Finllay Resulte
  mergeList() {
    listMyCatalog = [];
    for (var x in listMyCatalogFireBase!) {
      for (var y in listAllCatalog!)
        if (int.parse(x.id!) == y.id) {
          listMyCatalog!.add(
            MyCatalogModel(
                id: x.id,
                date: x.date,
                name: y.name,
                salaryPoint: y.salaryPoint,
                salarySAR: y.salarySAR),
          );
        }
    }
  }

  //Function To Refresh The Page
  Future<void> refreshPage() async {
    getAllCatalog();
    getMyCatalog();
  }
}
