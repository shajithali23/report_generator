import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterField extends StatelessWidget {
  FilterField(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.onpressed,
      this.controller})
      : super(key: key);
  final String hint;
  final IconData icon;
  final onpressed;
  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 250, height: 40),
      child: TextFormField(
        controller: controller,
        onTap: onpressed,
        readOnly: true,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(fontWeight: FontWeight.w400)),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 4, left: 8),
            hintText: hint,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FaIcon(
                icon,
                color: Color.fromRGBO(77, 77, 77, 1),
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4)),
                borderRadius: BorderRadius.circular(6))),
      ),
    );
  }
}
