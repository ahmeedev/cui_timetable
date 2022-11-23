import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../../../widgets/global_widgets.dart';
import '../controllers/socities_controller.dart';

class SocitiesView extends GetView<SocitiesController> {
  const SocitiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // final height = Get.height * 0.3;

    return Scaffold(
      backgroundColor: const Color(0xffB7CAE1),
      appBar: AppBar(title: const Text("Socities")),
      body: Container(
        color: const Color(0xffE9F3FF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight,
            kHeight,
            _buildTag(context: context, text: 'Computer Science Dept.'),
            kHeight,
            kHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                kWidth,
                buildCard(context, title: 'CS Club'),
              ],
            ).paddingSymmetric(horizontal: Constants.defaultPadding / 2),
            // kHeight,
            // kHeight,
            // _buildTag(context: context, text: 'Management Dept.'),
            // kHeight,
            // kHeight,
          ],
        ),
      ),
    );
  }

  buildCard(context, {required String title}) {
    final textTheme = Theme.of(context).textTheme;
    final width = Get.width * 0.3;
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
                  gradient: const LinearGradient(
                    end: Alignment.bottomRight,
                    colors: [
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
            Card(
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
                // onTap: ontap,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding * 2.2,
                        vertical: Constants.defaultPadding,
                      ),
                      // .copyWith(
                      //     top: Constants.defaultPadding / 2),
                      child: const ImageIcon(
                        AssetImage(""),
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
