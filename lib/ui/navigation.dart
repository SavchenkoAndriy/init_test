import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/navigation_state.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: context.read<NavigationState>().willPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF6592B9),
                Color(0xFF125998),
                Color(0xFF04447B),
              ],
              stops: <double>[1, 0.5, 0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: <Widget>[
              ...context.watch<NavigationState>().buildActivePages,
              ...context.watch<NavigationState>().popup.values,
              ...context.watch<NavigationState>().toast.values,
            ],
          ),
        ),
      ),
    );
  }
}
