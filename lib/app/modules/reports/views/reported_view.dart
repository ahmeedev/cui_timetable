import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/modules/reports/controllers/reports_controller.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../theme/app_colors.dart';

class ReportedView extends GetView<ReportsController> {
  const ReportedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.getReports(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data() ?? {};
            final keys = data.keys.toList();

            keys.sort((a, b) {
              //sorting in ascending order
              return DateTime.parse(b).compareTo(DateTime.parse(a));
            });

            return data.isEmpty
                ? const Center(
                    child: Text(
                      'No Reports/Feedbacks available',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : createCards(data, keys);
          } else {
            return const Center(
              child: Text(
                'No Reports/Feedbacks available',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          return const Center(
              child: SpinKitCircle(
            color: primaryColor,
          ));
        });
  }

  Padding createCards(Map<String, dynamic> data, List<String> keys) {
    return Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: data.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Slidable(
                         key: const ValueKey(0),
                         groupTag: "feedbacks",
                        //  closeOnScroll: true,
                          startActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  borderRadius: BorderRadius.all(Radius.circular(Constants.defaultRadius)),
                                  onPressed: controller.deleteReport(),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  autoClose: true,
                                  // padding: EdgeInsets.symmetric(vertical: Constants.defaultPadding * 2),
                                ),
                              ]),
                        child: Card(
                          elevation: Constants.defaultElevation,
                          child: Padding(
                            padding: EdgeInsets.all(Constants.defaultPadding*2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data[keys[index]]["userTitle"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      DateFormat("yyyy-MM-dd").format(
                                          DateTime.parse(keys[index].toString())),
                                      // keys[index].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(fontWeight: FontWeight.w400,color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Constants.defaultPadding,
                                ),
                                Wrap(
                                  children: [
                                    Text(data[keys[index]]["userMsg"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
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
}
