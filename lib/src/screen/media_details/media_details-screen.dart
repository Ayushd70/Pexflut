import 'package:flutter/material.dart';

class MediaDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, 'home');
          },
        ),
        title: Text('this is media_details screen'),
      ),
    );
  }
}