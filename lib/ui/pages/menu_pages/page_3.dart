import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/navigation_state.dart';
import '../../components/submit_button.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          const Text('Page 3', style: TextStyle(fontSize: 25, color: Colors.black)),
          const SizedBox(height: 200),
          SubmitButton(
            onSubmit: () async => context.read<NavigationState>().showToast(),
            text: 'Show toast',
            lightBorder: true,
          ),
        ],
      ),
    );
  }
}
