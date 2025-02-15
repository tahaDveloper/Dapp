import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widget/custumeText/widget_Text.dart';
import '../../model/privateKey/PrivatKeyModel.dart';
import '../walletScreen/WalletScreenViwe.dart';

class PrivateKeyViwe extends StatefulWidget {
  @override
  _PrivateKeyInputPageState createState() => _PrivateKeyInputPageState();
}

class _PrivateKeyInputPageState extends State<PrivateKeyViwe> {
  final privateKeyModel = PrivateKey_model();
  String? storedPrivateKey; // برای ذخیره کلید خصوصی بازیابی شده
  String? publicKey; // کلید عمومی محاسبه‌شده
  bool isFirstTime = true; // بررسی اینکه آیا اولین بار است یا خیر

  @override
  void initState() {
    super.initState();
    _loadPrivateKey();
  }

  // بارگذاری کلید خصوصی از SharedPreferences
  Future<void> _loadPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    if (privateKey == null) {
      return;
    }
    setState(() {
      storedPrivateKey = privateKey;
      publicKey = calculatePublicKey(privateKey); // محاسبه کلید عمومی
      isFirstTime = false; // بار دوم به بعد
    });
  }

  // ذخیره کلید خصوصی در SharedPreferences
  Future<void> _savePrivateKey(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', privateKey);
  }

  // محاسبه کلید عمومی (نمونه‌سازی)
  String calculatePublicKey(String privateKey) {
    // محاسبه واقعی کلید عمومی باید اینجا انجام شود.
    return "$privateKey";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E0F1F),
      body: _getBody(),
    );
  }

// تعیین محتوای صفحه اصلی بر اساس وضعیت کلید خصوصی و اولین بار بودن ورود
  Widget _getBody() {
    if (storedPrivateKey == null) {
      return buildPrivateKeyInputForm(); // فرم ورود کلید خصوصی
    }
    return isFirstTime ? buildPrivateKeyInputForm() : _buildPublicKeyView(); // فرم ورود کلید خصوصی یا نمایش کلید عمومی
  }

// ویجت نمایش کلید عمومی
  Widget _buildPublicKeyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle("Your Private Key?"),
          const SizedBox(height: 20),
          _buildSubtitle(publicKey ?? "Loading..."),
          const SizedBox(height: 50),
          _buildGoToWalletButton(),
          const SizedBox(height: 20),
          _buildDeletePrivateKeyButton(),
        ],
      ),
    );
  }

// متد ساخت عنوان
  Widget _buildTitle(String text) {
    return Custume_Text(
      text: text,
      color: const Color(0xffE2E2B6),
      Size: 24,
      fontWeight: FontWeight.w600,
    );
  }

// متد ساخت زیرعنوان
  Widget _buildSubtitle(String text) {
    return Custume_Text(
      text: text,
      color: Colors.white,
      Size: 20,
      fontWeight: FontWeight.normal,
    );
  }

// دکمه "Go to Wallet"
  Widget _buildGoToWalletButton() {
    return ElevatedButton(
      style: _buildButtonStyle(
        backgroundColor: const Color(0xff6EACDA),
        shadowColor: Color(0xffE2E2B6),
      ),
      onPressed: () => Get.to(() => WalletScreenView(privateKey: storedPrivateKey!)),
      child: _buildButtonText("Go to Wallet"),
    );
  }

// دکمه "Delete Private Key and Set Again"
  Widget _buildDeletePrivateKeyButton() {
    return ElevatedButton(
      style: _buildButtonStyle(
        backgroundColor: const Color(0xffE2E2B6),
        shadowColor: Colors.lightBlueAccent,
      ),
      onPressed: _deletePrivateKey,
      child: _buildButtonText("Delete Private Key and Set Again"),
    );
  }

// استایل دکمه‌ها
  ButtonStyle _buildButtonStyle({required Color backgroundColor, required Color shadowColor}) {
    return ElevatedButton.styleFrom(
      shadowColor: shadowColor,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      elevation: 9,
    );
  }

// متن دکمه‌ها
  Widget _buildButtonText(String text) {
    return Custume_Text(
      text: text,
      color: const Color(0xff03346E),
      Size: 18,
      fontWeight: FontWeight.bold,
    );
  }

// متد حذف کلید خصوصی
  Future<void> _deletePrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privateKey');
    setState(() {
      storedPrivateKey = null;
      publicKey = null;
      isFirstTime = true; // وقتی کلید حذف شد، دوباره به فرم وارد می‌شود
    });
    Get.snackbar(
      "Deleted!",
      "Private Key has been deleted.",
      colorText: const Color(0xffE2E2B6),
      backgroundColor: const Color(0xff03346E).withOpacity(0.4),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

// فرم ورود کلید خصوصی
  Widget buildPrivateKeyInputForm() {
    return FutureBuilder(
      future: _loadPrivateKey(), // بارگذاری کلید خصوصی از SharedPreferences
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // نمایش لوادر در حال بارگذاری
        } else if (snapshot.connectionState == ConnectionState.done) {
          // اگر کلید خصوصی ذخیره شده باشد، به صفحه WalletScreen هدایت می‌شود
          if (storedPrivateKey != null) {
            Future.microtask(() {
              Get.to(() => WalletScreenView(privateKey: storedPrivateKey!));
            });
            return const SizedBox.shrink(); // اگر کلید خصوصی وجود دارد، هیچ چیزی نمایش داده نمی‌شود
          }

          // در غیر این صورت فرم ورود نمایش داده می‌شود
          return _buildPrivateKeyForm();
        } else {
          return const Center(child: Text("Error loading private key"));
        }
      },
    );
  }

// فرم کلید خصوصی
  Widget _buildPrivateKeyForm() {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: privateKeyModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 100),
                _buildTitle("Enter your Private Key"),
                const SizedBox(height: 100),
                _buildTextField(
                  privateKeyModel.privateKeyController,
                  'Private Key',
                  Icons.lock,
                  obscure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a private key';
                    }
                    final RegExp regex = RegExp(r'^[A-Za-z0-9]+$');
                    if (!regex.hasMatch(value)) {
                      return 'Private key can only contain alphanumeric characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 100),
                GestureDetector(
                  onTap: _handlePrivateKeySubmit,
                  child: _buildSubmitButton(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// متد ارسال کلید خصوصی
  void _handlePrivateKeySubmit() {
    if (privateKeyModel.formKey.currentState!.validate()) {
      String privateKey = privateKeyModel.privateKeyController.text.trim();
      _savePrivateKey(privateKey); // ذخیره کلید خصوصی
      setState(() {
        storedPrivateKey = privateKey;
        publicKey = calculatePublicKey(privateKey);
        isFirstTime = false; // بار دوم به بعد
      });
      Get.snackbar(
        "Welcome!",
        "Private Key saved successfully.",
        colorText: const Color(0xffE2E2B6),
        backgroundColor: const Color(0xff03346E).withOpacity(0.5),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

// دکمه ارسال
  Widget _buildSubmitButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff6EACDA), Color(0xff03346E)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff6EACDA).withOpacity(0.9),
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: const Color(0xffE2E2B6).withOpacity(0.6),
            offset: const Offset(-6, -6),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
      child: Center(
        child: Custume_Text(
          text: 'Submit',
          color: const Color(0xffE2E2B6),
          Size: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

// ساخت فیلد متن برای ورود کلید خصوصی
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscure = false, required String? Function(String?) validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        prefixIcon: Icon(icon, color: const Color(0xffE2E2B6)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xffE2E2B6), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xff6EACDA), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: validator,
    );
  }
}