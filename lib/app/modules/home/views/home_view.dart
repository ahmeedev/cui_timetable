import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/modules/home/views/widgets/home_drawer.dart';
import 'package:cui_timetable/app/modules/home/views/widgets/home_widgets.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';

import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBody: true,

        // extendBodyBehindAppBar: true,
        drawer: Drawer(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Container(
            color: scaffoldColor,
            child: Column(
              children: const [Header(), ButtonList()],
            ),
          ),
        ),
        body: Stack(
          // fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,

          children: [
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
  // late final textHeight;
  HomeAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 4,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      // title: const Text('CUI_TIMETABLE'),
      actions: [
        Padding(
          padding: EdgeInsets.all(Constants.defaultPadding * 2),
          child: DefaultTextStyle(
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
          ),
        )
      ],

      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Constants.defaultRadius * 2),
            bottomRight: Radius.circular(Constants.defaultRadius * 2)),
        child: Stack(
            // fit: StackFit.expand,
            clipBehavior: Clip.none,
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
                ),
                height: double.infinity,
                child: Center(
                  child: Text(
                    'CUI TIMETABLE',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize! +
                                4.0),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

final List<String> imgList = [
  'https://sahiwal.comsats.edu.pk/slides/pcl_sp22.jpg',
  // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  // 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

/// Body of Home Screen.
class HomeBody extends GetView<HomeController> {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only(
            top: Constants.homeOverlaySize * Constants.defaultPadding,
            right: Constants.defaultPadding,
            left: Constants.defaultPadding,
            bottom: 0),
        sliver: SliverFillRemaining(
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  children: [
                    Obx(
                      () => controller.newUpdate.value
                          ? Padding(
                              padding: EdgeInsets.only(
                                  bottom: Constants.defaultPadding),
                              child: Card(
                                  // color: widgetColor,
                                  elevation: Constants.defaultElevation,
                                  shadowColor: shadowColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              Constants.defaultRadius))),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Constants.defaultRadius)),
                                        gradient: LinearGradient(
                                          colors: successGradient,
                                        )),
                                    child: ListTile(
                                      title: Text('Update Available! ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                      trailing: ElevatedButton(
                                        child: Text('Sync Now',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge),
                                        onPressed: () async {
                                          Get.toNamed(Routes.SYNC);
                                        },
                                      ),
                                      // subtitle: Text('Click here to Update',
                                      //     style: Theme.of(context).textTheme.bodyMedium),
                                    ),
                                  )),
                            )
                          : const SizedBox(),
                    ),

                    // StreamBuilder<List<String>>(
                    //   stream: controller.getCarouselStream(),
                    //   // initialData: initialData,
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<List<String>> snapshot) {
                    //     if (snapshot.hasData) {
                    //       return Padding(
                    //         padding:
                    //             EdgeInsets.all(Constants.defaultPadding / 2),
                    //         child: CarouselSlider(
                    //           options: CarouselOptions(
                    //               autoPlay: true,
                    //               clipBehavior: Clip.antiAlias,
                    //               viewportFraction: 1,
                    //               // padEnds: false,
                    //               // pageSnapping: true,

                    //               enlargeCenterPage: true,
                    //               autoPlayAnimationDuration:
                    //                   const Duration(seconds: 3),
                    //               autoPlayInterval: const Duration(seconds: 5),
                    //               scrollPhysics: BouncingScrollPhysics(),
                    //               height:
                    //                   MediaQuery.of(context).size.height / 6),
                    //           items: snapshot.data!.map((e) {
                    //             print(snapshot.data.runtimeType);
                    //             return Stack(
                    //               children: [
                    //                 Container(
                    //                     width:
                    //                         MediaQuery.of(context).size.width,
                    //                     margin: EdgeInsets.symmetric(
                    //                         horizontal: 2.0),
                    //                     decoration: BoxDecoration(
                    //                       // boxShadow: [
                    //                       //   BoxShadow(color: Colors.black)
                    //                       // ],
                    //                       color: widgetColor,
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(
                    //                               Constants.defaultRadius)),
                    //                     ),
                    //                     child: ClipRRect(
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(
                    //                               Constants.defaultRadius)),
                    //                       child: CachedNetworkImage(
                    //                         imageUrl: e,
                    //                         fit: BoxFit.cover,
                    //                         placeholder: (context, string) {
                    //                           return const SpinKitFadingCircle(
                    //                             color: primaryColor,
                    //                           );
                    //                         },
                    //                       ),
                    //                     )),
                    //                 Positioned(
                    //                     // alignment: Alignment.center,
                    //                     left: 10,
                    //                     top: 10,
                    //                     child: Container(
                    //                         width: 50,
                    //                         height: 40,
                    //                         color: Colors.yellow,
                    //                         child: Text('My Name IS'))),
                    //               ],
                    //             );
                    //           }).toList(),
                    //         ),
                    //       );
                    //     }

                    //     return const SpinKitFadingCircle(
                    //       color: primaryColor,
                    //     );
                    //   },
                    // ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: Constants.defaultPadding),
                            child: Row(
                              children: [
                                Text('Latest News',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.w900)),
                              ],
                            ),
                          ),
                        ]),
                    StreamBuilder(
                      stream: controller.getNewsStream(),
                      // initialData: initialData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return const Text(
                                'Connect to the Internet to fetch News...');
                          }

                          return Expanded(
                            child: ListView.builder(
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
                            ),
                          );
                        }
                        return Obx(() => Column(
                              children: [
                                const SpinKitFadingCircle(
                                  color: primaryColor,
                                ),
                                controller.internet.value
                                    ? Text(
                                        'Fetching News From Internet',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      )
                                    : Text(
                                        'Fetching News From Cache',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      )
                              ],
                            ));
                      },
                    ),
                  ],
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
      padding: EdgeInsets.all(Constants.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                Get.toNamed(Routes.PORTALS);
              },
              child: Padding(
                padding: EdgeInsets.all(Constants.defaultPadding),
                child: Text(
                  'Sign in',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
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
        top: MediaQuery.of(context).size.height / Constants.homeOverlaySize,
        right: 10,
        left: 10,
        child: Card(
          color: widgetColor,
          elevation: Constants.defaultElevation,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(Constants.defaultRadius))),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding,
                vertical: Constants.defaultPadding * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: shadowColor,
                  onTap: () {
                    Get.toNamed(Routes.TIMETABLE);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding),
                    child: Column(
                      children: [
                        ImageIcon(
                          AssetImage('assets/home/timetable.png'),
                          size: Constants.iconSize,
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
                ),
                Container(
                  height: 40,
                  width: 2,
                  color: Colors.grey,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: shadowColor,
                  onTap: () {
                    Get.toNamed(Routes.FREEROOMS);
                    // GetXUtilities.snackbar(
                    //     title: 'In Working!',
                    //     message: 'This Module is still in Development Phase',
                    //     gradient: primaryGradient);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding),
                    child: Column(
                      children: [
                        ImageIcon(
                          AssetImage('assets/home/room.png'),
                          size: Constants.iconSize,
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
                ),
                Container(
                  height: 40,
                  width: 2,
                  color: Colors.grey,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: shadowColor,
                  onTap: () {
                    Get.toNamed(Routes.DATESHEET);
                    // GetXUtilities.snackbar(
                    //     title: 'In Working!',
                    //     message: 'This Module is still in Development Phase',
                    //     gradient: primaryGradient);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding),
                    child: Column(
                      children: [
                        ImageIcon(
                          AssetImage('assets/home/datesheet.png'),
                          size: Constants.iconSize,
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
                ),
              ],
            ),
          ),
        ));
  }
}
