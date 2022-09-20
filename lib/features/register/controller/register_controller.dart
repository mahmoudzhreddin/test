import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:footsteps/core/utils/shared_storage.dart';
import 'package:get/get.dart' hide Trans;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiffy/jiffy.dart';
import '../../../core/utils/navigation.dart';
import '../../main_page/view/main_page.dart';

class RegisterController extends GetxController {
  String? name;
  UserCredential? _userCredential;

  //Register as Anonymous in Firebase Authintication without Email or Phone number
  register(context, name) async {
    EasyLoading.show(status: 'loading'.tr());
    _userCredential = await FirebaseAuth.instance.signInAnonymously();
    if (_userCredential != null) {
      SharedStorage.writeUserId(_userCredential!.user!.uid);
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('users');
      collectionReference.doc(SharedStorage.getUserId()).set({
        'name': '$name',
        'uid': '${SharedStorage.getUserId()}',
        'allMyHealthPoint':0
      });
      collectionReference
          .doc(SharedStorage.getUserId())
          .collection('myHealthPoint')
          .add({
        'countHealthPoint': 0,
        'date': '${Jiffy(DateTime.now()).dateTime}',
      });
      EasyLoading.showSuccess('success'.tr());
      Navigation.pushAndRemoveUntil(context, MainPage());
    }
  }
}
