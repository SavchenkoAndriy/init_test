import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/navigation_state.dart';
import '../../../ui/components/popup.dart';
import '../../components/submit_button.dart';

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  Future<void> _show2(BuildContext context) async {
    context.read<NavigationState>().showPopup(
      config: PopupConfig(
        child: Column(
          children: <Widget>[
            const Text('show 2'),
            SubmitButton(
              onSubmit: () async => context.read<NavigationState>().showPopup(),
              text: 'Show popup 2',
              lightBorder: true,
            ),
          ],
        ),
        key: 'show 2',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 200),
          const Text('Page 4', style: TextStyle(fontSize: 25, color: Colors.black)),
          const SizedBox(height: 200),
          SubmitButton(
            onSubmit: () async => _show2(context),
            text: 'Show popup',
            lightBorder: true,
          ),
        ],
      ),
    );
  }
}
