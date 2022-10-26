import 'package:flutter/material.dart';
import 'parent_model.dart';

enum PopupNotificationType { error, success }

class ResponseModel {
  ResponseModel({
    required this.data,
    required this.type,
    this.popupText,
    this.inLogin = false,
  });

  final ParentModel data;
  final PopupNotificationType type;
  final String? popupText;
  bool inLogin;

  String get getPopupText {
    if (data.errorText.isEmpty) {
      return popupText ?? data.popupText;
    } else {
      return data.errorText;
    }
  }

  bool get isError => type == PopupNotificationType.error;

  Color get getBgColor {
    if (isError) {
      return Colors.red;
    } else if (inLogin) {
      return Colors.white;
    } else {
      return Colors.blue;
    }
  }

  Color get getTextColor {
    if (isError) {
      return Colors.white;
    } else if (inLogin) {
      return Colors.blue;
    } else {
      return Colors.white;
    }
  }

  Widget get icon {
    return Icon(isError ? Icons.error : Icons.check, size: 16, color: getTextColor);
  }
}
