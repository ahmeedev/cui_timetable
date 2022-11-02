import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_constants.dart';

class BookingLog extends StatelessWidget {
  const BookingLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Card(
        child: ListTile(
          leading: FittedBox(
              fit: BoxFit.scaleDown,
              // child: SpinKitFadingCube(
              //   color: primaryColor,
              //   size: Constants.iconSize,
              // ),
              child: Icon(
                Icons.check_circle,
                color: successColor,
                size: Constants.iconSize,
              )),
          title: Text(
            "Your booking for FA19-BSE-7-A has been confirmed....",
            style: theme.textTheme.titleMedium!
                .copyWith(color: successColor, fontWeight: FontWeight.w900),
          ),
        ),
      ),
      Card(
        child: ListTile(
          leading: FittedBox(
              fit: BoxFit.scaleDown,
              // child: SpinKitFadingCube(
              //   color: primaryColor,
              //   size: Constants.iconSize,
              // ),
              child: Icon(
                Icons.cancel_rounded,
                color: errorColor1,
                size: Constants.iconSize,
              )),
          title: Text(
            "Your booking for FA19-BSE-7-A has been rejected....",
            style: theme.textTheme.titleMedium!
                .copyWith(color: errorColor1, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    ]).paddingAll(Constants.defaultPadding);
  }
}
