import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';
import '../../../../widgets/global_widgets.dart';
import '../controllers/booking_approval_controller.dart';

class BookingApprovalView extends GetView<BookingApprovalController> {
  const BookingApprovalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var height = MediaQuery.of(context).size.height / 4;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Booking Approval'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: successColor,
                child: Container(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Your request has been submitted, the response time depends upon the admin.',
                      style: textTheme.titleMedium!.copyWith(
                        // fontWeight: FontWeight.w900,
                        color: Colors.white,
                        // fontSize: textTheme.titleMedium!.fontSize! + 2,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(Constants.defaultPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome to booking',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: textTheme.titleMedium!.fontSize! + 2,
                        ),
                      ),
                      kHeight,
                      Text(
                        "Here you can book your makeup classes. all the makeup notifications are send to the admin and every activity is monitored by the higher authority.\n\nTo start booking, make sure you choose your correct name from the following list, if you don’t find your name in the list, contact with your admin. after selecting your name, request for approval and then you are ready to go. ",
                        style: textTheme.bodyMedium,
                        textAlign: TextAlign.justify,
                      ),
                      kHeight,
                      kHeight,
                      TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                          controller: controller.textController,
                          onChanged: (value) {
                            controller.filteredList.value = controller.teachers
                                .where((element) => element
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();

                            if (value.isEmpty) {
                              controller.listVisible.value = false;
                            } else if (controller.filteredList
                                    .contains(value) &&
                                controller.filteredList.length == 1) {
                              controller.listVisible.value = false;
                            } else {
                              controller.listVisible.value = true;
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.textController.clear();
                                  controller.filteredList.value = [];
                                },
                                icon: const Icon(Icons.cancel,
                                    color: primaryColor)),
                            fillColor: selectionColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Constants.defaultRadius),
                                borderSide:
                                    const BorderSide(color: primaryColor)),
                          )),
                      SizedBox(
                        height: Constants.defaultPadding / 2,
                      ),
                      Obx(() => controller.filteredList.isEmpty
                          ? const SizedBox()
                          : ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: double.infinity,
                                maxHeight:
                                    controller.listVisible.value ? height : 0,
                              ),
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.filteredList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      controller.textController.text =
                                          controller.filteredList[index];
                                      controller.textController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: controller
                                                      .textController
                                                      .text
                                                      .length));
                                      controller.listVisible.value = false;
                                    },
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    leading: Text(
                                      controller.filteredList[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: primaryColor,
                                    height: 2,
                                    // indent: 15,
                                    // endIndent: 15,
                                  );
                                },
                              ),
                            ))
                    ],
                  ),
                ),
              ),
              kHeight,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  onPressed: () async {
                    controller.postApproval(
                      name: controller.textController.text,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Constants.defaultPadding),
                    child: Padding(
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      child: Text('Request for Approval',
                          style: Theme.of(context).textTheme.labelLarge
                          // .copyWith(fontSize: 16),
                          ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
