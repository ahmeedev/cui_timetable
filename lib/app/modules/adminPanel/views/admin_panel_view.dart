import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/global_widgets.dart';
import '../controllers/admin_panel_controller.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  const AdminPanelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: selectionColor,
      appBar: AppBar(title: const Text("Admin Panel")),
      body: Padding(
        padding: EdgeInsets.all(Constants.defaultPadding * 2),
        child: Card(
          color: scaffoldColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight,
              _buildTag(context: context, text: 'Academic'),
              kHeight,
              kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  kWidth,
                  _buildTile(context,
                      title: "Timetable",
                      iconLocation: "assets/home/timetable.png"),
                  kWidth,
                  _buildTile(context,
                      title: "Freerooms", iconLocation: "assets/home/room.png"),
                  kWidth,
                  _buildTile(context,
                      title: "Datesheet",
                      iconLocation: "assets/home/datesheet.png"),
                  kWidth,
                  _buildTile(
                    context,
                    blank: true,
                  ),
                  kWidth,
                ],
              ),
              // kHeight,
              // Row(
              //   // mainAxisSize: MainAxisSize.min,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     kWidth,
              //     _buildTile(
              //       context,
              //       title: "Socities",
              //       iconLocation: "assets/home/room.png",
              //     ),
              //     kWidth,
              //     _buildTile(context,
              //         title: "Transport",
              //         iconLocation: "assets/home/transport.png"),
              //     kWidth,
              //     _buildTile(context,
              //         title: "Meetups",
              //         iconLocation: "assets/home/datesheet.png"),
              //     kWidth,
              //     _buildTile(
              //       context,
              //       blank: true,
              //     ),
              //     kWidth,
              //   ],
              // ),
              kHeight,
              kHeight,
              kHeight,
              kHeight,
              _buildTag(context: context, text: 'News & Events'),
              kHeight,
              kHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kWidth,
                  _buildTile(
                    context,
                    title: "Annouc",
                    iconLocation: "assets/home/announc.png",
                    ontap: () => Get.toNamed(Routes.ANNOUNCEMENT),
                  ),
                  kWidth,
                  _buildTile(context,
                      title: "Feedback",
                      iconLocation: "assets/home/feedback.png",
                      ontap: () => Get.toNamed(Routes.ADMIN_FEEDBACK)),
                  kWidth,
                  _buildTile(context,
                      title: "Requests",
                      iconLocation: "assets/home/feedback.png",
                      ontap: () => Get.toNamed(Routes.BOOKING_REQUEST)),
                  kWidth,
                  _buildTile(
                    context,
                    blank: true,
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

_buildTile(context,
    {String title = "", String iconLocation = "", ontap, blank = false}) {
  final textTheme = Theme.of(context).textTheme;
  return Flexible(
    child: FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicWidth(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Constants.defaultRadius),
                    topRight: Radius.circular(Constants.defaultRadius)),
                gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  colors: blank == true
                      ? [
                          Colors.transparent,
                          Colors.transparent,
                        ]
                      : [
                          // secondaryColor,
                          primaryColor,
                          forGradient,
                        ],
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.defaultPadding - 2,
                    vertical: Constants.defaultPadding / 2,
                  ),
                  child: Text(
                    title,
                    style: textTheme.labelLarge!.copyWith(
                        fontSize: textTheme.labelLarge!.fontSize! - 2,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          blank == true
              ? const SizedBox()
              : Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Constants.defaultRadius),
                    bottomRight: Radius.circular(Constants.defaultRadius),
                  )),
                  margin: EdgeInsets.zero,
                  // color: Color(0xffB0CAEC),
                  color: widgetColor,
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Constants.defaultRadius),
                      bottomRight: Radius.circular(Constants.defaultRadius),
                    ),
                    splashColor: selectionColor,
                    highlightColor: Colors.transparent,
                    onTap: ontap,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Constants.defaultPadding * 2.2,
                            vertical: Constants.defaultPadding,
                          ),
                          // .copyWith(
                          //     top: Constants.defaultPadding / 2),
                          child: ImageIcon(
                            AssetImage(iconLocation),
                            // size: Constants.iconSize,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    ),
  );
}
