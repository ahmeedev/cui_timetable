
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/modules/adminPanel/adminFeedback/controllers/admin_feedback_controller.dart';
import 'package:cui_timetable/app/modules/adminPanel/adminFeedback/models/report_model.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';

// ignore: must_be_immutable
class AdminReportedView extends GetView<AdminFeedbackController> {
  AdminReportedView({Key? key}) : super(key: key);
  final reports = Report();
  TextEditingController responseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.getReports(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const Center(
              child: Text(
                'No Reports/Feedbacks available',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          final reportCollection = snapshot.data!;
          final reportCollectionKey = [];
          final results = <String, dynamic>{};
          final keys = [];
          for (var element in reportCollection.docs) {
            reportCollectionKey.add(element.id);

            final map = element.data() as Map<String, dynamic>;
            keys.sort((a, b) {
              //sorting in ascending order
              return DateTime.parse(b).compareTo(DateTime.parse(a));
            });
            map.forEach((key, value) {
              results[key] = value;
            });
            for (var key in map.keys) {
              keys.add(key);
            }
          }

          return createCards(
              results: results,
              keys: keys,
              reportCollection: reportCollection,
              documentId: reports.documentId,
              data: reports.feedbacks);
        }

        return const Center(
            child: SpinKitFadingCube(
          size: 30,
          color: primaryColor,
        ));
      },
    );
  }

  Padding createCards(
      {required String documentId,
      required Map results,
      required List keys,
      required QuerySnapshot<Object?> reportCollection,
      required data}) {
    return Padding(
      padding: EdgeInsets.all(Constants.defaultPadding),
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              // groupTag: "feedbacks",
              // closeOnScroll: false,

              key: const ValueKey(5),
              startActionPane: ActionPane(
                  dragDismissible: true,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Constants.defaultRadius)),
                      onPressed: (context) {
                        Get.dialog(responsePopup(context, results, keys, index),
                            barrierDismissible: false);
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.reply,
                      label: 'Reply',
                    ),
                  ]),
              endActionPane: ActionPane(
                  dragDismissible: true,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Constants.defaultRadius)),
                      onPressed: (context) {
                        controller.deleteReport(
                            results: results, keys: keys, index: index);
                      },
                      backgroundColor: errorColor1,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ]),
              child: Card(
                elevation: Constants.defaultElevation,
                child: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            results[keys[index]]["userTitle"].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                          Text(
                            DateFormat("yyyy-MM-dd")
                                .format(DateTime.parse(keys[index].toString())),
                            // keys[index].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Constants.defaultPadding,
                      ),
                      Wrap(
                        children: [
                          Text(results[keys[index]]["userMsg"].toString(),
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Center responsePopup(BuildContext context, Map<dynamic, dynamic> results,
      List<dynamic> keys, int index) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width / 1.2,
        color: widgetColor,
        child: Material(
          child: Stack(
            children: [
              Positioned(
                  right: -5,
                  top: -7,
                  child: IconButton.filled(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close_outlined))),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Response",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.black),
                      )
                    ],
                  ),
                  const Card(

                  ),
                  Text(results[keys[index]]["userMsg"].toString()),
                  Padding(
                    padding: EdgeInsets.all(Constants.defaultPadding),
                    child: Material(
                      child: TextFormField(
                        controller: responseController,
                        decoration: const InputDecoration(
                            hintText: "Enter your response here",
                            suffixIcon: Icon(Icons.send)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
