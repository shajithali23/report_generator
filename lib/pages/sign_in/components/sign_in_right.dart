import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/style.dart';
import '../../../controllers/sign_in_controller.dart';
import '../../home/home_page.dart';
import 'sign_in_text_field.dart';

class SignInRight extends StatelessWidget {
  const SignInRight({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignInController controller;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Obx(
        () => Form(
          key: controller.formGlobalKey,
          autovalidateMode: controller.validate.isTrue
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.16),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: width * 0.20),
                    child: Image.asset("assets/images/logo.png")),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: width * 0.30),
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
              EmailWidget(width: width),
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: CustomTextField(
                    controller: controller.emailController,
                    labelName: "Email",
                    width: width,
                    validator: (val) {
                      return controller.emailValidations(val!);
                    }),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              PasswordWidget(width: width, controller: controller),
              SizedBox(
                height: height * 0.04,
              ),
              ForgotPassword(
                width: width,
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  controller.errorMsg.value,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              controller.loader.isTrue
                  ? const CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : SignInButton(
                      controller: controller,
                      width: width,
                    ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: CopyRightWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    Key? key,
    required this.width,
    required this.controller,
  }) : super(key: key);

  final double width;
  final SignInController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        width: width,
        controller: controller.passwordController,
        obsecureText: true,
        labelName: "Password",
        validator: (val) {
          return controller.passwordValidations(val!);
        });
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: width * 0.30),
        child: Text(
          "Enter your credentials",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, 0.5),
                fontWeight: FontWeight.w400),
          ),
        ));
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: width * 0.30),
      child: Align(
          alignment: Alignment.topRight,
          child: Text(
            "Forgot password?",
            style: GoogleFonts.inter(
                textStyle:
                    const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6))),
          )),
    );
  }
}

class CopyRightWidget extends StatelessWidget {
  const CopyRightWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.copyright_rounded),
        Text(
          "2022 ApplogiQ. All Rights Reserved",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            textStyle: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
      ],
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key, required this.controller, required this.width})
      : super(key: key);

  final SignInController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: width * 0.30, height: 54),
        child: GestureDetector(
          onTap: () async {
            var login = await controller.displayValues(context);

            debugPrint("login.toString()");
            debugPrint(login.toString());

            if (login) {
              Get.to(HomePage());
            }

            // setState(() {
            //   validate = true;
            // });
            // if (formGlobalKey.currentState!.validate()) {
            //   var check = await signInController.login(
            //       email.text, password.text, context);
            //   print("RES");
            //   print(check.toString());
            //   if (check.toString == null) {
            //     setState(() {
            //       error_msg = "";
            //     });
            //   } else {
            //     setState(() {
            //       error_msg = check.toString();
            //     });
            // }

            //   print("VALID");
            // } else {
            //   print("INVALID");
            // }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 45),
            decoration: BoxDecoration(
                color: const Color(0xFF295DC0),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: Text(
              "Sign In",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.white)),
            )),
          ),
        ));
  }
}
