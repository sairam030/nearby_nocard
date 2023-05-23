import 'package:nearby_nocard/app_exports.dart';

class GetStorageService {
  static final GetStorageService _instance = GetStorageService._internal();

  factory GetStorageService() {
    return _instance;
  }

  GetStorageService._internal();

  final box = GetStorage();

  void put(String key, dynamic value) {
    box.write(key, value);
  }

  dynamic get(String key) {
    return box.read(key);
  }

  List<String> getKeys() {
    return box.getKeys();
  }

  List<dynamic> getValues() {
    return box.getValues();
  }
}
