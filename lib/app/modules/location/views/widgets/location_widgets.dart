import 'package:cui_timetable/app/widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_constants.dart';

class LocationDetailsTile extends StatelessWidget {
  final String room;
  final String location;
  final String dept;

  const LocationDetailsTile({
    Key? key,
    required this.room,
    required this.location,
    required this.dept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Container(
        padding: EdgeInsets.all(Constants.defaultPadding / 2),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.defaultRadius)),
            color: widgetColor),
        child: Padding(
          padding: EdgeInsets.all(Constants.defaultPadding),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dept,
                      style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    kHeight,
                    Text(
                      "Dept",
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  color: primaryColor,
                  thickness: 3.0,
                  // indent: 4,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Constants.defaultPadding / 2,
                        right: Constants.defaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: selectionColor,
                              borderRadius: BorderRadius.circular(
                                  Constants.defaultRadius)),
                          child: Padding(
                            padding: EdgeInsets.all(Constants.defaultPadding),
                            child: Text(
                              room,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize! +
                                          2),
                            ),
                          ),
                        ),
                        kHeight,
                        Row(
                          children: [
                            const ImageIcon(
                              AssetImage('assets/timetable/location.png'),
                              color: primaryColor,
                            ),
                            const SizedBox(width: 5),
                            Text(location,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
