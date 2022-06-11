// ignore_for_file: must_call_super

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class StudentPortal extends StatefulWidget {
  StudentPortal({Key? key}) : super(key: key);

  @override
  State<StudentPortal> createState() => _StudentPortalState();
}

class _StudentPortalState extends State<StudentPortal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        key: _key,
        initialUrl: 'https://swl-cms.comsats.edu.pk:8082/',
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: gestureRecognizers,
        zoomEnabled: true,
        onPageFinished: (value) {},
      ),
    );
  }
}

class TeacherPortal extends StatefulWidget {
  TeacherPortal({Key? key}) : super(key: key);

  @override
  State<TeacherPortal> createState() => _TeacherPortalState();
}

class _TeacherPortalState extends State<TeacherPortal>
    with AutomaticKeepAliveClientMixin {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        key: _key,
        initialUrl:
            'https://faculty.comsats.edu.pk/Home/login?returnUrl=https://faculty.comsats.edu.pk/',
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: gestureRecognizers,
        zoomEnabled: true,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
