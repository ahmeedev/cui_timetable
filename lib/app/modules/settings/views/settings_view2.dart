import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cui_timetable/app/modules/home/controllers/home_controller.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:cui_timetable/app/theme/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soul/flutter_soul.dart' as flutterSoul;
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../../routes/app_pages.dart';

class SettingsView2 extends StatelessWidget {
  const SettingsView2({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [Text("settings")],
    );
  }
}
