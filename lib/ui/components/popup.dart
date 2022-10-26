import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/navigation_state.dart';
import 'ink_well_without_glow.dart';

class Popup extends StatelessWidget {
  const Popup({required this.config, Key? key}) : super(key: key);

  final PopupConfig config;

  @override
  Widget build(BuildContext context) {
    return InkWellWithoutGlow(
      onTap: config.close ?? () => context.read<NavigationState>().removePopup(config.key),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.5),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                alignment: Alignment.center,
                width: config.width,
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40, minWidth: 300),
                padding: config.padding,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 20),
                  ],
                ),
                child: config.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopupConfig {
  PopupConfig({
    required this.child,
    required this.key,
    this.width = 500,
    this.padding = const EdgeInsets.fromLTRB(20, 20, 20, 20),
    this.close,
  });

  final Widget child;
  final String key;
  final double width;
  final EdgeInsets padding;
  final void Function()? close;
}
