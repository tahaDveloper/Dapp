import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrivateKey_model
{
  final TextEditingController privateKeyController =TextEditingController();
  final formKey = GlobalKey<FormState>();


  final secureStorage = FlutterSecureStorage();

// ذخیره‌سازی کلید خصوصی
  Future<void> savePrivateKey(String privateKey) async {
    await secureStorage.write(key: 'private_key', value: privateKey);
  }

// بازیابی کلید خصوصی
  Future<String?> getPrivateKey() async {
    return await secureStorage.read(key: 'private_key');
  }

// حذف کلید خصوصی
  Future<void> deletePrivateKey() async {
    await secureStorage.delete(key: 'private_key');
  }

}