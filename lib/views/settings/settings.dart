import 'package:cui_timetable/style.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: const [
            Card(
              color: widgetColor,
              shadowColor: shadowColor,
              elevation: defaultElevation,
              child: ListTile(
                title: Text('Dark Mode'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
