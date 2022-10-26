import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2,
      alignment: Alignment.center,
      color: Colors.white,
      child: const Text('Test Page', style: TextStyle(fontSize: 25, color: Colors.black)),
    );
  }
}
