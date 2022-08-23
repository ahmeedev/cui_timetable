import 'package:flutter/material.dart';

import '../../../../../theme/app_colors.dart';
import '../../../../../theme/app_constants.dart';

class LectureDetailsTile extends StatelessWidget {
  final dynamic time;

  const LectureDetailsTile({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widgetColor,
      elevation: Constants.defaultElevation,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.defaultRadius))),
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
                    time.toString().split('-')[0],
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Text('|'),
                  const Text('|'),
                  Text(
                    time.toString().split('-')[1],
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const VerticalDivider(
                color: primaryColor,
                thickness: 2.0,
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
                      Padding(
                        padding: EdgeInsets.all(Constants.defaultPadding),
                        child: Text(
                          'Information Security',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: Constants.defaultPadding),
                        child: Text(
                          'Mr. Umar Farooq',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Set Remainder"),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
