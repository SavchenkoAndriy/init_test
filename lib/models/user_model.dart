import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants/input_constants.dart';
import '../constants/server_fields.dart';
import '../constants/uri_constants.dart';
import '../models/parent_model.dart';
import 'input_manager.dart';

class UserModel extends ParentModel {
  UserModel();

  final Uri _uri = UriConstants.userUri;
  late int id;

  Future<void> init(BuildContext context) async {
    await setToken();
    await _getProfileRequest(context);
  }

  final TextInputManager emailManager = TextInputManager(
    '',
    labelText: InputConstants.email,
    autofillHints: <String>[AutofillHints.email],
    keyboardType: TextInputType.emailAddress,
    borderColor: Colors.grey,
  );
  final TextInputManager phoneManager = TextInputManager(
    '',
    labelText: InputConstants.phone,
    autofillHints: <String>[AutofillHints.telephoneNumber],
    keyboardType: TextInputType.phone,
    borderColor: Colors.grey,
  );
  final TextInputManager firstNameManager = TextInputManager(
    '',
    labelText: InputConstants.firstName,
    autofillHints: <String>[AutofillHints.givenName],
    borderColor: Colors.grey,
    textCapitalization: TextCapitalization.sentences,
  );
  final TextInputManager lastNameManager = TextInputManager(
    '',
    labelText: InputConstants.lastName,
    autofillHints: <String>[AutofillHints.familyName],
    borderColor: Colors.grey,
    textCapitalization: TextCapitalization.sentences,
  );

  Map<String, String> get _headers {
    return <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  @override
  bool validate() {
    cleanErrors();
    if (!emailManager.isEmpty &&
        !phoneManager.isEmpty &&
        !firstNameManager.isEmpty &&
        !lastNameManager.isEmpty) {
      return true;
    } else {
      if (emailManager.isEmpty) {
        emailManager.addError();
      }
      if (phoneManager.isEmpty) {
        phoneManager.addError();
      }
      if (lastNameManager.isEmpty) {
        lastNameManager.addError();
      }
      if (firstNameManager.isEmpty) {
        firstNameManager.addError();
      }
      errorText = 'Please fill out all of the fields marked in red!';
      return false;
    }
  }

  Map<String, dynamic> get _toMapProfile {
    return <String, dynamic>{
      ServerFields.email: emailManager.value,
      ServerFields.phone: phoneManager.value,
      ServerFields.firstName: firstNameManager.value,
      ServerFields.lastName: lastNameManager.value,
    };
  }

  void _setUserData(Map<String, dynamic> json) {
    id = json[ServerFields.id];
    emailManager.controller.text = json[ServerFields.email];
    phoneManager.controller.text = json[ServerFields.phone];
    firstNameManager.controller.text = json[ServerFields.firstName];
    lastNameManager.controller.text = json[ServerFields.lastName];
  }

  Future<void> _getProfileRequest(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    errorText = '';

    final Response response = await get(_uri, headers: _headers);

    if (response.statusCode == 200) {
      _setUserData(jsonDecode(response.body));
    } else {
      errorText = 'Invalid request';
    }
  }

  Future<void> updateProfileRequest(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    errorText = '';
    if (validate()) {
      final Response response = await post(
        _uri,
        headers: _headers,
        body: _toMapProfile,
      );

      if (response.statusCode != 200) {
        errorText = 'Invalid request';
      }
    }
  }

  @override
  void cleanErrors() {
    errorText = '';
    emailManager.removeError();
    phoneManager.removeError();
    firstNameManager.removeError();
    lastNameManager.removeError();
  }

  void cleanAllInputs() {
    emailManager.clean();
    phoneManager.clean();
    firstNameManager.clean();
    lastNameManager.clean();
  }
}
