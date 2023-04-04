import 'package:cui_timetable/app/modules/adminPanel/adminFeedback/views/reported_view.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_feedback_controller.dart';

class AdminFeedbackView extends GetView<AdminFeedbackController> {
  const AdminFeedbackView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reportes/Feedbacks'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(child: AdminReportedView()),
            // replyField(),

          ],
        ));
  }

  Padding replyField() {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                              hintText: "Type response here",
                              border: InputBorder.none),
                        ),
                      ),
                      kWidth,
                      Container(
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.send_rounded)))
                    ],
                  ),
                ),
              ),
            );
  }
}
