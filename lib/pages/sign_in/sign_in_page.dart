
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/sign_in_controller.dart';
import 'components/sign_in_left.dart';
import 'components/sign_in_right.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());
    return Scaffold(
      body: Row(
        children: [
          const SignInLeft(),
          SignInRight(
            controller: controller,
          ),
        ],
      ),
    );
  }
}
