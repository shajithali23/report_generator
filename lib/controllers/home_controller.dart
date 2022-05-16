import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime endDate = DateTime.now();
  lastDate() {
    endDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day - 1);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2022, 1),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = picked.day.toString() +
          "/" +
          picked.month.toString() +
          "/" +
          picked.year.toString();
    }
  }
}
