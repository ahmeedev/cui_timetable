import 'dart:io';

import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class GetXUtilities {
  static void snackbar(
      {required String title, required String message, required gradient}) {
    Get.closeAllSnackbars();

    if (Platform.isAndroid) {
      Get.showSnackbar(GetSnackBar(
        // backgroundColor: primaryColor,
        // padding: EdgeInsets.all(Constants.defaultPadding),

        margin: EdgeInsets.zero,
        backgroundGradient:
            LinearGradient(end: Alignment.bottomRight, colors: gradient),

        duration: const Duration(seconds: 2),
        titleText: Text(title,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        messageText: Text(message,
            style: const TextStyle(fontSize: 14, color: Colors.white)),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        // backgroundColor: primaryColor,
      ));
    } else if (Platform.isIOS) {
      Get.snackbar(
        "Default SnackBar",
        "This is the Getx default SnackBar",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1500),
        titleText: Text(title,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        messageText: Text(message,
            style: const TextStyle(fontSize: 12, color: Colors.black)),
      );
    }
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

  static void historyDialog({required context, required List content}) {
    Get.defaultDialog(
      backgroundColor: widgetColor,
      titlePadding: EdgeInsets.all(Constants.defaultPadding),
      title: 'History',
      titleStyle:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
      contentPadding: EdgeInsets.all(Constants.defaultPadding),
      content: content.isEmpty
          ? Text('No Record yet')
          : Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      // Get.back();

                      Get.toNamed(Routes.STUDENT_TIMETABLE,
                          arguments: [content[index]]);
                    },
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      content[index].toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: primaryColor,
                    height: 2,
                    // indent: 15,
                    // endIndent: 15,
                  );
                },
              )),
    );
  }
}
