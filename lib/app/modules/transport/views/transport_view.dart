import 'package:flutter/material.dart';

class TransportView extends StatefulWidget {
  const TransportView({Key? key}) : super(key: key);

  @override
  State<TransportView> createState() => _TransportViewState();
}

class _TransportViewState extends State<TransportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TransportView'),
          centerTitle: true,
        ),
        body: const SafeArea(child: Text("Text")));
  }
}
