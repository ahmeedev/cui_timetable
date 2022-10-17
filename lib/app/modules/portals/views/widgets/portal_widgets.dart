// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:cui_timetable/app/data/database/database_constants.dart';
import 'package:cui_timetable/app/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore_for_file: must_call_super

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

  final UniqueKey _key = UniqueKey();
  var isLoading = true;
  late final _webViewController;
  late final Box box;
  final detailsMap = {"roll": '', "pass": ''};
  @override
  void initState() {
    super.initState();
    init() async {
      box = await Hive.openBox(DBNames.portals);
    }

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            key: _key,
            initialUrl: 'https://swl-cms.comsats.edu.pk:8082/',
            javascriptMode: JavascriptMode.unrestricted,
            gestureRecognizers: gestureRecognizers,
            zoomEnabled: true,
            onWebViewCreated: (WebViewController controller) async {
              _webViewController = controller;
            },
            javascriptChannels: {
              JavascriptChannel(
                  name: 'rollNo',
                  onMessageReceived: (message) async {
                    detailsMap["roll"] = message.message.toString().trim();
                  }),
              JavascriptChannel(
                  name: 'pass',
                  onMessageReceived: (message) async {
                    detailsMap["pass"] = message.message.toString();
                  }),
              JavascriptChannel(
                  name: 'login',
                  onMessageReceived: (message) async {
                    await box.put(DBPortals.studentData, detailsMap);
                  }),
            },
            onPageFinished: (value) async {
              // CookieManager().setCookie(WebViewCookie(name: name, value: value, domain: domain))
              setState(() {
                isLoading = false;
              });

              // change the background color
              _webViewController.evaluateJavascript("""
                document.body.style.backgroundColor = "#d4dfed";
                """);

              final result = await box.get(DBPortals.studentData,
                  defaultValue: {"roll": '', "pass": ''});

              _webViewController.evaluateJavascript(
                  """document.querySelector('#MaskedRegNo').value='${result['roll']}';
                  document.querySelector('#Password').value='${result['pass']}';""");

              _webViewController.evaluateJavascript(
                """
const element = document.querySelector("#MaskedRegNo");
element.addEventListener("input", () => {
window.rollNo.postMessage(document.querySelector("#MaskedRegNo").value);
                });
const element2 = document.querySelector("#Password");

element2.addEventListener("input", () => {
window.pass.postMessage(document.querySelector("#Password").value);
                });

const element3 = document.querySelector("#LoginSubmit");
element3.addEventListener("click", () => {
window.login.postMessage("store");
                });
                """,
              );
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Stack(),
        ],
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

  final UniqueKey _key = UniqueKey();

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
