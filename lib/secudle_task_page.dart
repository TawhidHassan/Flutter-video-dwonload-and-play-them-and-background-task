import 'package:flutter/material.dart';

class Secudletask extends StatefulWidget {
  const Secudletask({Key? key}) : super(key: key);

  @override
  _SecudletaskState createState() => _SecudletaskState();
}

class _SecudletaskState extends State<Secudletask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Secudle Task"),
      ),
    );
  }
}
