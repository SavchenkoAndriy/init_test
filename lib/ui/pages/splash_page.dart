import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: Colors.blue.withOpacity(0.1),
      child: const Text('SplashPage', style: TextStyle(fontSize: 25, color: Colors.black)),
    );
  }
}
