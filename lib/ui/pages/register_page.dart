import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/page_route.dart';
import '../../helpers/utils.dart';
import '../../models/input_manager.dart';
import '../../models/register_model.dart';
import '../../state/navigation_state.dart';
import '../components/scroll_without_glow.dart';
import '../components/submit_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({required this.registerModel, Key? key}) : super(key: key);

  final RegisterModel registerModel;

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
        children: <Widget>[
          ...<TextInputManager>[
            registerModel.emailManager,
            registerModel.passwordManager,
          ].map((TextInputManager manager) {
            return buildInputField(manager: manager, height: 30);
          }).toList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SubmitButton(
                onSubmit: () async =>
                    context.read<NavigationState>().navigatePushReplaceAll(CustomPageRoute.homeWrapperRoute),
                // onSubmit: registerModel.register,
                text: 'Register',
                lightBorder: true,
              ),
            ],
          ),
          const SizedBox(height: 30),
          SubmitButton(
            onSubmit: () async =>
                context.read<NavigationState>().navigatePop(),
            // onSubmit: registerModel.register,
            text: 'Back',
            lightBorder: true,
          ),
        ],
      ),
    );
  }
}
