import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../constants/server_fields.dart';
import '../../constants/uri_constants.dart';
import '../../helpers/storage.dart';
import '../constants/input_constants.dart';
import 'input_manager.dart';
import 'parent_model.dart';

class RegisterModel extends ParentModel {
  RegisterModel();

  final Map<String, String> _headers = <String, String>{HttpHeaders.acceptHeader: 'application/json'};

  final TextInputManager emailManager = TextInputManager(
    '',
    labelText: InputConstants.email,
    keyboardType: TextInputType.emailAddress,
    autofillHints: <String>[AutofillHints.email],
  );

  final TextInputManager passwordManager = TextInputManager(
    '',
    labelText: InputConstants.password,
    obscureText: true,
    autofillHints: <String>[AutofillHints.password],
  );


  Future<void> register() async =>  _registerRequest();

  @override
  bool validate() {
    cleanErrors();
    if (!emailManager.isEmpty && (!passwordManager.isEmpty)) {
      return true;
    } else {
      if (passwordManager.isEmpty) {
        passwordManager.addError();
        errorText = 'Password is empty!';
      }
      if (emailManager.isEmpty) {
        emailManager.addError();
        errorText = 'Login is empty!';
      }
      return false;
    }
  }

  Map<String, dynamic> get _toMap {
    return <String, dynamic>{
      ServerFields.email: emailManager.value,
      ServerFields.password: passwordManager.value,
    };
  }

  Future<void> _registerRequest() async {
    if (validate()) {
      final Response response = await post(
        UriConstants.registerUri,
        headers: _headers,
        body: _toMap,
      );

      if (response.statusCode == 200) {
        final String? accessToken = (jsonDecode(response.body) as Map<String, dynamic>)[ServerFields.token];
        if (accessToken != null) {
          SecureStorage.setToken(accessToken);
          // await context.read<UIStateManager>().login(context);
          return;
        }
      } else {
        final String? error = (jsonDecode(response.body) as Map<String, dynamic>)[ServerFields.message];
        errorText = error != null && error.isNotEmpty ? error : 'Invalid request';
      }
    }
    // popupNotificationManager.addNotification(buildResponse(isLogin: true));
  }


  @override
  void cleanErrors() {
    errorText = '';
    emailManager.removeError();
    passwordManager.removeError();
  }

  void cleanAllInputs() {
    emailManager.clean();
    passwordManager.clean();
  }
}
