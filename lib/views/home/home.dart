import 'package:cui_timetable/controllers/developer/developer_controller.dart';
import 'package:cui_timetable/controllers/firebase/firebase_controller.dart';
import 'package:cui_timetable/views/freerooms/freerooms.dart';
import 'package:cui_timetable/views/home/drawer/drawer.dart';
import 'package:cui_timetable/views/timetable/timetable_main/timetable_main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          children: const [
            CustomScrollView(
              slivers: [
                HomeAppBar(),
                HomeBody(),
                // // * For Testing purpose  //
                HomeTestingWidget(),
                // // * ==================== //
                HomeBottomWidget(),
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

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 4,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text('CUI_TIMETABLE'),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade400,
              image: const DecorationImage(
                  image: AssetImage('assets/home/home.jpg'), fit: BoxFit.fill)),
        ),
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
      padding: const EdgeInsets.only(top: 90, right: 8.0, left: 8.0, bottom: 0),
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
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                      'hello gy zasdfasdf asdf as df asd f sadf sad fas df asd f asdf;asdfjals;k jflk;as djkl;jasiwejrlikaj'),
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
        top: MediaQuery.of(context).size.height / 4.2,
        right: 20,
        left: 20,
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
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => Timetable());
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text('Timetable')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => FreeRooms());
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.room,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text('Free rooms')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.to(FreeRooms());
                    Get.snackbar("No availabled", "in development phase",
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.date_range,
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text('Datesheet')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

//* Testing widget for the home screen.
class HomeTestingWidget extends StatelessWidget {
  const HomeTestingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        FutureBuilder(
          future: updateStatus(),
          builder: (context, snapshot) => Text("${snapshot.data}"),
        )
      ])),
    );
  }

  Future<String> updateStatus() async {
    final box = await Hive.openBox("update");
    return box.get("status").toString();
  }
}
