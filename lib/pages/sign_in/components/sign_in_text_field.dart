import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.labelName,
      required this.controller,
      required this.validator,
      required this.width,
      this.inputFormatters,
      this.obsecureText = false})
      : super(key: key);
  final String labelName;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool obsecureText;
  final double width;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obsecure = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obsecure = widget.obsecureText;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    obsecure = false;
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelName,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  fontWeight: FontWeight.w400)),
        ),
        const SizedBox(
          height: 4,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: widget.width * 0.30),
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: obsecure,
            decoration: InputDecoration(
                suffixIcon: widget.obsecureText
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            obsecure = !obsecure;
                          });
                        },
                        icon: Icon(
                            obsecure ? Icons.visibility_off : Icons.visibility))
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
        )
      ],
    );
  }
}
