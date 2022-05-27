import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class GetXUtilities {
  static void snackbar(
      {required String title, required String message, required gradient}) {
    Get.closeAllSnackbars();
    Get.showSnackbar(GetSnackBar(
      // backgroundColor: primaryColor,
      backgroundGradient:
          LinearGradient(end: Alignment.bottomRight, colors: gradient),
      duration: const Duration(seconds: 2),
      titleText: Text(title,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
      messageText: Text(message,
          style: const TextStyle(fontSize: 14, color: Colors.white)),
    ));
  }

  //! Use Context for the automation of theme.
  static void dialog() {
    Get.defaultDialog(
        onWillPop: () => Future.value(false),
        // title: 'Synchronizing',
        title: '',
        // titleStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
        //     color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        titlePadding: EdgeInsets.zero,
        barrierDismissible: false,
        backgroundColor: widgetColor,
        contentPadding: EdgeInsets.all(Constants.defaultPadding),
        radius: Constants.defaultRadius * 2,
        content: AspectRatio(
          aspectRatio: 8 / 3,
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                "Sync in Progress",
                // style: Theme.of(context).textTheme.titleMedium!.copyWith(
                //     color: Colors.black,
                //     fontSize: 20,
                //     fontStyle: FontStyle.italic,
                //     fontWeight: FontWeight.bold),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              SpinKitWave(
                color: primaryColor,
                size: 40,
              )
              // const LinearProgressIndicator(
              //   color: primaryColor,
              // )
            ],
          )),
        ));
  }
}
