import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cui_timetable/app/modules/adminPanel/adminFeedback/controllers/admin_feedback_controller.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';

class AdminRepotedView extends GetView<AdminFeedbackController> {
  const AdminRepotedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: controller.getReports(),
      builder: (context, snapshot) {
        
        if (snapshot.hasData) {
          

          final reportCollection = snapshot.data!;
          final reportCollectionKey = [];
          final results =<String,dynamic> {};
          final keys = [];
          for (var element in reportCollection.docs) {
            reportCollectionKey.add(element.id);

            final map = element.data() as Map<String, dynamic>;
            map.forEach((key, value) {
              results[key]=value;
            });
// keys.add(map.keys);
           for (var key in map.keys) {
            keys.add(key);
           }

          }
          log(reportCollectionKey.toString());
          log(results.length.toString());

          return createCards(results: results,keys: keys);
        } else {
          return const Center(
            child: Text(
              'No Reports/Feedbacks available',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        if (snapshot.hasError) {}

        return const Center(
            child: SpinKitCircle(
          color: primaryColor,
        ));
      
      
      },
    );
  }

  Padding createCards({required Map results, required List keys}) {
    return Padding(
      padding: EdgeInsets.all(Constants.defaultPadding),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
        return Slidable(
          key: const ValueKey(0),
          startActionPane: const ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ]),
          child: Card(
            elevation: Constants.defaultElevation,
            child: Padding(
              padding: EdgeInsets.all(Constants.defaultPadding),
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
                        DateFormat("yyyy-MM-dd").format(
                            DateTime.parse(results[keys[index]].toString())),
                        // keys[index].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.w600),
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
}
