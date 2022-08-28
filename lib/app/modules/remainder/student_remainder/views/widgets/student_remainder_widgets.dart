import 'package:cui_timetable/app/modules/remainder/student_remainder/controllers/student_remainder_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soul/flutter_soul.dart';
import 'package:get/get.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_constants.dart';

class LectureDetailsTile extends GetView<StudentRemainderController> {
  final String subject;
  final String teacher;
  final int counter;
  final bool isSet;

  const LectureDetailsTile(
      {Key? key,
      required this.subject,
      required this.teacher,
      required this.counter,
      required this.isSet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: widgetColor,
          elevation: Constants.defaultElevation,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.defaultRadius))),
          child: Padding(
            padding: EdgeInsets.all(Constants.defaultPadding),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const VerticalDivider(
                  //   color: primaryColor,
                  //   thickness: 2.0,
                  //   // indent: 4,
                  // ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: Constants.defaultPadding / 2,
                          right: Constants.defaultPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(Constants.defaultPadding),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: 'Subject:  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: subject,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: Constants.defaultPadding),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: 'Teacher: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: teacher,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          isSet
                              ? ElevatedButton(
                                  onPressed: () {
                                    controller.setRemainder(subject: subject);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Schedule Remainder",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      SizedBox(
                                        width: Constants.defaultPadding / 2,
                                      ),
                                      const Icon(
                                        Icons.notification_add_outlined,
                                        color: widgetColor,
                                      )
                                    ],
                                  ).paddingVertical(Constants.defaultPadding),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: errorColor1),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Revoke Remainder",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      SizedBox(
                                        width: Constants.defaultPadding / 2,
                                      ),
                                      const Icon(
                                        Icons.notifications_off_outlined,
                                        color: widgetColor,
                                      )
                                    ],
                                  ).paddingVertical(Constants.defaultPadding),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 4,
          top: 4,
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // color: primaryColor,
                gradient: const LinearGradient(colors: primaryGradient),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Constants.defaultRadius / 2),
                    topRight: Radius.circular(Constants.defaultRadius))),
            child: Text(
              counter.toString(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
