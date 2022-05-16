import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';

import '../../../controllers/sign_in_controller.dart';


class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());

    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      color: Color(0xFF295DC0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 150, height: 32),
            child: Image.asset(
              "assets/images/logo2.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () {
                controller.logout(context);
              },
              child: Text(
                "Logout",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
