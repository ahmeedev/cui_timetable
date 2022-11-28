import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../controllers/socities_controller.dart';

class SocitiesView extends GetView<SocitiesController> {
  const SocitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = Get.width;
    final height = Get.height;

    return Scaffold(
        backgroundColor: const Color(0xffB7CAE1),
        appBar: AppBar(title: const Text("Socities")),
        body: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: CupertinoSegmentedControl<int>(
                      padding: EdgeInsets.zero,
                      selectedColor: primaryColor,
                      borderColor: primaryColor,
                      unselectedColor: widgetColor,
                      children: {
                        0: const Text('All')
                            .paddingAll(Constants.defaultPadding),
                        1: const Text('CS Dept.').paddingSymmetric(
                            horizontal: Constants.defaultPadding * 2),
                        2: const Text('MS Dept.').paddingSymmetric(
                            horizontal: Constants.defaultPadding * 2),
                        3: const Text('MS Dept.').paddingSymmetric(
                            horizontal: Constants.defaultPadding * 2),
                        4: const Text('MS Dept.').paddingSymmetric(
                            horizontal: Constants.defaultPadding * 2),
                        5: const Text('MS Dept.').paddingSymmetric(
                            horizontal: Constants.defaultPadding * 2),
                      },
                      onValueChanged: (int val) {
                        controller.segmentedControlValue.value = val;
                      },
                      groupValue: controller.segmentedControlValue.value,
                    ),
                  ),
                  kHeight,
                  kHeight,
                  Expanded(
                      child: GridView.count(
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: Constants.defaultPadding,
                          mainAxisSpacing: 0,
                          children: [
                        buildSocietyCard(context, name: "CS Society"),
                        buildSocietyCard(context, name: "Literacy Society"),
                        buildSocietyCard(context, name: "Literacy Society"),
                        buildSocietyCard(context, name: "Literacy Society"),
                        buildSocietyCard(context, name: "Literacy Society"),
                        buildSocietyCard(context, name: "Literacy Society"),
                        buildSocietyCard(context, name: "Literacy Society"),
                        buildSocietyCard(context, name: "Literacy Society"),
                      ]))
                ],
              )),
        ));
  }

  buildSocietyCard(context, {required String name}) {
    final textTheme = Theme.of(context).textTheme;
    final width = Get.width;
    final height = Get.height;
    return SizedBox(
      width: width * 0.45,
      height: height * 0.28,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Constants.defaultRadius),
                      topRight: Radius.circular(Constants.defaultRadius)),
                  gradient: const LinearGradient(
                    end: Alignment.bottomRight,
                    colors: [
                      // secondaryColor,
                      primaryColor,
                      forGradient,
                    ],
                  ),
                ),
                child: Text(
                  name,
                  style: textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ).paddingAll(Constants.defaultPadding)),
            Image.network(
              "https://images.unsplash.com/photo-1664725080246-9d5368a0a86b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
              // fit: BoxFit.fill,
            )
          ]),
    );
  }

  _buildTag({required context, required text}) {
    final theme = Theme.of(context);

    return Card(
        color: primaryColor.withOpacity(0.8),
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Constants.defaultRadius / 2),
                bottomRight: Radius.circular(Constants.defaultRadius / 2))),
        margin: EdgeInsets.zero,
        child: Text(
          text,
          style: theme.textTheme.titleSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ).paddingAll(Constants.defaultPadding)
        // .paddingSymmetric(horizontal: Constants.defaultPadding),
        );
    // .paddingSymmetric(horizontal: Constants.defaultPadding);
  }
}
