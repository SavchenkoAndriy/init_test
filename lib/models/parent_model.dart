import '../../helpers/storage.dart';
import 'response_model.dart';

abstract class ParentModel {
  bool validate() => true;

  String? token;

  Future<void> setToken() async => token = await SecureStorage.getToken();

  ResponseModel buildResponse({String? responseText, PopupNotificationType? responseType, bool? isLogin}) {
    return ResponseModel(
      data: this,
      type: responseType ?? type,
      popupText: responseText,
      inLogin: isLogin ?? false,
    );
  }

  String get popupText => errorText.isNotEmpty ? errorText : 'Successfully';

  PopupNotificationType get type {
    return errorText.isNotEmpty ? PopupNotificationType.error : PopupNotificationType.success;
  }

  String errorText = '';

  void cleanErrors();
}

class EmptyModel extends ParentModel {
  @override
  void cleanErrors() {}
}
