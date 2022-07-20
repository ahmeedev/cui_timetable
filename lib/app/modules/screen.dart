import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';
import '../widgets/global_widgets.dart';
import 'home/views/widgets/home_drawer.dart';
import 'home/views/widgets/home_widgets.dart';

class Screen extends StatelessWidget {
  Screen({Key? key}) : super(key: key);
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
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.all(Constants.defaultPadding * 2),
                child: DefaultTextStyle(
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
                child: const ImageIcon(AssetImage('assets/drawer/menu.png'))),
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
                    Positioned(
                      left: 20,
                      bottom: 30,
                      child: InkWell(
                        onTap: () {
                          Get.to(const Scaffold());
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  end: Alignment.bottomRight,
                                  colors: [
                                    // secondaryColor,
                                    successColor,
                                    successColor2,
                                  ],
                                ),
                              ),
                              // color: successColor,
                              width: 5,
                              height: MediaQuery.of(context).size.height *
                                  0.30 *
                                  0.12,
                            ),
                            kWidth,
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: AutoSizeText(
                                  "Notice for the Accused Students of Unfair Means Cases, Terminal Exams SP'22 Semester ",
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodySmall!
                                      .copyWith(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    )
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
                              iconLocation: "assets/home/timetable.png"),
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
                  kHeight,
                  Padding(
                    padding:
                        EdgeInsets.only(left: Constants.defaultPadding / 2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTile(context,
                              title: "Timetable",
                              iconLocation: "assets/home/timetable.png"),
                          _buildTile(context,
                              title: "Datesheet",
                              iconLocation: "assets/home/datesheet.png"),
                          _buildTile(context,
                              title: "Freerooms",
                              iconLocation: "assets/home/room.png"),
                          _buildTile(context,
                              title: "Comparision",
                              iconLocation: "assets/home/menu.png"),
                        ]),
                  ),
                  kHeight,
                  kHeight,
                  Padding(
                    padding:
                        EdgeInsets.only(left: Constants.defaultPadding / 2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTile(context,
                              title: "Timetable",
                              iconLocation: "assets/home/timetable.png"),
                          _buildTile(context,
                              title: "Datesheet",
                              iconLocation: "assets/home/datesheet.png"),
                          _buildTile(context, blank: true),
                          _buildTile(context, blank: true),
                        ]),
                  ),
                  const Spacer(),
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
      {String title = "", String iconLocation = "", blank = false}) {
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
                      horizontal: Constants.defaultPadding,
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
                      onTap: () {},
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
                              size: Constants.iconSize,
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
