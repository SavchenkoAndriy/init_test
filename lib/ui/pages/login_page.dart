import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/page_route.dart';
import '../../helpers/utils.dart';
import '../../models/input_manager.dart';
import '../../models/login_model.dart';
import '../../state/navigation_state.dart';
import '../components/scroll_without_glow.dart';
import '../components/submit_button.dart';
import '../components/tappable_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({required this.loginModel, Key? key}) : super(key: key);

  final LoginModel loginModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.2),
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ScrollWithoutGlow(
        withMinSize: false,
        child: _buildForm(context: context),
      ),
    );
  }

  Widget _buildForm({required BuildContext context}) {
    return AutofillGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ...<TextInputManager>[
            loginModel.emailManager,
            loginModel.passwordManager,
          ].map((TextInputManager manager) {
            return buildInputField(manager: manager, height: 30);
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SubmitButton(
                onSubmit: () async =>
                    context.read<NavigationState>().navigatePushReplaceAll(CustomPageRoute.homeWrapperRoute),
                // onSubmit: loginModel.login,
                text: 'Sign in',
                lightBorder: true,
              ),
            ],
          ),
          const SizedBox(height: 30),
          TappableText(
            text: 'Go to registration',
            color: Colors.white,
            horizontalPadding: 15,
            fontSize: 17,
            onTap: () async => context.read<NavigationState>().navigatePush(CustomPageRoute.registerRoute),
          ),
        ],
      ),
    );
  }
}
