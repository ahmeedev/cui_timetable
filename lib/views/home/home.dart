import 'package:cui_timetable/controllers/developer/developer_controller.dart';
import 'package:cui_timetable/controllers/firebase/firebase_controller.dart';
import 'package:cui_timetable/controllers/home/home_controller.dart';
import 'package:cui_timetable/style.dart';
import 'package:cui_timetable/views/freerooms/freerooms.dart';
import 'package:cui_timetable/views/home/drawer/drawer.dart';
import 'package:cui_timetable/views/timetable/timetable_main/timetable_main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
        // appBar: buildAppBar(context),
        drawer: Drawer(
          child: ListView(
            children: const [Header(), ButtonList()],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            CustomScrollView(
              slivers: [
                HomeAppBar(),
                const HomeBody(),
                const HomeBottomWidget(),
              ],
            ),
            HomeOverlay()
          ],
        ));
  }
}

/// AppBar for the Home Screen.
class HomeAppBar extends StatelessWidget {
  HomeAppBar({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 4,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      // title: const Text('CUI_TIMETABLE'),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  gradient: const LinearGradient(
                    colors: [primaryColor, secondaryColor],
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
                )),
              ),
              Positioned(
                right: 20,
                top: 50,
                height: 15,
                width: 15,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.orange, shape: BoxShape.circle)),
              ),
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
      padding: const EdgeInsets.only(top: 65, right: 8.0, left: 8.0, bottom: 0),
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        /// Building News row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Latest News',
                style: TextStyle(fontWeight: FontWeight.bold)),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  style: const TextStyle(color: Colors.blue),
                  text: "More>",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      var url = "http://sahiwal.comsats.edu.pk/";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
            ]))
          ],
        ),

        /// Building Card for news

        const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Card(
              elevation: 4,
              child: ListTile(
                horizontalTitleGap: 16,
                title: Text(
                  'Tilte',
                  // style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'hello gy zasdfasdf asdf as df asd f sadf sad fas df asd f asdf;asdfjals;k jflk;as djkl;jasiwejrlikaj',
                    // style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
            )),
      ])),
    );
  }
}

/// Bottom Widget for Home Screen.
class HomeBottomWidget extends StatelessWidget {
  const HomeBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        hasScrollBody: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('CU Online Portal',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Sign in to view details'),
                  ]),
              ElevatedButton(onPressed: () {}, child: const Text('Sign in')),
            ],
          ),
        ));
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
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0,
                  // spreadRadius: 1,
                  blurStyle: BlurStyle.outer)
            ],
            color: Colors.white,
          ),
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
                    Get.to(() => FreeRooms(), transition: Transition.zoom);
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
                    // Get.to(FreeRooms());
                    Get.snackbar("No availabled", "in development phase",
                        snackPosition: SnackPosition.BOTTOM);
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
