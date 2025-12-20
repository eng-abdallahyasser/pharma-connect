import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_connect/app/modules/auth/models/user_model.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // Token management
  Future<void> saveToken(String token) async {
    await _box.write('token', token);
  }

  String? getToken() {
    return _box.read('token');
  }

  Future<void> removeToken() async {
    await _box.remove('token');
  }

  // User management
  Future<void> saveUser(UserModel user) async {
    await _box.write('user', user.toJson());
  }

  UserModel? getUser() {
    final data = _box.read('user');
    if (data != null) {
      return UserModel.fromJson(data);
    }
    return null;
  }

  Future<void> removeUser() async {
    await _box.remove('user');
  }

  // Address management
  Future<void> saveAddresses(List<dynamic> addresses) async {
    await _box.write('addresses', addresses);
  }

  List<dynamic>? getAddresses() {
    return _box.read('addresses');
  }

  // Clear all data
  Future<void> clearAll() async {
    await _box.erase();
  }
}
