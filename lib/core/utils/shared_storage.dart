import 'package:get_storage/get_storage.dart';

class SharedStorage {
  static String storageName = 'footsteps_container';
  static GetStorage box = GetStorage(storageName);
  static String usetId = 'userId';
  static String healthPoint = 'healthPoint';
  static String languageKey = 'language';

  static init() async {
    await GetStorage.init(storageName);
  }

  static getLanguage() {
    return box.read(languageKey);
  }

  static writeLanguage(value) {
    box.write(languageKey, value);
  }

  static hasUserId() {
    if (box.hasData(usetId)) {
      return true;
    } else {
      return false;
    }
  }

  static writeUserId(id) {
    box.write(usetId, id);
  }

  static getUserId() {
    return box.read(usetId);
  }

  static hasHealthPoint() {
    if (box.hasData(healthPoint)) {
      return true;
    } else {
      return false;
    }
  }

  static writeHealthPoint(countHealthPoint) {
    box.write(healthPoint, countHealthPoint);
  }

  static getHealthPoint() {
    return box.read(healthPoint) ?? 0;
  }
}
