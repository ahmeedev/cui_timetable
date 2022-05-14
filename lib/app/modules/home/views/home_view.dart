import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/modules/home/views/widgets/home_drawer.dart';
import 'package:cui_timetable/app/modules/home/views/widgets/home_widgets.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/get_widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
          children: const [
            CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                HomeAppBar(),
                HomeBody(),
                // const HomeBottomWidget(),
              ],
            ),
            HomeOverlay()
          ],
        ));
  }
}

/// AppBar for the Home Screen.
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);
  final textHeight = 0.50;
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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
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
                alignment: kIsWeb
                    ? Alignment.topCenter + Alignment(textHeight, textHeight)
                    : Alignment.topCenter + Alignment(textHeight, textHeight),
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
                        repeatForever: true,
                        pause: const Duration(milliseconds: 2000),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

/// Body of Home Screen.
class HomeBody extends GetView<HomeController> {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 10,
            right: 8.0,
            left: 8.0,
            bottom: 0),
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
                fit: FlexFit.tight,
                child: StreamBuilder(
                  stream: controller.getStream(),
                  // initialData: initialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: buildNews(context,
                                expanded: index == 0 ? true : false,
                                title: snapshot.data[index]['title'],
                                description: snapshot.data[index]
                                    ['description']),
                          );
                        },
                      );
                    }
                    return const SpinKitFadingCircle(
                      color: primaryColor,
                    );
                  },
                ),
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
      padding: const EdgeInsets.all(defaultPadding / 2),
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
                // downloadFile('timetable.csv');
                // controller.insertTime();
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
        top: MediaQuery.of(context).size.height / 4.8,
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
                    // Get.to(() => Timetable(), transition: Transition.cupertino);
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
                    // Get.to(() => FreeRooms(), transition: Transition.cupertino);
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
