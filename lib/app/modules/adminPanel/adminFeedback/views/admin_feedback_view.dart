import 'package:cui_timetable/app/modules/adminPanel/adminFeedback/views/reported_view.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controllers/admin_feedback_controller.dart';

class AdminFeedbackView extends GetView<AdminFeedbackController> {
  const AdminFeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reportes/Feedbacks'),
          centerTitle: true,
          bottom: TabBar(
              indicatorPadding: EdgeInsets.all(Constants.defaultPadding / 3),
              indicatorWeight: 4,
              indicatorColor: shadowColor,
              tabs: [
                Tab(
                  child: Text(
                    "Not Responded",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Tab(
                  child: Text(
                    "Responded",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                
              ]),
        ),
        body:  TabBarView(
          children: [
            Column(
              children: [
                Expanded(child: AdminReportedView()),
                // replyField(),
              ],
            ),
            const Center(
              child: SpinKitDancingSquare(
                size: 50,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Padding replyField() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Card(
  //       child: Container(
  //         padding: EdgeInsets.all(Constants.defaultPadding),
  //         child: Row(
  //           children: [
  //             Flexible(
  //               child: TextFormField(
  //                 controller: TextEditingController(),
  //                 decoration: const InputDecoration(
  //                     hintText: "Type response here", border: InputBorder.none),
  //               ),
  //             ),
  //             kWidth,
  //             Container(
  //                 decoration: const BoxDecoration(
  //                     color: Colors.green,
  //                     borderRadius: BorderRadius.all(Radius.circular(10))),
  //                 child: IconButton(
  //                     onPressed: () {}, icon: const Icon(Icons.send_rounded)))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
