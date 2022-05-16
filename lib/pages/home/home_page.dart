import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:report_generator/pages/home/components/header.dart';

import '../../controllers/home_controller.dart';
import 'components/filter_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       final HomeController controller = Get.put(HomeController());
 
    return Scaffold(
      body:ListView(
        shrinkWrap: true,
        children: [
          Header(),
            Container(
          padding: EdgeInsets.fromLTRB(18, 12, 0, 0),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 4.0,
            ),
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (() {
                        controller.selectedIndex = 0.obs;
                      }),
                      child: IntrinsicWidth(
                        child: Column(
                          children: [
                            Text("Daily Report",
                                style: controller.selectedIndex == 0
                                    ? GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF295DC0),
                                            fontWeight: FontWeight.w500))
                                    : GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.3)),
                                        fontWeight: FontWeight.w500)),
                            controller.selectedIndex == 0
                                ? Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    color: Color(0xFF295DC0),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectedIndex = 1.obs;
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          children: [
                            Text("Monthly Report",
                                style: controller.selectedIndex == 0
                                    ? GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.3)),
                                        fontWeight: FontWeight.w500)
                                    : GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF295DC0),
                                            fontWeight: FontWeight.w500))),
                            controller.selectedIndex == 0
                                ? Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    // color: Color(0xFF295DC0),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    color: Color(0xFF295DC0),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              controller.selectedIndex == 1
                  ? Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilterField(
                            hint: "Year",
                            icon: Icons.arrow_drop_down,
                            onpressed: () {},
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          FilterField(
                            hint: "Project",
                            icon: Icons.arrow_drop_down,
                            onpressed: () {},
                          ),
                          SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilterField(
                            hint: "Date",
                            controller: controller.dateController,
                            icon: FontAwesomeIcons.calendar,
                            onpressed: () {
                              controller.selectDate(context);
                            },
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          FilterField(
                            hint: "Project",
                            icon: Icons.arrow_drop_down,
                            onpressed: () {},
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          FilterField(
                            hint: "Search",
                            icon: Icons.search,
                            onpressed: () {},
                          ),
                          SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
   
        ],
      )
      
    );
  }
}