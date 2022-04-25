import 'package:cui_timetable/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXUtilities {
  static void snackbar(context,
      {required String title, required String message}) {
    Get.showSnackbar(GetSnackBar(
      // backgroundColor: primaryColor,
      backgroundGradient: const LinearGradient(
        end: Alignment.bottomRight,
        colors: [primaryColor, forGradient],
      ),
      duration: const Duration(seconds: 2),
      titleText: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white, fontSize: 18),
      ),
      messageText: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.white),
      ),
    ));
  }
}
