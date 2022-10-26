import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/page_route.dart';
import '../../../state/navigation_state.dart';
import '../../components/submit_button.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.red.withOpacity(0.3),
      child: Column(
        children: <Widget>[
          const Text('Page 2', style: TextStyle(fontSize: 25, color: Colors.black)),
          const SizedBox(height: 200),
          SubmitButton(
            onSubmit: () async =>
                context.read<NavigationState>().navigatePush(CustomPageRoute.testRoute),
            text: 'Go to test page',
            lightBorder: true,
          ),
        ],
      ),
    );
  }
}
