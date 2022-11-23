import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../../home/views/home_view3.dart';
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
        body: Stack(
          // fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  colors: [
                    // secondaryColor,
                    primaryColor,
                    forGradient,
                  ],
                ),
              ),
              height: height * 0.21,
              alignment: Alignment.center,
              child: Text(
                "Socities",
                style: textTheme.titleLarge!.copyWith(
                    fontSize: textTheme.titleLarge!.fontSize! + 6,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                Container(
                  // color: Colors.yellow,
                  height: height * 0.16,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Constants.defaultRadius * 4),
                        topRight: Radius.circular(Constants.defaultRadius * 4)),
                    color: widgetColor,
                  ),
                  height: height * 0.84,
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.only(top: Constants.defaultPadding),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kHeight,
                            kHeight,
                            _buildTag(context: context, text: 'CS Dept.'),
                            kHeight,
                            kHeight,
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildSocietyCard(context,
                                      name: "Computer Science"),
                                  buildSocietyCard(context,
                                      name: "Computer Science"),
                                ]),
                            kHeight,
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildSocietyCard(context,
                                      name: "Computer Science"),
                                  buildSocietyCard(context,
                                      name: "Computer Science"),
                                ]),
                            kHeight,
                            kHeight,
                            _buildTag(context: context, text: 'BBA Dept.'),
                            kHeight,
                            kHeight,
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildSocietyCard(context,
                                      name: "Computer Science"),
                                  buildSocietyCard(context,
                                      name: "Computer Science"),
                                ]),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            buildParticles(width, height * 0.15),
            SafeArea(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Icon(Icons.arrow_back_rounded,
                      color: Colors.white, size: Constants.iconSize + 5),
                ),
              ),
            ),
          ],
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
              'https://scontent.flhe28-1.fna.fbcdn.net/v/t39.30808-6/310661575_110379318512956_136870021229319444_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFooroeYd0uTVENcOoIB7O9SMh-jz3PNolIyH6PPc82iWf-phJwL3VZOJpxnDX-CsdpVbIlgEhoNfZQC7kPUqmi&_nc_ohc=zlJZNQZlkhYAX8hh5gL&tn=qBHsSZIFz85ua4G-&_nc_ht=scontent.flhe28-1.fna&oh=00_AfA8xHecqzXJhvuVYZ4zV0HlOSYk_wUn4Z0AZ--O_H4loQ&oe=6382152B',
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
