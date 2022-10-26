import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2,
      alignment: Alignment.center,
      color: Colors.white,
      child: const Text('Page 1(long)', style: TextStyle(fontSize: 25, color: Colors.black)),
    );
  }
}
