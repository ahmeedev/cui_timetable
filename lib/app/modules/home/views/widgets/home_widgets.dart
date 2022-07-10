import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/modules/home/views/widgets/carousel_screen.dart';
import 'package:cui_timetable/app/modules/settings/controllers/settings_controller.dart';
import 'package:cui_timetable/app/routes/app_pages.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

/// AppBar for the Home Screen.
class HomeAppBar extends StatelessWidget {
  // late final textHeight;
  const HomeAppBar({
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
                                        gradient: const LinearGradient(
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
                    Obx(
                      () =>
                          Get.find<SettingsController>().carousel.value == true
                              ? const HomeCarousel()
                              : const SizedBox(),
                    ),
                    Obx(
                      () => Get.find<SettingsController>().latestNews.value ==
                              true
                          ? const HomeNews()
                          : const SizedBox(),
                    ),
                    // const HomeNews()
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

/// Carousel for home screen
class HomeCarousel extends GetView<HomeController> {
  const HomeCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.internet.value
        ? StreamBuilder<List<Map<String, String>>>(
            stream: controller.getCarouselStream(),
            // initialData: initialData,
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, String>>> snapshot) {
              if (snapshot.hasError) {}

              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.all(Constants.defaultPadding / 2),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        clipBehavior: Clip.antiAlias,
                        viewportFraction: 1,
                        // padEnds: false,
                        // pageSnapping: true,

                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: const Duration(seconds: 3),
                        autoPlayInterval: const Duration(seconds: 5),
                        scrollPhysics: const BouncingScrollPhysics(),
                        height: MediaQuery.of(context).size.height / 6),
                    items: snapshot.data!.map((e) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const CarouselImageDetails(),
                                arguments: [
                                  'Image Detail',
                                  e["img"]!,
                                  e["title"]!
                                ],
                              );
                              // duration: const Duration(microseconds: 0));
                            },
                            // child: Hero(
                            // tag: 'img',
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                // margin: EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(color: Colors.black)
                                  // ],
                                  color: widgetColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Constants.defaultRadius)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Constants.defaultRadius)),
                                  child: CachedNetworkImage(
                                    imageUrl: e["img"]!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, string) {
                                      return const SpinKitFadingCircle(
                                        color: primaryColor,
                                      );
                                    },
                                  ),
                                )),
                          ),
                          // ),
                          e["title"]!.isEmpty
                              ? const SizedBox()
                              : Positioned(
                                  // alignment: Alignment.center,
                                  // left: 2,
                                  // top: 10,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            end: Alignment.bottomRight,
                                            colors: [
                                              // secondaryColor,
                                              primaryColor,
                                              forGradient,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(
                                                Constants.defaultRadius),
                                            bottomLeft: Radius.circular(
                                                Constants.defaultRadius),
                                          )
                                          // border:
                                          //     Border.all(width: 3, color: Colors.white),
                                          ),

                                      // color: primaryColor,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Constants.defaultPadding,
                                            vertical:
                                                Constants.defaultPadding / 2),
                                        child: FittedBox(
                                          child: Text(
                                            e["title"]!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ))),
                        ],
                      );
                    }).toList(),
                  ),
                );
              }

              return const SpinKitFadingCircle(
                color: primaryColor,
              );
            },
          )
        : const SizedBox());
  }
}

/// News for Home Screen
class HomeNews extends GetView<HomeController> {
  const HomeNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: EdgeInsets.only(
                top: Constants.defaultPadding / 2,
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
                return const Text('Connect to the Internet to fetch News...');
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
                          // expanded: index == 0 ? true : false,  //! true for initial expanded
                          expanded: false,
                          title: snapshot.data[index]['title'],
                          description: snapshot.data[index]['description']),
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
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        : Text(
                            'Fetching News From Cache',
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                  ],
                ));
          },
        ),
      ]),
    );
  }

  Card buildNews(context,
      {required String title,
      required String description,
      required bool expanded}) {
    return Card(
        color: widgetColor,
        elevation: Constants.defaultElevation,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.defaultRadius))),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius)),
          child: ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              initiallyExpanded: expanded,
              backgroundColor: widgetColor,
              iconColor: primaryColor,

              // trailing: const Icon(Icons.motion_photos_on_rounded),

              tilePadding:
                  EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
              childrenPadding: EdgeInsets.fromLTRB(Constants.defaultPadding, 0,
                  Constants.defaultPadding, Constants.defaultPadding + 15),
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              children: [
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.ltr,
                )
              ]),
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
                          const AssetImage('assets/home/timetable.png'),
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
                          const AssetImage('assets/home/room.png'),
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
                          const AssetImage('assets/home/datesheet.png'),
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
