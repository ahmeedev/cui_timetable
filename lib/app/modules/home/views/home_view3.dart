import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soul/flutter_soul.dart' as flutterSoul;
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import 'widgets/home_drawer.dart';

class HomeView3 extends StatefulWidget {
  const HomeView3({Key? key}) : super(key: key);

  @override
  State<HomeView3> createState() => _HomeView3State();
}

class _HomeView3State extends State<HomeView3> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    const colorizeColors = [
      // Colors.purple,
      // Colors.blue,
      // Colors.yellow,
      // Colors.red,
      primaryColor,
      secondaryColor,
      selectionColor,
      widgetColor
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );
    return SafeArea(
      child: Scaffold(
          key: _key,
          drawer: Drawer(
            width: width / 1.5,
            child: Container(
              color: scaffoldColor,
              child: Column(
                children: const [Header(), ButtonList()],
              ),
            ),
          ),
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  width: width,
                  height: height * 0.4,
                  decoration: const BoxDecoration(
                      // color: primaryColor,
                      gradient: LinearGradient(colors: primaryGradient)),
                  child: Text(
                    'CUI SAHIWAL',
                    style: textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .fontSize! +
                            4.0),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: height * 0.3,
                  ),
                  Padding(
                    padding: EdgeInsets.all(Constants.defaultPadding),
                    child: Container(
                      width: width,
                      height: height * 0.52,
                      decoration: BoxDecoration(
                        color: widgetColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Constants.defaultRadius),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: SingleChildScrollView(
                          child: WidgetArea(textTheme: textTheme)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Row(
                  children: [
                    InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        //  hoverColor: Colors.tra

                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectionColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Constants.defaultRadius),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ImageIcon(
                                const AssetImage('assets/drawer/menu2.png'),
                                color: Colors.white,
                                size: Constants.iconSize - 4,
                              ),
                            ),
                          ),
                        )),
                    const Spacer(),
                    const TypeWriterText()
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(Constants.defaultPadding),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Constants.defaultRadius * 2),
                ),
              ),
              child: Container(
                width: width,
                height: height * 0.1,
                // padding: EdgeInsets.all(Constants.defaultPadding),
                decoration: BoxDecoration(
                  // color: primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.all(
                    Radius.circular(Constants.defaultRadius * 2),
                  ),
                  gradient: const LinearGradient(colors: primaryGradient),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.2),
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Constants.defaultRadius),
                          ),
                          // color: selectionColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Constants.defaultPadding),
                          child: Icon(
                            Icons.newspaper,
                            size: Constants.iconSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Constants.defaultRadius),
                          ),
                          color: selectionColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Constants.defaultPadding),
                          child: Icon(
                            Icons.home,
                            size: Constants.iconSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Constants.defaultRadius),
                          ),
                          // color: selectionColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Constants.defaultPadding),
                          child: Icon(
                            Icons.settings,
                            size: Constants.iconSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Icon(Icons.home, size: Constants.iconSize),
                      // Icon(Icons.home, size: Constants.iconSize),
                    ]),
              ),
            ),
          )
          // .roundAll(Constants.defaultRadius * 2)
          // .paddingAll(Constants.defaultPadding)
          ),
    );
  }
}

class WidgetArea extends StatelessWidget {
  const WidgetArea({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Events",
          style: textTheme.titleMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Constants.defaultPadding),
        Row(
          children: [
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Meetups", iconLocation: "assets/home/datesheet.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Socities", iconLocation: "assets/home/room.png"),
            _buildTile(context, blank: true),
            _buildTile(context, blank: true),
          ],
        ),
        SizedBox(height: Constants.defaultPadding),
        SizedBox(height: Constants.defaultPadding),
        Text(
          "Academic",
          style: textTheme.titleMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Constants.defaultPadding),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTile(context,
                title: "Timetable",
                ontap: () => Get.toNamed(Routes.TIMETABLE),
                iconLocation: "assets/home/timetable.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Datesheet",
                ontap: () => Get.toNamed(Routes.DATESHEET),
                iconLocation: "assets/home/datesheet.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Freerooms",
                ontap: () => Get.toNamed(Routes.FREEROOMS),
                iconLocation: "assets/home/room.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Comparision", iconLocation: "assets/home/menu.png"),
          ],
        ),
        SizedBox(height: Constants.defaultPadding),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTile(context,
                title: "Timetable",
                ontap: () => Get.toNamed(Routes.TIMETABLE),
                iconLocation: "assets/home/timetable.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Datesheet",
                ontap: () => Get.toNamed(Routes.DATESHEET),
                iconLocation: "assets/home/datesheet.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context, blank: true),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context, blank: true),
          ],
        ),
        SizedBox(height: Constants.defaultPadding),
        SizedBox(height: Constants.defaultPadding),
        Text(
          "General",
          style: textTheme.titleMedium!
              .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Constants.defaultPadding),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTile(context,
                title: "Feedback",
                // ontap: () => Get.toNamed(Routes.TIMETABLE),
                iconLocation: "assets/home/timetable.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "About Us",
                // ontap: () => Get.toNamed(Routes.DATESHEET),
                iconLocation: "assets/home/datesheet.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Donation",
                // ontap: () => Get.toNamed(Routes.FREEROOMS),
                iconLocation: "assets/home/room.png"),
            SizedBox(width: Constants.defaultPadding),
            _buildTile(context,
                title: "Contribute", iconLocation: "assets/home/menu.png"),
          ],
        ),
        // SizedBox(height: Constants.defaultPadding),
      ],
    );
  }
}

class TypeWriterText extends StatelessWidget {
  const TypeWriterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: shadowColor, fontStyle: FontStyle.italic),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText('BE AWESOME'),
          TypewriterAnimatedText('BE OPTIMISTIC'),
          TypewriterAnimatedText('BE DIFFERENT'),
          TypewriterAnimatedText('BE CONSISTENT'),
          TypewriterAnimatedText('YOU MATTER'),
          TypewriterAnimatedText('YOU CAN'),
          TypewriterAnimatedText('TAKE RISK'),
          TypewriterAnimatedText('ACCEPT YOURSELF'),
          TypewriterAnimatedText('TRUST YOURSELF'),
          TypewriterAnimatedText('STAY FOCUSED'),
          TypewriterAnimatedText('STAY POSITIVE'),
          TypewriterAnimatedText('STAY CURIOUS'),
          TypewriterAnimatedText('MOVE FORWARD'),
          TypewriterAnimatedText('TRY AGAIN'),
          TypewriterAnimatedText('ENJOY LIFE'),
        ],
        repeatForever: true,
        pause: const Duration(milliseconds: 2000),
      ),
    );
  }
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
                    style: textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w900, color: Colors.white),
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
                  color: scaffoldColor,
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
