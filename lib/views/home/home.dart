import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cui_timetable/controllers/database/download_utilities.dart';
import 'package:cui_timetable/controllers/developer/developer_controller.dart';
import 'package:cui_timetable/controllers/firebase/firebase_controller.dart';
import 'package:cui_timetable/controllers/home/home_controller.dart';
import 'package:cui_timetable/models/utilities/get_utilities.dart';
import 'package:cui_timetable/models/utilities/home_utilities.dart';
import 'package:cui_timetable/style.dart';
import 'package:cui_timetable/views/freerooms/freerooms.dart';
import 'package:cui_timetable/views/home/drawer/drawer.dart';
import 'package:cui_timetable/views/timetable/timetable_main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final developerController = Get.find<DeveloperController>();
  final firebaseController = Get.find<FirebaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBody: true,

        // extendBodyBehindAppBar: true,
        backgroundColor: scaffoldColor,
        drawer: Drawer(
          child: Container(
            color: scaffoldColor,
            child: Column(
              children: const [Header(), ButtonList()],
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                HomeAppBar(),
                const HomeBody(),
                // const HomeBottomWidget(),
              ],
            ),
            const HomeOverlay()
          ],
        ));
  }
}

/// AppBar for the Home Screen.
class HomeAppBar extends StatelessWidget {
  HomeAppBar({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 4,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      // title: const Text('CUI_TIMETABLE'),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(defaultRadius * 2),
            bottomRight: Radius.circular(defaultRadius * 2)),
        child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  gradient: const LinearGradient(
                    end: Alignment.bottomRight,
                    colors: [
                      // secondaryColor,
                      primaryColor,
                      forGradient,
                    ],
                  ),
                  // image: const DecorationImage(
                  //     image: AssetImage('assets/home/art.png'),
                  //     scale: 10,
                  //     fit: BoxFit.fitWidth)
                ),
                height: double.infinity,
                child: Center(
                  child: Text(
                    'CUI TIMETABLE',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  // child: DefaultTextStyle(
                  //   style: Theme.of(context).textTheme.titleLarge!,
                  //   child: AnimatedTextKit(
                  //     repeatForever: true,
                  //     animatedTexts: [
                  //       // TypewriterAnimatedText('CUI'),
                  //       // TypewriterAnimatedText('TIMETABLE'),
                  //       TypewriterAnimatedText('CUI TIMETABLE'),
                  //     ],
                  //     onTap: () {
                  //       print("Tap Event");
                  //     },
                  //     pause: const Duration(milliseconds: 5000),
                  //     // displayFullTextOnTap: true,
                  //   ),
                  // ),
                ),
              ),

              Align(
                alignment: Alignment.center + const Alignment(0.60, -0.60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: shadowColor, fontStyle: FontStyle.italic),
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
                        onTap: () {
                          print("Tap Event");
                        },
                        repeatForever: true,
                        pause: const Duration(milliseconds: 2000),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )

              // Align(
              //   // duration: const Duration(seconds: 1),
              //   // top: homeController.first.value,
              //   // right: homeController.second.value,
              //   // top: MediaQuery.of(context).size.height / 5,
              //   alignment: Alignment.center + Alignment(0.50, -0.30),
              //   // alignment: Alignment.centerRight,
              //   child: AnimatedBuilder(
              //     animation: homeController.controller,
              //     builder: (_, child) {
              //       return Transform.rotate(
              //         angle: homeController.controller.value * 2 * 3.1415,
              //         child: Container(
              //             width: 20,
              //             height: 20,
              //             decoration: const BoxDecoration(
              //                 color: shadowColor, shape: BoxShape.rectangle)),
              //       );
              //     },
              //     // duration: Duration(seconds: 1),
              //     // turns: homeController.first.value,
              //     // child:
              //   ),
              // ),
            ]),
      ),
    );
  }
}

/// Body of Home Screen.
class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding:
            const EdgeInsets.only(top: 65, right: 8.0, left: 8.0, bottom: 0),
        sliver: SliverFillRemaining(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: Text('Latest News',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w900)),
                  ),
                  // RichText(
                  //     text: TextSpan(children: [
                  //   TextSpan(
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .titleSmall!
                  //           .copyWith(color: primaryColor),
                  //       text: "More>",
                  //       recognizer: TapGestureRecognizer()
                  //         ..onTap = () async {
                  //           var url = "http://sahiwal.comsats.edu.pk/";
                  //           if (await canLaunch(url)) {
                  //             await launch(url);
                  //           } else {
                  //             throw 'Could not launch $url';
                  //           }
                  //         }),
                  // ]))
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    // shrinkWrap: true,
                    children: [
                      buildNews(
                        context,
                        expanded: true,
                        title: 'Student Week 2022',
                        description:
                            'Students Week Spring 2022 will be held at CUI, Sahiwal Campus.The dates of the week are March 21st, 2022 till March 25th, 2022',
                      ),
                      buildNews(
                        context,
                        expanded: false,
                        title: 'FEE Notification - Spring 2022',
                        description: '''Dear Students,
The second installment of the fee is due on March 25, 2022.
After the due date Rs. 100 per day fine will be charged and the fee defaulters cannot appear in mid-term exam. The fee vouchers have been generated on the CU-online portals. Please follow the due dates to avoid fine and absence in the Mid-term exam.''',
                      ),
                    ]),
              ),

              const HomeBottomWidget()

              /// Building Card for news
            ],
          ),
        ));
  }
}

/// Bottom Widget for Home Screen.
class HomeBottomWidget extends StatelessWidget {
  const HomeBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CU Online Portal',
                    style: Theme.of(context).textTheme.titleMedium),
                Text('Sign in to view details',
                    style: Theme.of(context).textTheme.bodyMedium),
              ]),
          ElevatedButton(
              onPressed: () async {
                // GetXUtilities.dialog();
                final loc = await getApplicationDocumentsDirectory();

                compute(downloadFile, {
                  "defaultLocalLocation": loc.path,
                  "remoteFileName": 'timetable.csv'
                }).then((value) => print(value));
              },
              child: Text(
                'Sign in',
                style: Theme.of(context).textTheme.labelLarge,
              )),
        ],
      ),
    );
  }
}

/// Overlay for Home Screen.
class HomeOverlay extends StatelessWidget {
  const HomeOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height / 4.5,
        right: 10,
        left: 10,
        child: Card(
          color: widgetColor,
          elevation: defaultElevation,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => Timetable());
                  },
                  child: Column(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/home/timetable.png'),
                        size: iconSize,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Timetable',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 2,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => FreeRooms(), transition: Transition.cupertino);
                    // GetXUtilities.snackbar(
                    //     title: 'In Development',
                    //     message: 'This Module is still in Developement Phase',
                    //     gradient: primaryGradient);
                  },
                  child: Column(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/home/room.png'),
                        size: iconSize,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Free rooms',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 2,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    GetXUtilities.snackbar(
                        title: 'In Developement',
                        message: 'This Module is still in Development Phase',
                        gradient: primaryGradient);
                  },
                  child: Column(
                    children: [
                      const ImageIcon(
                        AssetImage('assets/home/datesheet.png'),
                        size: iconSize,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Datesheet',
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
