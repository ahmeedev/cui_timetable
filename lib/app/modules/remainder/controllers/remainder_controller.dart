// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';


class RemainderController extends GetxController {
  @override
  void onReady() {
    _showPermissionDialog();
    super.onReady();
  }

  void _showPermissionDialog() {
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     Get.defaultDialog(
    //         onWillPop: () => Future.value(false),
    //         // title: 'Synchronizing',
    //         title: '',
    //         // titleStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
    //         //     color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    //         titlePadding: EdgeInsets.zero,
    //         barrierDismissible: false,
    //         backgroundColor: widgetColor,
    //         contentPadding: EdgeInsets.all(Constants.defaultPadding),
    //         radius: Constants.defaultRadius * 2,
    //         content: AspectRatio(
    //           // aspectRatio: 8 / 3,
    //           aspectRatio: 8 / 3.5,
    //           child: (Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               const Text(
    //                 "CUI Timetable wants to access the notifications!",
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 18,
    //                     fontStyle: FontStyle.italic,
    //                     fontWeight: FontWeight.w900),
    //               ),
    //               // kHeight,
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   ElevatedButton(
    //                           onPressed: () {
    //                             Get.back();
    //                           },
    //                           style: ElevatedButton.styleFrom(
    //                               backgroundColor: errorColor1),
    //                           child: const Text('Cancel')
    //                               .paddingAll(Constants.defaultPadding))
    //                       .marginSymmetric(
    //                           horizontal: Constants.defaultPadding),
    //                   ElevatedButton(
    //                       onPressed: () {
    //                         AwesomeNotifications()
    //                             .requestPermissionToSendNotifications();
    //                         Get.back();
    //                       },
    //                       style: ElevatedButton.styleFrom(
    //                           backgroundColor: successColor),
    //                       child: const Text('Allow')
    //                           .paddingAll(Constants.defaultPadding)),
    //                 ],
    //               ),

    //               // SpinKitWave(
    //               //   color: primaryColor,
    //               //   size: 40,
    //               // )
    //               // const LinearProgressIndicator(
    //               //   color: primaryColor,
    //               // )
    //             ],
    //           )),
    //         ));
    //   }
    // });
  }
}
