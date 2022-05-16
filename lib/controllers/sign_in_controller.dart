import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../pages/sign_in/sign_in_page.dart';
import '../service/constant_urls.dart';
import '../utils/validation.dart';

class SignInController extends GetxController with InputValidationMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  var validate = false.obs;
  var loader = false.obs;
  var errorMsg = "".obs;
  final storage = FlutterSecureStorage();
  String token = "";

  logout(BuildContext context) async {
    await storage.deleteAll();
    Get.off(SignInPage());
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => SignInPage()));
  }

  displayValues(BuildContext context) async {
    if (validate.isFalse) {
      validate.toggle();
    }
    if (formGlobalKey.currentState!.validate()) {
      debugPrint("Valid");
      loader.toggle();

      var loginRes =
          await login(emailController.text, passwordController.text, context);
      print(loginRes);
      Future.delayed(const Duration(milliseconds: 1500), () {
// Here you can write your code
        loader.toggle();
      });
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HomePage()));

      return true;
    } else {
      debugPrint("object");
      return false;
    }
  }

  login(String email, String password, BuildContext context) async {
    String res = "";
    bool isResponse = false;

    String url = "${URLS.baseURL}${URLS.login}";

    Map<String, dynamic> params = {
      "email": email,
      "password": password,
    };
    log(params.toString());
    await storage.deleteAll();
    try {
      var response = await http.post(Uri.parse(url), body: jsonEncode(params));
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        debugPrint(data["data"]['results'].toString());
        if (data["success"] == true) {
          res = "";
          var userData = data["data"]['results'] as Map;
          for (final name in userData.keys) {
            final value = userData[name];
            debugPrint('$name,$value');
            await storage.write(
              key: name,
              value: value.toString(),
            );
          }
          errorMsg = "".obs;
          debugPrint(data["data"]["token"]["token"]);
          await Fluttertoast.showToast(
              msg: "Login success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          // try {
          await storage.write(
            key: "token",
            value: data["data"]["token"]["token"],
          );
          // } catch (e) {
          //   print(e.toString());
          // }
          // //Future.delayed(const Duration(milliseconds: 500), () {
          // //Navigator.of(context)
          // //  .push(MaterialPageRoute(builder: (context) => HomePage()));
          // //});
          //  res
          isResponse = true;
        }
      } else if (response.statusCode == 500) {
        // debugPrint("Internal server error");
        res = "Internal server error";
      } else if (response.statusCode == 404) {
        // debugPrint("Invalid Email or Password");
        res = "Invalid Email or Password";
        errorMsg = res.obs;
      } else {
        // debugPrint("Retry");
        res = "Try again later";
        errorMsg = res.obs;
      }
    } catch (e) {
      debugPrint(e.toString());
      res = "Error";
    }
    return isResponse;
  }

  emailValidations(String email) {
    if (email.isEmpty) {
      return "Email is mandatory";
    } else if (!isEmailValid(email)) {
      return "Invalid Email Id";
    }
  }

  passwordValidations(String password) {
    if (password.isEmpty) {
      return "Password is mandatory";
    } else if (!isPasswordValid(password)) {
      return "Password minimum length  8 characters";
    } else if (!validateStructure(password)) {
      return "Invalid Password";
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
