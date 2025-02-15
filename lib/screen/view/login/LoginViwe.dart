import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../widget/custumeText/widget_Text.dart';
import '../../model/login/login_model.dart';

class LoginPageViwe extends StatelessWidget {

  final loginPage_model LoginPage_model = Get.put(loginPage_model());

  LoginPageViwe({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background gradient effect
      backgroundColor: Color(0xff17191D),
      body: Container(
        child: Stack(
          children: [
            // Background Blur Effect
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
            // Form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: LoginPage_model.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 119),
                    Center(
                      child: Custume_Text(
                        text: "Please Log In Here",
                        color: Colors.white,
                        Size: 35, fontWeight: null,
                      ),
                    ),
                    SizedBox(height: 140),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: _buildTextField(
                            LoginPage_model.usernameController,
                            'Username',
                            Icons.person,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          LoginPage_model.passwordController,
                          'Password',
                          Icons.lock,
                          obscure: true,
                        ),
                        SizedBox(height: 40),
                        // Elevated Button for login
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF6A4CFF), Color(0xFF543CDF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurpleAccent.withOpacity(0.9),
                          offset: Offset(6, 6),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.7),
                          offset: Offset(-4, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Make the button background transparent
                        padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0, // Disable the default shadow
                      ),
                      onPressed: () {
                        if (LoginPage_model.formKey.currentState!
                            .validate()) {
                          Get.toNamed("/PrivateKeyScreen");
                          Get.snackbar("Good login", "",
                              colorText: Color(0xffCBCBCBC));
                        }
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      IconData icon,
      {bool obscure = false}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.w900,fontSize: 18),
          prefixIcon: Icon(icon, color: Colors.black54),
          filled: true,
          fillColor: Color(0xffCBCBCB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 4),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800),
      ),
    );
  }
}