import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';
import '../../../widgets/global_widgets.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_widgets.dart';

class HomeView2 extends GetView<HomeController> {
  HomeView2({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _key,
      backgroundColor: textFieldColor,
      drawer: Drawer(
        width: width / 1.5,
        child: Container(
          color: scaffoldColor,
          child: Column(
            children: const [Header(), ButtonList()],
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.all(Constants.defaultPadding * 2),
                child: const TypeWriterText(),
              )
            ],
            // shape: ContinuousRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //         // bottomLeft: Radius.circular(30),
            //         bottomRight: Radius.circular(Constants.defaultRadius * 20))),
            // automaticallyImplyLeading: true,
            leading: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                //  hoverColor: Colors.tra

                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ImageIcon(
                    const AssetImage('assets/drawer/menu.png'),
                    size: Constants.iconSize,
                  ),
                )),
            // actions: [Icon(Icons.menu)],
            expandedHeight: height * 0.25,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(
                  // bottomLeft: Radius.circular(Constants.defaultRadius * 2),
                  bottomRight: Radius.circular(Constants.defaultRadius * 6)),
              child: Stack(
                  // fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  // alignment: Alignment.center,
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
                          style: textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .fontSize! +
                                  4.0),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: 20,
                    //   bottom: 30,
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     // mainAxisAlignment: MainAxisAlignment.,
                    //     children: [
                    //       Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.all(
                    //             Radius.circular(Constants.defaultRadius),
                    //           ),
                    //           gradient: const LinearGradient(
                    //             end: Alignment.bottomRight,
                    //             colors: [
                    //               // secondaryColor,
                    //               successColor,
                    //               successColor2,
                    //             ],
                    //           ),
                    //         ),
                    //         // color: successColor,
                    //         width: Constants.defaultPadding / 2,
                    //         height: MediaQuery.of(context).size.height *
                    //             0.30 *
                    //             0.12,
                    //       ),
                    //       kWidth,
                    //       StreamBuilder(
                    //         stream: controller.getNewsStream(),
                    //         // initialData: initialData,
                    //         builder:
                    //             (BuildContext context, AsyncSnapshot snapshot) {
                    //           if (snapshot.hasData) {
                    //             if (snapshot.data.length == 0) {
                    //               return const Text(
                    //                   'Connect to the Internet to fetch News...');
                    //             }

                    //             return SizedBox(
                    //               // alignment: Alignment.centerLeft,
                    //               width:
                    //                   MediaQuery.of(context).size.width * 0.80,
                    //               height: MediaQuery.of(context).size.height *
                    //                   0.30 *
                    //                   0.12,
                    //               child: DefaultTextStyle(
                    //                 maxLines: 2,
                    //                 textAlign: TextAlign.start,
                    //                 style: textTheme.bodySmall!
                    //                     .copyWith(color: Colors.white),
                    //                 child: AnimatedTextKit(
                    //                   animatedTexts: [
                    //                     ...snapshot.data.map((e) {
                    //                       return RotateAnimatedText(
                    //                         e['title'],
                    //                         alignment: Alignment.centerLeft,
                    //                         transitionHeight: 0,
                    //                         // rotateOut: false,

                    //                         duration:
                    //                             const Duration(seconds: 5),
                    //                       );
                    //                     })
                    //                   ],
                    //                   onTap: () {
                    //                     Get.toNamed(
                    //                       Routes.NEWS,
                    //                       arguments: snapshot.data,
                    //                     );
                    //                   },
                    //                   repeatForever: true,
                    //                 ),
                    //               ),
                    //             );
                    //           }
                    //           return Text(
                    //             'Fetching news...',
                    //             style: textTheme.bodySmall!
                    //                 .copyWith(color: Colors.white),
                    //           );
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ]),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(Constants.defaultPadding),
            sliver: SliverFillRemaining(
              child: Column(
                // mainAxisAlignment: ,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeCarousel(),
                  const UpdateTile(),
                  Text(
                    'Events',
                    style: textTheme.titleMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  kHeight,
                  Padding(
                    padding:
                        EdgeInsets.only(left: Constants.defaultPadding / 2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTile(context,
                              title: "Sports",
                              iconLocation: "assets/home/timetable.png",
                              ontap: () async {
                            // final database = TimetableDatabase();
                            // database.createDatabase();

                            // final box =
                            //     await Hive.openBox(DBNames.timetableData);
                            // final result =
                            //     box.get(DBTimetableData.teachersData);
                            // print(result);
                            // var logger = Logger();
                            // logger.w("Here");

                            // final result =
                            //     box.get(DBTimetableData.studentsData);
                            // final a = result['fa21-bscve-b5'];
                            // final b = List<StudentTimetable>.from(a);
                            // debugPrint(b.runtimeType.toString());
                          }),
                          _buildTile(context,
                              title: "Meetups",
                              iconLocation: "assets/home/datesheet.png"),
                          _buildTile(context,
                              title: "Socities",
                              iconLocation: "assets/home/room.png"),
                          _buildTile(context, blank: true),
                        ]),
                  ),
                  kHeight,
                  kHeight,
                  Text(
                    'General',
                    style: textTheme.titleMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        kHeight,
                        Padding(
                          padding: EdgeInsets.only(
                              left: Constants.defaultPadding / 2),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTile(context,
                                    title: "Timetable",
                                    ontap: () => Get.toNamed(Routes.TIMETABLE),
                                    iconLocation: "assets/home/timetable.png"),
                                _buildTile(context,
                                    title: "Datesheet",
                                    ontap: () => Get.toNamed(Routes.DATESHEET),
                                    iconLocation: "assets/home/datesheet.png"),
                                _buildTile(context,
                                    title: "Freerooms",
                                    ontap: () => Get.toNamed(Routes.FREEROOMS),
                                    iconLocation: "assets/home/room.png"),
                                _buildTile(context,
                                    title: "Comparision",
                                    iconLocation: "assets/home/menu.png"),
                              ]),
                        ),
                        kHeight,
                        kHeight,
                        Padding(
                          padding: EdgeInsets.only(
                              left: Constants.defaultPadding / 2),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildTile(context,
                                    title: "Booking",
                                    iconLocation: "assets/drawer/bookings.png"),
                                _buildTile(context,
                                    title: "Feedback",
                                    iconLocation: "assets/drawer/feedback.png"),
                                _buildTile(context, blank: true),
                                _buildTile(context, blank: true),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  const HomeBottomWidget()
                ],
              ),
            ),
          )
        ],
      ),
    );
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
                    color: shadowColor,
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

                    // margin: EdgeInsets.all(Constants.defaultPadding),
                  ),
          ],
        ),
      ),
    );
  }
}
