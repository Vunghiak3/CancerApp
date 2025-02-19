import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ResultPage extends StatefulWidget {
  final File image;
  final String cancer;

  const ResultPage({super.key, required this.image, required this.cancer});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late File _image;
  late String _cancer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = widget.image;
    _cancer = _cancer;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _cancer
        ),
      ),
      body: Column(
        children: [
          Image.file(_image),
          Text(_cancer)
        ],
      ),
    );
  }
}
