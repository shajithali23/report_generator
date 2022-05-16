import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_generator/constants/images.dart';
import 'package:report_generator/constants/text.dart';

import '../../../constants/style.dart';

class SignInLeft extends StatelessWidget {
  const SignInLeft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 450, height: 450),
            child: Image.asset(Images().signInImage),
          ),
          Text(
            ConstantText().signInLeftHeader,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.white, fontSize: 24)),
          ),
          Text(
            ConstantText().signInLeftSub,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.white, fontSize: 16)),
          )
        ],
      ),
    ));
  }
}
